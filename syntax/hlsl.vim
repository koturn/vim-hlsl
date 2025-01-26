" Vim syntax file for HLSL
" Language: HLSL
" Maintainer: koturn <jeak.koutan.apple@gmail.com>

if v:version < 600
  syntax clear
elseif exists('b:current_syntax')
  finish
endif

syntax keyword hlslStorageClass extern static uniform volatile export shared groupshared inline precise in out inout
syntax keyword hlslTypeModifier const row_major col_major snorm unorm
syntax keyword hlslInterpolationModifier linear centroid nointerpolation noperspective sample

syntax keyword hlslStatement
      \ return discard break continue
      \ asm stateblock stateblock_state compile_fragment asm_fragment pixelfragment vertexfragment
      \ technique technique10 technique11 pass
syntax keyword hlslConditional if else switch
syntax keyword hlslRepeat while for do
syntax keyword hlslLabel case default

syntax region hlslDefine
      \ start=/^\s*\zs#\s*\%(define\|undef\)\>/ skip=/\\$/ end=/$/
      \ keepend contains=ALLBUT,hlslConditional
syntax region hlslPreCondit
      \ start=/^\s*\zs#\s*\%(if\%(n\?def\)\?\|e\%(l\%(if\|se\)\|ndif\)\)\>/ skip=/\\$/ end=/$/
      \ keepend contains=ALLBUT,hlslConditional
syntax region hlslPreProc
      \ start=/^\s*\zs#\s*\%(include\|pragma\|line\|error\)\>/ skip=/\\$/ end=/$/
      \ keepend contains=ALLBUT,hlslConditional

syntax keyword hlslStructure namespace typedef struct class interface cbuffer tbuffer
syntax match hlslType display /\<\%(\%(float\|u\?int\)\%(\%(16\|32\|64\)_t\)\?\|min1\%(0float\|2int\|6\%(float\|u\?int\)\)\|bool\|half\|d\%(ouble\|word\)\)\%([1-4]\%(x[1-4]\)\?\)\?\>/
syntax keyword hlslType
      \ void vector matrix unsigned
      \ Buffer ConstantBuffer ByteAddressBuffer ConsumeStructuredBuffer StructuredBuffer
      \ AppendStructuredBuffer RWBuffer RWByteAddressBuffer RWStructuredBuffer
      \ RasterizerOrderedBuffer RasterizerOrderedByteAddressBuffer RasterizerOrderedStructuredBuffer
      \ SurfaceOutput PointStream LineStream TriangleStream point line triangle lineadj triangleadj
      \ SamplerState SamplerComparisonState InputPatch OutputPatch
      \ sampler2D samplerCUBE sampler3D
      \ Texture1D Texture1DArray
      \ Texture2D Texture2DArray
      \ Texture2DMS Texture2DMSArray
      \ Texture3D TextureCube TextureCubeArray
      \ RWTexture1D
      \ RWTexture2D RWTexture2DArray
      \ RWTexture2DMS RWTexture2DMSArray
      \ RWTexture3D RWTextureCubeArray

syntax region hlslString start=/"/ skip=/\\./ end=/"/
syntax match hlslDecimalNumber display /\<\%(0\|[1-9]\d*\)\%([uU][lL]\?\|[lL][uU]\?\)\?\>/
syntax match hlslOctalNumber display /\<0[0-3]\o\+\%([uU][lL]\?\|[lL][uU]\?\)\?\>/
syntax match hlslHexNumber display /\<0x\x\+\%([uU][lL]\?\|[lL][uU]\?\)\?\>/
syntax match hlslFloat display /\%(\%(\<\d\+\.\%(\d\+\)\?\|\.\d\+\)\%([eE][+-]\?\d\+\)\?\|\d\+[eE][+-]\?\d\+\)[fhlFHL]\?\>/
syntax match hlslOperator display /\m\%(\(+\|-\|&\||\)\%(\1\|=\)\?\|\%(\*\|\/\|%\|\^\|=\|!\|<<\?\|>>\?\)=\?\|?\)/
syntax match hlslSwizzleOperator display /\.\s*\<\%([xyzw]\{1,4\}\|[rgba]\{1,4\}\|[stpq]\{1,4\}\)\>/
syntax match hlslMatrixSwizzleOperator display /\.\s*\<\%(_m[0-3][0-3]\)\{1,4\}\|\%(_[1-4][1-4]\{1,4\}\)\>/

syntax region hlslCommentL start=/\/\// skip=/\\$/ end=/$/ display keepend contains=@Spell
if get(g:, 'hlsl_no_comment_fold', 0)
  syntax region hlslComment matchgroup=hlslCommentStart start=/\/\*/ end=/\*\// contains=hlslCommentStartError,@Spell extend
  syntax region hlslComment matchgroup=hlslCommentStart start=/^\s*\zs#\s*\%(el\)\?if\s\+0/ end=/^\s*\zs#\s*e\%(l\%(if\|se\)\|ndif\)\>/ contains=hlslCommentStartError,@Spell extend
else
  syntax region hlslComment matchgroup=hlslCommentStart start=/\/\*/ end=/\*\// contains=hlslCommentStartError,@Spell fold extend
  syntax region hlslComment matchgroup=hlslCommentStart start=/^\s*\zs#\s*\%(el\)\?if\s\+0/ end=/^\s*\zs#\s*e\%(l\%(if\|se\)\|ndif\)\>/ contains=hlslCommentStartError,@Spell fold extend
endif
syntax match hlslCommentError display /\*\//
syntax match hlslCommentStartError display /\/\*/me=e-1 contained

syntax match hlslAttribute display /\[\s*\<\%(allow_uav_condition\|branch\|call\|fastopt\|flatten\|forcecase\|loop\|WaveOpsIncludeHelperLanes\)\>\s*\]/
syntax match hlslAttribute display /\[\s*\<unroll\>\%(\s*(\s*\d\+\s*)\)\?\s*\]/
syntax match hlslAttribute display /\[\s*\<\%(maxvertexcount\|outputcontrolpoints\)\>\s*(\s*\d\+\s*)\s*\]/
syntax match hlslAttribute display /\[\s*\<\%(domain\|partitioning\|outputtopology\|patchconstantfunc\)\>\s*(\s*"[^"]*"\s*)\s*\]/

syntax keyword hlslConstant NULL ComputeShader DomainShader GeometryShader HullShader PixelShader VertexShader
syntax keyword hlslBoolean true false
syntax keyword hlslAccess this
syntax keyword hlslProfile
      \ vs_1_1
      \ ps_2_0 ps_2_x vs_2_0 vs_2_x ps_4_0_level_9_0 ps_4_0_level_9_1 ps_4_0_level_9_3 vs_4_0_level_9_0 vs_4_0_level_9_1 vs_4_0_level_9_3 lib_4_0_level_9_1 lib_4_0_level_9_3
      \ ps_3_0 vs_3_0
      \ cs_4_0 gs_4_0 ps_4_0 vs_4_0 cs_4_1 gs_4_1 ps_4_1 vs_4_1 lib_4_0 lib_4_1
      \ cs_5_0 ds_5_0 gs_5_0 hs_5_0 ps_5_0 vs_5_0 lib_5_0
      \ cs_6_0 ds_6_0 gs_6_0 hs_6_0 ps_6_0 vs_6_0 lib_6_0

syntax keyword hlslSemantics
      \ FOG
      \ POSITIONT
      \ VFACE
      \ VPOS
      \ SV_CullPrimitive
      \ SV_Coverage
      \ SV_Depth
      \ SV_DepthGreaterEqual
      \ SV_DepthLessEqual
      \ SV_DispatchGrid
      \ SV_DispatchThreadID
      \ SV_DomainLocation
      \ SV_GroupID
      \ SV_GroupIndex
      \ SV_GroupThreadID
      \ SV_GSInstanceID
      \ SV_InnerCoverage
      \ SV_InsideTessFactor
      \ SV_InstanceID
      \ SV_IsFrontFace
      \ SV_OutputControlPointID
      \ SV_Position
      \ SV_POSITION
      \ SV_PrimitiveID
      \ SV_RenderTargetArrayIndex
      \ SV_SampleIndex
      \ SV_StencilRef
      \ SV_TessFactor
      \ SV_VertexID
      \ SV_ViewportArrayIndex
      \ SV_ShadingRate
syntax match hlslSemantics display /\<\%(\%(BINORMAL\|BLEND\%(INDICES\|WEIGHT\)\|COLOR\|DEPTH\|NORMAL\|POSITION\|PSIZE\|TANGENT\|TESSFACTOR\|TEXCOORD\)\d*\|SV_\%(\%(Barycentrics[01]\?\|C\%(lip\|ull\)Distance\)\d*\|Target[0-7]\?\)\)\>/
syntax match hlslSemantics display /\<packoffset\>\s*(\s*c\d\+\(\.[xyzw]\)\?\s*)/

syntax keyword hlslFunction
      \ combine
      \ SetTexture
syntax keyword hlslFunction1
      \ abs
      \ acos
      \ all
      \ any
      \ asin
      \ atan
      \ atan2
      \ ceil
      \ clamp
      \ clip
      \ cos
      \ cosh
      \ cross
      \ D3DCOLORtoUBYTE4
      \ degrees
      \ determinant
      \ distance
      \ dot
      \ exp
      \ exp2
      \ faceforward
      \ floor
      \ fmod
      \ frac
      \ isfinite
      \ isinf
      \ isnan
      \ ldexp
      \ length
      \ lerp
      \ lit
      \ log
      \ log10
      \ log2
      \ max
      \ min
      \ modf
      \ mul
      \ noise
      \ normalize
      \ pow
      \ radians
      \ reflect
      \ refract
      \ round
      \ rsqrt
      \ saturate
      \ sign
      \ sin
      \ sincos
      \ sinh
      \ smoothstep
      \ sqrt
      \ step
      \ tan
      \ tanh
      \ tex1D
      \ tex2D
      \ tex2DArray
      \ tex3D
      \ texCUBE
      \ transpose
      \ trunc
syntax keyword hlslFunction2
      \ ddx
      \ ddy
      \ frexp
      \ fwidth
      \ tex1Dbias
      \ tex1Dgrad
      \ tex1Dproj
      \ tex2Dbias
      \ tex2Dgrad
      \ tex2Dproj
      \ tex2DArraybias
      \ tex2DArraygrad
      \ tex2DArrayproj
      \ tex3Dbias
      \ tex3Dgrad
      \ tex3Dproj
      \ texCUBEbias
      \ texCUBEgrad
      \ texCUBEproj
syntax keyword hlslFunction3
      \ tex1Dlod
      \ tex2Dlod
      \ tex2DArraylod
      \ tex3Dlod
      \ texCUBElod
syntax keyword hlslFunction4
      \ abort
      \ asfloat
      \ asint
      \ asuint
      \ errorf
      \ GetRenderTargetSampleCount
      \ GetRenderTargetSamplePosition
      \ printf
syntax keyword hlslFunction5
      \ AllMemoryBarrier
      \ AllMemoryBarrierWithGroupSync
      \ asdouble
      \ CheckAccessFullyMapped
      \ countbits
      \ ddx_coarse
      \ ddx_fine
      \ ddy_coarse
      \ ddy_fine
      \ DeviceMemoryBarrier
      \ DeviceMemoryBarrierWithGroupSync
      \ dst
      \ EvaluateAttributeAtCentroid
      \ EvaluateAttributeAtSample
      \ EvaluateAttributeSnapped
      \ f16tof32
      \ f32tof16
      \ firstbithigh
      \ firstbitlow
      \ fma
      \ GroupMemoryBarrier
      \ GroupMemoryBarrierWithGroupSync
      \ InterlockedAdd
      \ InterlockedAnd
      \ InterlockedCompareExchange
      \ InterlockedCompareStore
      \ InterlockedExchange
      \ InterlockedMax
      \ InterlockedMin
      \ InterlockedOr
      \ InterlockedXor
      \ mad
      \ msad4
      \ Process2DQuadTessFactorsAvg
      \ Process2DQuadTessFactorsMax
      \ Process2DQuadTessFactorsMin
      \ ProcessIsolineTessFactors
      \ ProcessQuadTessFactorsAvg
      \ ProcessQuadTessFactorsMax
      \ ProcessQuadTessFactorsMin
      \ ProcessTriTessFactorsAvg
      \ ProcessTriTessFactorsMax
      \ ProcessTriTessFactorsMin
      \ rcp
      \ reversebits

if !get(g:, 'hlsl_no_unity', 0)
  syntax keyword hlslUnityVariable
        \ _GrabTexture
  syntax keyword hlslUnityMacro
        \ SHADER_TARGET
        \ SHADER_API_D3D11
        \ SHADER_API_GLCORE
        \ SHADER_API_GLES
        \ SHADER_API_GLES3
        \ SHADER_API_METAL
        \ SHADER_API_VULKAN
        \ SHADER_API_D3D11_9X
        \ SHADER_API_PS4
        \ SHADER_API_XBOXONE
        \ UNITY_NO_SCREENSPACE_SHADOWS
        \ UNITY_NO_RGBM
        \ UNITY_NO_DXT5nm
        \ UNITY_FRAMEBUFFER_FETCH_AVAILABLE
        \ UNITY_HALF_TEXEL_OFFSET
        \ UNITY_MIGHT_NOT_HAVE_DEPTH_Texture
        \ UNITY_PASS_FORWARDBASE
        \ UNITY_PASS_FORWARDADD
        \ UNITY_PASS_DEFERRED
        \ UNITY_PASS_SHADOWCASTER
        \ UNITY_PASS_PREPASSBASE
        \ UNITY_PASS_PREPASSFINAL
        \ UNITY_SHADER_NO_UPGRADE
  " UnityHLSLSupport.cginc
  if !get(g:, 'hlsl_no_hlsl_support', 0)
    syntax match hlslHlslSupportAttribute display /\[\s*\<UNITY_\%(domain\|partitioning\|outputtopology\|patchconstantfunc\)\>\s*(\s*"[^"]*"\s*)\s*\]/
    syntax keyword hlslHlslSupportAttribute UNITY_BRANCH UNITY_FLATTEN UNITY_UNROLL UNITY_LOOP UNITY_FASTOPT
    syntax match hlslHlslSupportAttribute display /\[\s*\<UNITY_outputcontrolpoints\>\s*(\s*\d\+\s*)\s*\]/
    syntax match hlslHlslSupportType display /\<\%(fixed\)\%(\([2-4]\)\%(x\1\)\?\)\?\>/
    syntax match hlslHlslSupportType display /\<sampler\%(2D\|CUBE\|3D\)_\%(half\|float\)\>/
    syntax match hlslHlslSupportType display /\<Texture\%(2D\%(Array\|MS\)\?\|Cube\%(Array\)\?\|3D\)_\%(half\|float\)\>/
    syntax keyword hlslHlslSupportMacro
          \ UNITY_NO_LINEAR_COLORSPACE
          \ UNITY_USE_RGBA_FOR_POINT_SHADOWS
          \ UNITY_POSITION
          \ UNITY_ATTEN_CHANNEL
          \ UNITY_UV_STARTS_AT_TOP
          \ UNITY_PROJ_COORD
          \ UNITY_CAN_COMPILE_TESSELLATION
          \ UNITY_INITIALIZE_OUTPUT
          \ UNITY_COMPILER_HLSL
          \ UNITY_COMPILER_HLSL2GLSL
          \ UNITY_COMPILER_CG
          \ UNITY_DECLARE_SHADOWMAP
          \ UNITY_DECLARE_TEX2D
          \ UNITY_DECLARE_TEX2D_HALF
          \ UNITY_DECLARE_TEX2D_FLOAT
          \ UNITY_DECLARE_TEX2D_NOSAMPLER
          \ UNITY_DECLARE_TEX2D_NOSAMPLER_HALF
          \ UNITY_DECLARE_TEX2D_NOSAMPLER_FLOAT
          \ UNITY_DECLARE_TEX2D_NOSAMPLER_INT
          \ UNITY_DECLARE_TEX2D_NOSAMPLER_UINT
          \ UNITY_DECLARE_TEX2DARRAY
          \ UNITY_DECLARE_TEX2DARRAY_NOSAMPLER
          \ UNITY_DECLARE_TEX2DARRAY_MS
          \ UNITY_DECLARE_TEX2DARRAY_MS_NOSAMPLER
          \ UNITY_DECLARE_TEX3D
          \ UNITY_DECLARE_TEX3D_HALF
          \ UNITY_DECLARE_TEX3D_FLOAT
          \ UNITY_DECLARE_TEX3D_NOSAMPLER
          \ UNITY_DECLARE_TEX3DARRAY
          \ UNITY_DECLARE_TEXCUBE_SHADOWMAP
          \ UNITY_DECLARE_TEXCUBE
          \ UNITY_DECLARE_TEXCUBE_NOSAMPLER
          \ UNITY_DECLARE_TEXCUBEARRAY
          \ UNITY_DECLARE_TEXCUBEARRAY_NOSAMPLER
          \ UNITY_DECLARE_SCREENSPACE_SHADOWMAP
          \ UNITY_DECLARE_DEPTH_TEXTURE_MS
          \ UNITY_DECLARE_DEPTH_TEXTURE
          \ UNITY_DECLARE_SCREENSPACE_TEXTURE
          \ UNITY_VERTEX_INPUT_INSTANCE_ID
          \ CBUFFER_START
          \ CBUFFER_END
          \ GLOBAL_CBUFFER_START
          \ GLOBAL_CBUFFER_END
    syntax keyword hlslHlslSupportMacroFunction
          \ SAMPLE_DEPTH_TEXTURE
          \ SAMPLE_DEPTH_TEXTURE_PROJ
          \ SAMPLE_DEPTH_TEXTURE_LOD
          \ SAMPLE_RAW_DEPTH_TEXTURE
          \ SAMPLE_RAW_DEPTH_TEXTURE_PROJ
          \ SAMPLE_RAW_DEPTH_TEXTURE_LOD
          \ SAMPLE_DEPTH_CUBE_TEXTURE
          \ UNITY_PROJ_COORD
          \ UNITY_SAMPLE_DEPTH
          \ UNITY_SAMPLE_SHADOW
          \ UNITY_SAMPLE_SHADOW_PROJ
          \ UNITY_SAMPLE_TEXCUBE_SHADOW
          \ UNITY_SAMPLE_TEX2D
          \ UNITY_SAMPLE_TEX2D_SAMPLER
          \ UNITY_SAMPLE_TEX2DARRAY
          \ UNITY_SAMPLE_TEX2DARRAY_LOD
          \ UNITY_SAMPLE_TEX2DARRAY_SAMPLER
          \ UNITY_SAMPLE_TEX2DARRAY_SAMPLER_LOD
          \ UNITY_SAMPLE_TEX3D
          \ UNITY_SAMPLE_TEX3D_LOD
          \ UNITY_SAMPLE_TEX3D_SAMPLER
          \ UNITY_SAMPLE_TEX3D_SAMPLER_LOD
          \ UNITY_SAMPLE_TEX3DARRAY
          \ UNITY_SAMPLE_TEX3DARRAY_LOD
          \ UNITY_SAMPLE_TEXCUBE
          \ UNITY_SAMPLE_TEXCUBE_LOD
          \ UNITY_SAMPLE_TEXCUBE_SAMPLER
          \ UNITY_SAMPLE_TEXCUBE_SAMPLER_LOD
          \ UNITY_SAMPLE_TEXCUBEARRAY
          \ UNITY_SAMPLE_TEXCUBEARRAY_LOD
          \ UNITY_SAMPLE_TEXCUBEARRAY_SAMPLER
          \ UNITY_SAMPLE_TEXCUBEARRAY_SAMPLER_LOD
          \ SampleCubeReflection
          \ UNITY_READ_FRAMEBUFFER_INPUT
          \ UNITY_READ_FRAMEBUFFER_INPUT_MS
          \ UNITY_SAMPLE_1CHANNEL
          \ UNITY_SAMPLE_SCREEN_SHADOW
          \ UNITY_SAMPLE_SCREENSPACE_TEXTURE
          \ texRECT
          \ texRECTlod
          \ texRECTbias
          \ texRECTproj
    syntax keyword hlslHlslSupportMacroConstant
          \ UNITY_ALLOWED_MRT_COUNT
          \ UNITY_MATRIX_TEXTURE0
          \ UNITY_MATRIX_TEXTURE1
          \ UNITY_MATRIX_TEXTURE2
          \ UNITY_MATRIX_TEXTURE3
          \ UNITY_NEAR_CLIP_VALUE
  endif
  " UnityShaderVariables.cginc
  if !get(g:, 'hlsl_no_unity_shader_variables', 0)
    syntax keyword hlslUnityShaderVariablesVariable
          \ glstate_matrix_projection
          \ unity_MatrixV
          \ unity_MatrixInvV
          \ unity_MatrixVP
          \ _Time
          \ _SinTime
          \ _CosTime
          \ unity_DeltaTime
          \ _WorldSpaceCameraPos
          \ _ProjectionParams
          \ _ScreenParams
          \ _ZBufferParams
          \ unity_OrthoParams
          \ unity_HalfStereoSeparation
          \ unity_CameraWorldClipPlanes
          \ unity_CameraProjection
          \ unity_CameraInvProjection
          \ unity_WorldToCamera
          \ unity_CameraToWorld
          \ _WorldSpaceLightPos0
          \ _LightPositionRange
          \ _LightProjectionParams
          \ unity_4LightPosX0
          \ unity_4LightPosY0
          \ unity_4LightPosZ0
          \ unity_4LightAtten0
          \ unity_LightColor
          \ unity_LightPosition
          \ unity_LightAtten
          \ unity_SpotDirection
          \ unity_SHAr
          \ unity_SHAg
          \ unity_SHAb
          \ unity_SHBr
          \ unity_SHBg
          \ unity_SHBb
          \ unity_SHC
          \ unity_OcclusionMaskSelector
          \ unity_ProbesOcclusion
          \ unity_LightColor0
          \ unity_LightColor1
          \ unity_LightColor2
          \ unity_LightColor3
          \ unity_ShadowSplitSpheres
          \ unity_ShadowSplitSqRadii
          \ unity_LightShadowBias
          \ _LightSplitsNear
          \ _LightSplitsFar
          \ unity_WorldToShadow
          \ _LightShadowData
          \ unity_ShadowFadeCenterAndType
          \ unity_ObjectToWorld
          \ unity_WorldToObject
          \ unity_LODFade
          \ unity_WorldTransformParams
          \ unity_RenderingLayer
          \ unity_StereoMatrixP
          \ unity_StereoMatrixV
          \ unity_StereoMatrixInvV
          \ unity_StereoMatrixVP
          \ unity_StereoCameraProjection
          \ unity_StereoCameraInvProjection
          \ unity_StereoWorldToCamera
          \ unity_StereoCameraToWorld
          \ unity_StereoWorldSpaceCameraPos
          \ unity_StereoScaleOffset
          \ unity_StereoEyeIndices
          \ unity_StereoEyeIndex
          \ glstate_matrix_transpose_modelview0
          \ glstate_lightmodel_ambient
          \ unity_AmbientSky
          \ unity_AmbientEquator
          \ unity_AmbientGround
          \ unity_IndirectSpecColor
          \ glstate_matrix_projection
          \ unity_ShadowColor
          \ unity_FogColor
          \ unity_FogParams
          \ unity_LightmapST
          \ unity_DynamicLightmapST
          \ unity_SpecCube0
          \ unity_SpecCube0_BoxMax
          \ unity_SpecCube0_BoxMin
          \ unity_SpecCube0_ProbePosition
          \ unity_SpecCube0_HDR
          \ unity_SpecCube1
          \ unity_SpecCube1_BoxMax
          \ unity_SpecCube1_BoxMin
          \ unity_SpecCube1_ProbePosition
          \ unity_SpecCube1_HDR
          \ unity_ProbeVolumeSH
          \ unity_ProbeVolumeParams
          \ unity_ProbeVolumeWorldToObject
          \ unity_ProbeVolumeSizeInv
          \ unity_ProbeVolumeMin
          \ unity_Lightmap
          \ unity_LightmapInd
          \ unity_ShadowMask
          \ unity_DynamicLightmap
          \ unity_DynamicDirectionality
          \ unity_DynamicNormal
          \ unity_MatrixMVP
          \ unity_MatrixMV
          \ unity_MatrixTMV
          \ unity_MatrixITMV
    syntax keyword hlslUnityShaderVariablesMacroVariable
          \ UNITY_MATRIX_P
          \ UNITY_MATRIX_V
          \ UNITY_MATRIX_I_V
          \ UNITY_MATRIX_VP
          \ UNITY_MATRIX_M
          \ UNITY_LIGHTMODEL_AMBIENT
          \ UNITY_MATRIX_MVP
          \ UNITY_MATRIX_MV
          \ UNITY_MATRIX_T_MV
          \ UNITY_MATRIX_IT_MV
  endif
  " UnityCG.cginc
  if !get(g:, 'hlsl_no_unitycg', 0)
    syntax keyword hlslUnityCGType
          \ appdata_base
          \ appdata_tan
          \ appdata_full
          \ appdata_img
          \ v2f_vertex_lit
          \ v2f_img
    syntax keyword hlslUnityCGMacro
          \ TANGENT_SPACE_ROTATION
          \ V2F_SHADOW_CASTER_NOPOS
          \ TRANSFER_SHADOW_CASTER_NOPOS_LEGACY
          \ TRANSFER_SHADOW_CASTER_NOPOS
          \ SHADOW_CASTER_FRAGMENT
          \ V2F_SHADOW_CASTER
          \ TRANSFER_SHADOW_CASTER_NORMALOFFSET
          \ TRANSFER_SHADOW_CASTER
          \ UNITY_OPAQUE_ALPHA
          \ UNITY_CALC_FOG_FACTOR_RAW
          \ UNITY_CALC_FOG_FACTOR
          \ UNITY_FOG_COORDS_PACKED
          \ UNITY_FOG_COORDS
          \ UNITY_TRANSFER_FOG
          \ UNITY_TRANSFER_FOG_COMBINED_WITH_TSPACE
          \ UNITY_TRANSFER_FOG_COMBINED_WITH_WORLD_POS
          \ UNITY_TRANSFER_FOG_COMBINED_WITH_EYE_VEC
          \ UNITY_FOG_LERP_COLOR
          \ UNITY_APPLY_FOG_COLOR
          \ UNITY_EXTRACT_FOG
          \ UNITY_EXTRACT_FOG_FROM_TSPACE
          \ UNITY_EXTRACT_FOG_FROM_WORLD_POS
          \ UNITY_EXTRACT_FOG_FROM_EYE_VEC
          \ UNITY_APPLY_FOG
          \ UNITY_EXTRACT_TBN_0
          \ UNITY_EXTRACT_TBN_1
          \ UNITY_EXTRACT_TBN_2
          \ UNITY_EXTRACT_TBN
          \ UNITY_EXTRACT_TBN_T
          \ UNITY_EXTRACT_TBN_N
          \ UNITY_EXTRACT_TBN_B
          \ UNITY_CORRECT_TBN_B_SIGN
          \ UNITY_RECONSTRUCT_TBN_0
          \ UNITY_RECONSTRUCT_TBN_1
          \ UNITY_RECONSTRUCT_TBN_2
          \ UNITY_RECONSTRUCT_TBN
          \ UNITY_DITHER_CROSSFADE_COORDS
          \ UNITY_DITHER_CROSSFADE_COORDS_IDX
          \ UNITY_TRANSFER_DITHER_CROSSFADE
          \ UNITY_TRANSFER_DITHER_CROSSFADE_HPOS
          \ V2F_SHADOW_COLLECTOR
          \ TRANSFER_SHADOW_COLLECTOR
          \ SAMPLE_SHADOW_COLLECTOR_SHADOW
          \ COMPUTE_SHADOW_COLLECTOR_SHADOW
          \ SHADOW_COLLECTOR_FRAGMENT
          \ UNITY_TRANSFER_DEPTH
          \ UNITY_OUTPUT_DEPTH
    syntax keyword hlslUnityCGMacroType
          \ V2F_SCREEN_TYPE
          \ UNITY_VPOS_TYPE
    syntax keyword hlslUnityCGMacroSemantics
          \ FOGC
    syntax keyword hlslUnityCGMacroConstant
          \ UNITY_PI
          \ UNITY_TWO_PI
          \ UNITY_FOUR_PI
          \ UNITY_INV_PI
          \ UNITY_INV_TWO_PI
          \ UNITY_INV_FOUR_PI
          \ UNITY_HALF_PI
          \ UNITY_INV_HALF_PI
          \ LIGHTMAP_RGBM_SCALE
          \ EMISSIVE_RGBM_SCALE
    syntax keyword hlslUnityCGMacroVariable
          \ COMPUTE_DEPTH_01
          \ COMPUTE_VIEW_NORMAL
    syntax keyword hlslUnityCGMacroFunction
          \ TRANSFORM_TEX
          \ TRANSFORM_UV
          \ UnityStereoScreenSpaceUVAdjust
          \ DECODE_EYEDEPTH
          \ COMPUTE_EYEDEPTH
          \ UNITY_Z_0_FAR_FROM_CLIPSPACE
          \ UNITY_APPLY_DITHER_CROSSFADE
    syntax keyword hlslUnityCGConstant
          \ unity_ColorSpaceGrey
          \ unity_ColorSpaceDouble
          \ unity_ColorSpaceDielectricSpec
          \ unity_ColorSpaceLuminance
    syntax keyword hlslUnityCGVariable
          \ unity_Lightmap_HDR
          \ unity_DynamicLightmap_HDR
          \ unity_DitherMask
    syntax keyword hlslUnityCGFunction
          \ IsGammaSpace
          \ GammaToLinearSpaceExact
          \ GammaToLinearSpace
          \ LinearToGammaSpaceExact
          \ LinearToGammaSpace
          \ UnityWorldToClipPos
          \ UnityViewToClipPos
          \ UnityObjectToViewPos
          \ UnityWorldToViewPos
          \ UnityObjectToWorldDir
          \ UnityWorldToObjectDir
          \ UnityObjectToWorldNormal
          \ UnityWorldSpaceLightDir
          \ WorldSpaceLightDir
          \ ObjSpaceLightDir
          \ UnityWorldSpaceViewDir
          \ WorldSpaceViewDir
          \ ObjSpaceViewDir
          \ Shade4PointLights
          \ ShadeVertexLightsFull
          \ ShadeVertexLights
          \ SHEvalLinearL0L1
          \ SHEvalLinearL2
          \ ShadeSH9
          \ ShadeSH3Order
          \ SHEvalLinearL0L1_SampleProbeVolume
          \ ShadeSH12Order
          \ VertexLight
          \ ParallaxOffset
          \ Luminance
          \ LinearRgbToLuminance
          \ UnityEncodeRGBM
          \ DecodeHDR
          \ DecodeLightmapRGBM
          \ DecodeLightmapDoubleLDR
          \ DecodeLightmap
          \ DecodeRealtimeLightmap
          \ DecodeDirectionalLightmap
          \ EncodeFloatRGBA
          \ DecodeFloatRGBA
          \ EncodeFloatRG
          \ DecodeFloatRG
          \ EncodeViewNormalStereo
          \ DecodeViewNormalStereo
          \ EncodeDepthNormal
          \ DecodeDepthNormal
          \ UnpackNormalDXT5nm
          \ UnpackNormalmapRGorAG
          \ UnpackNormal
          \ UnpackNormalWithScale
          \ Linear01Depth
          \ LinearEyeDepth
          \ UnityStereoScreenSpaceUVAdjustInternal
          \ UnityStereoScreenSpaceUVAdjustInternal
          \ TransformStereoScreenSpaceTex
          \ UnityStereoTransformScreenSpaceTex
          \ UnityStereoTransformScreenSpaceTex
          \ UnityStereoClamp
          \ MultiplyUV
          \ vert_img
          \ ComputeNonStereoScreenPos
          \ ComputeScreenPos
          \ ComputeGrabScreenPos
          \ UnityPixelSnap
          \ TransformViewToProjection
          \ TransformViewToProjection
          \ UnityEncodeCubeShadowDepth
          \ UnityDecodeCubeShadowDepth
          \ UnityClipSpaceShadowCasterPos
          \ UnityClipSpaceShadowCasterPos
          \ UnityApplyLinearShadowBias
          \ PackHeightmap
          \ UnpackHeightmap
          \ UnityApplyDitherCrossFade
  endif
  " UnityInstancing.cginc
  if !get(g:, 'hlsl_no_unity_instancing', 0)
    syntax keyword hlslUnityInstancingMacro
          \ UNITY_SUPPORT_INSTANCING
          \ UNITY_SUPPORT_STEREO_INSTANCING
          \ UNITY_INSTANCING_SUPPORT_FLEXIBLE_ARRAY_SIZE
          \ UNITY_INSTANCING_ENABLED
          \ UNITY_PROCEDURAL_INSTANCING_ENABLED
          \ UNITY_STEREO_INSTANCING_ENABLED
          \ UNITY_INSTANCING_CBUFFER_SCOPE_BEGIN
          \ UNITY_INSTANCING_CBUFFER_SCOPE_END
          \ DEFAULT_UNITY_VERTEX_INPUT_INSTANCE_ID
          \ UNITY_VERTEX_INPUT_INSTANCE_ID
          \ DEFAULT_UNITY_VERTEX_OUTPUT_STEREO
          \ DEFAULT_UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO
          \ DEFAULT_UNITY_VERTEX_OUTPUT_STEREO_EYE_INDEX
          \ DEFAULT_UNITY_INITIALIZE_OUTPUT_STEREO_EYE_INDEX
          \ DEFAULT_UNITY_TRANSFER_VERTEX_OUTPUT_STEREO
          \ DEFAULT_UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX
          \ UNITY_VERTEX_OUTPUT_STEREO_EYE_INDEX
          \ UNITY_INITIALIZE_OUTPUT_STEREO_EYE_INDEX
          \ UNITY_VERTEX_OUTPUT_STEREO
          \ UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO
          \ UNITY_TRANSFER_VERTEX_OUTPUT_STEREO
          \ UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX
          \ UNITY_TRANSFER_INSTANCE_ID
          \ UNITY_INSTANCING_BUFFER_START
          \ UNITY_INSTANCING_BUFFER_END
          \ UNITY_DEFINE_INSTANCED_PROP
          \ UNITY_ACCESS_INSTANCED_PROP
          \ UNITY_USE_LODFADE_ARRAY
          \ UNITY_USE_RENDERINGLAYER_ARRAY
          \ UNITY_USE_LIGHTMAPST_ARRAY
          \ UNITY_USE_DYNAMICLIGHTMAPST_ARRAY
          \ UNITY_USE_SHCOEFFS_ARRAYS
    syntax keyword hlslUnityInstancingMacroFunction
          \ UNITY_GET_INSTANCE_ID
          \ DEFAULT_UNITY_SETUP_INSTANCE_ID
          \ UNITY_SETUP_INSTANCE_ID
          \ UnityObjectToClipPosInstanced
    syntax keyword hlslUnityInstancingFunction
          \ UnitySetupInstanceID
          \ UnitySetupCompoundMatrices
          \ UNITY_INSTANCING_PROCEDURAL_FUNC
    syntax keyword hlslUnityInstancingVariable
          \ unity_InstanceID
          \ unity_BaseInstanceID
          \ unity_InstanceCount
          \ unity_MatrixMVP_
          \ unity_MatrixMV_I
          \ unity_MatrixTMV_
          \ unity_MatrixITMV
    syntax keyword hlslUnityInstancingConstant
          \ UNITY_FORCE_MAX_INSTANCE_COUNT
          \ UNITY_MAX_INSTANCE_COUNT
          \ UNITY_INSTANCED_ARRAY_SIZE
          \ UNITY_WORLDTOOBJECTARRAY_CB
  endif
  " UnityShaderUtilities.cginc
  if !get(g:, 'hlsl_no_unity_shader_utilities', 0)
    syntax keyword hlslUnityShaderUtilitiesFunction
          \ ODSOffset
          \ UnityObjectToClipPosODS
          \ UnityObjectToClipPos
          \ UnityGet2DClipping
  endif
  " UnityStandardCore.cginc
  if !get(g:, 'hlsl_no_unity_standard_core', 0)
    syntax keyword hlslUnityStandardCoreFunction
          \ NormalizePerVertexNormal
          \ NormalizePerPixelNormal
          \ MainLight
          \ AdditiveLight
          \ DummyLight
          \ ZeroIndirect
          \ WorldNormal
          \ ExtractTangentToWorldPerPixel
          \ PerPixelWorldNormal
          \ SpecularSetup
          \ RoughnessSetup
          \ MetallicSetup
          \ FragmentSetup
          \ FragmentGI
          \ OutputForward
          \ VertexGIForward
          \ vertForwardBase
          \ fragForwardBaseInternal
          \ fragForwardBase
          \ vertForwardAdd
          \ fragForwardAddInternal
          \ fragForwardAdd
          \ vertDeferred
          \ fragDeferred
          \ FragmentGI
    syntax keyword hlslUnityStandardCoreType
          \ FragmentCommonData
          \ VertexOutputForwardBase
          \ VertexOutputForwardAdd
          \ VertexOutputDeferred
    syntax keyword hlslUnityStandardCoreMacro
          \ IN_VIEWDIR4PARALLAX
          \ IN_VIEWDIR4PARALLAX_FWDADD
          \ IN_WORLDPOS
          \ IN_WORLDPOS_FWDADD
          \ IN_LIGHTDIR_FWDADD
          \ FRAGMENT_SETUP
          \ FRAGMENT_SETUP_FWDADD
    syntax keyword hlslUnityStandardCoreMacroFunction
          \ UNITY_SETUP_BRDF_INPUT
  endif
  " UnityStandardCoreForwardSimple.cginc
  if !get(g:, 'hlsl_no_unity_standard_core_forward_simple', 0)
    syntax keyword hlslUnityStandardCoreForwardSimpleFunction
          \ MetallicSetup_Reflectivity
          \ SpecularSetup_Reflectivity
          \ RoughnessSetup_Reflectivity
          \ TransformToTangentSpace
          \ TangentSpaceLightingInput
          \ vertForwardBaseSimple
          \ FragmentSetupSimple
          \ MainLightSimple
          \ PerVertexGrazingTerm
          \ PerVertexFresnelTerm
          \ LightDirForSpecular
          \ BRDF3DirectSimple
          \ fragForwardBaseSimpleInternal
          \ fragForwardBaseSimple
          \ vertForwardAddSimple
          \ FragmentSetupSimpleAdd
          \ LightSpaceNormal
          \ fragForwardAddSimpleInternal
          \ fragForwardAddSimple
    syntax keyword hlslUnityStandardCoreForwardSimpleType
          \ VertexOutputBaseSimple
          \ VertexOutputForwardAddSimple
    syntax keyword hlslUnityStandardCoreForwardSimpleMacroFunction
          \ JOIN
          \ JOIN2
          \ UNIFORM_REFLECTIVITY
          \ REFLECTVEC_FOR_SPECULAR
  endif
  " UnityStandardInput.cginc
  if !get(g:, 'hlsl_no_unity_standard_input', 0)
    syntax keyword hlslUnityStandardInputFunction
          \ TexCoords
          \ DetailMask
          \ Albedo
          \ Alpha
          \ Occlusion
          \ SpecularGloss
          \ MetallicGloss
          \ MetallicRough
          \ Emission
          \ NormalInTangentSpace
          \ Parallax
    syntax keyword hlslUnityStandardInputType VertexInput
    syntax keyword hlslUnityStandardInputVariable
          \ _Color
          \ _Cutoff
          \ _MainTex
          \ _MainTex_ST
          \ _DetailAlbedoMap
          \ _DetailAlbedoMap_ST
          \ _BumpMap
          \ _BumpScale
          \ _DetailMask
          \ _DetailNormalMap
          \ _DetailNormalMapScale
          \ _SpecGlossMap
          \ _MetallicGlossMap
          \ _Metallic
          \ _Glossiness
          \ _GlossMapScale
          \ _OcclusionMap
          \ _OcclusionStrength
          \ _ParallaxMap
          \ _Parallax
          \ _UVSec
          \ _EmissionColor
          \ _EmissionMap
  endif
  " UnityStandardMeta.cginc
  if !get(g:, 'hlsl_no_unity_standard_meta', 0)
    syntax keyword hlslUnityStandardMetaType
          \ v2f_meta
    syntax keyword hlslUnityStandardMetaFunction
          \ vert_meta
          \ frag_meta
          \ UnityLightmappingAlbedo
  endif
  " UnityStandardUtils.cginc
  if !get(g:, 'hlsl_no_unity_standard_utils', 0)
    syntax keyword hlslUnityStandardUtilsFunction
          \ SpecularStrength
          \ EnergyConservationBetweenDiffuseAndSpecular
          \ OneMinusReflectivityFromMetallic
          \ DiffuseAndSpecularFromMetallic
          \ PreMultiplyAlpha
          \ ParallaxOffset1Step
          \ LerpOneTo
          \ LerpWhiteTo
          \ UnpackScaleNormalDXT5nm
          \ UnpackScaleNormalRGorAG
          \ UnpackScaleNormal
          \ BlendNormals
          \ CreateTangentToWorldPerVertex
          \ ShadeSHPerVertex
          \ ShadeSHPerPixel
          \ BoxProjectedCubemapDirection
          \ CalculateSurfaceGradient
          \ PerturbNormal
          \ CalculateSurfaceNormal
  endif
  " UnityShadowLibrary.cginc
  if !get(g:, 'hlsl_no_unity_shadow_library', 0)
    syntax keyword hlslUnityShadowLibraryMacroType
          \ unityShadowCoord
          \ unityShadowCoord2
          \ unityShadowCoord3
          \ unityShadowCoord4
          \ unityShadowCoord4x4
    syntax keyword hlslUnityShadowLibraryMacroVariable
          \ _ShadowOffsets
          \ _ShadowMapTexture_TexelSize
    syntax keyword hlslUnityShadowLibraryFunction
          \ UnitySampleShadowmap_PCF7x7
          \ UnitySampleShadowmap_PCF5x5
          \ UnitySampleShadowmap_PCF3x3
          \ UnityGetReceiverPlaneDepthBias
          \ UnitySampleShadowmap
          \ SampleCubeDistance
          \ LPPV_SampleProbeOcclusion
          \ UnitySampleBakedOcclusion
          \ UnityGetRawBakedOcclusions
          \ UnityMixRealtimeAndBakedShadows
          \ UnityComputeShadowFadeDistance
          \ UnityComputeShadowFade
          \ UnityGetReceiverPlaneDepthBias
          \ UnityCombineShadowcoordComponents
          \ _UnityInternalGetAreaAboveFirstTexelUnderAIsocelesRectangleTriangle
          \ _UnityInternalGetAreaPerTexel_3TexelsWideTriangleFilter
          \ _UnityInternalGetWeightPerTexel_3TexelsWideTriangleFilter
          \ _UnityInternalGetWeightPerTexel_5TexelsWideTriangleFilter
          \ _UnityInternalGetWeightPerTexel_7TexelsWideTriangleFilter
          \ UnitySampleShadowmap_PCF3x3NoHardwareSupport
          \ UnitySampleShadowmap_PCF3x3Tent
          \ UnitySampleShadowmap_PCF5x5Tent
          \ UnitySampleShadowmap_PCF7x7Tent
          \ UnitySampleShadowmap_PCF3x3Gaussian
          \ UnitySampleShadowmap_PCF5x5Gaussian
          \ UnitySampleShadowmap_PCF3x3
          \ UnitySampleShadowmap_PCF5x5
          \ UnitySampleShadowmap_PCF7x7
  endif
  " AutoLight.cginc
  if !get(g:, 'hlsl_no_autolight', 0)
    syntax keyword hlslAutoLightMacro
          \ SHADOW_COORDS
          \ UNITY_SHADOW_COORDS
          \ UNITY_TRANSFER_SHADOW
          \ UNITY_LIGHT_ATTENUATION
          \ DECLARE_LIGHT_COORD
          \ DECLARE_LIGHT_COORDS
          \ COMPUTE_LIGHT_COORDS
          \ LIGHT_ATTENUATION
          \ UNITY_LIGHTING_COORDS
          \ LIGHTING_COORDS
          \ UNITY_TRANSFER_LIGHTING
          \ TRANSFER_VERTEX_TO_FRAGMENT
    syntax keyword hlslAutoLightMacroVariable
          \ _ShadowMapTexture
          \ _LightTexture0
          \ unity_WorldToLight
          \ _LightTextureB0
    syntax keyword hlslAutoLightMacroFunction
          \ SHADOW_ATTENUATION
          \ UNITY_SHADOW_W
          \ UNITY_READ_SHADOW_COORDS
          \ UNITY_SHADOW_ATTENUATION
    syntax keyword hlslAutoLightFunction
          \ unitySampleShadow
          \ UnityComputeForwardShadows
          \ UnitySpotCookie
          \ UnitySpotAttenuate
  endif
  " Lighting.cginc
  if !get(g:, 'hlsl_no_lighting', 0)
    syntax keyword hlslLightingVariable
          \ UNITY_DIRBASIS
    syntax keyword hlslLightingFunction
          \ UnityLambertLight
          \ LightingLambert
          \ LightingLambert_Deferred
          \ LightingLambert_GI
          \ LightingLambert_PrePass
          \ UnityBlinnPhongLight
          \ LightingBlinnPhong
          \ LightingBlinnPhong_Deferred
          \ LightingBlinnPhong_GI
          \ LightingBlinnPhong_PrePass
          \ DirLightmapDiffuse
    syntax keyword hlslLightingType
          \ UnityTessellationFactors
  endif
  if !get(g:, 'hlsl_no_unity_lighting_common', 0)
    syntax keyword hlslUnityLightingCommonVariable
          \ _LightColor0
          \ _SpecColor
    syntax keyword hlslUnityLightingCommonType
          \ UnityLight
          \ UnityIndirect
          \ UnityGI
          \ UnityGIInput
  endif
  " UnityMetaPass.cginc
  if !get(g:, 'hlsl_no_unity_meta_pass', 0)
    syntax keyword hlslUnityMacroConstant
          \ dieletricMin
          \ dieletricMax
          \ gemsMin
          \ gemsMax
          \ conductorMin
          \ conductorMax
          \ albedoMin
          \ albedoMax
    syntax keyword hlslUnityMetaPassVariable
          \ unity_MetaVertexControl
          \ unity_MetaFragmentControl
          \ unity_VisualizationMode
          \ _CheckPureMetal
          \ _CheckAlbedo
          \ _AlbedoCompareColor
          \ _AlbedoMinLuminance
          \ _AlbedoMaxLuminance
          \ _AlbedoHueTolerance
          \ _AlbedoSaturationTolerance
          \ unity_EditorViz_Texture
          \ unity_EditorViz_Texture_ST
          \ unity_EditorViz_UVIndex
          \ unity_EditorViz_Decode_HDR
          \ unity_EditorViz_ConvertToLinearSpace
          \ unity_EditorViz_ColorMul
          \ unity_EditorViz_ColorAdd
          \ unity_EditorViz_Exposure
          \ unity_EditorViz_LightTexture
          \ unity_EditorViz_LightTextureB
          \ unity_EditorViz_WorldToLight
          \ unity_MaterialValidateLowColor
          \ unity_MaterialValidateHighColor
          \ unity_MaterialValidatePureMetalColor
          \ unity_OneOverOutputBoost
          \ unity_MaxOutputValue
          \ unity_UseLinearSpace
    syntax keyword hlslUnityMetaPassFunction
          \ UnityMeta_RGBToHSVHelper
          \ UnityMeta_RGBToHSV
          \ UnityMeta_pbrAlbedo
          \ UnityMeta_pbrMetalspec
          \ UnityMetaVizUV
          \ UnityMetaVertexPosition
          \ UnityMetaFragment
    syntax keyword hlslUnityMetaPassType
          \ UnityMetaInput
    syntax keyword hlslUnityMetaPassMacroConstant
          \ EDITORVIZ_PBR_VALIDATION_ALBEDO
          \ EDITORVIZ_PBR_VALIDATION_METALSPECULAR
          \ EDITORVIZ_TEXTURE
          \ EDITORVIZ_SHOWLIGHTMASK
          \ PBR_VALIDATION_ALBEDO
          \ PBR_VALIDATION_METALSPECULAR
    syntax keyword hlslUnityMetaPassMacroVariable
          \ unity_EditorViz_ChannelSelect
          \ unity_EditorViz_Color
          \ unity_EditorViz_LightType
  endif
  " UnityPBSLighting.cginc
  if !get(g:, 'hlsl_no_unity_pbs_lighting', 0)
    syntax keyword hlslUnityPBSLightingMacro
          \ UNITY_GLOSSY_ENV_FROM_SURFACE
          \ UNITY_GI
    syntax keyword hlslUnityPBSLightingMacroFunction
          \ UNITY_BRDF_PBS
          \ UNITY_BRDF_GI
    syntax keyword hlslUnityPBSLightingFunction
          \ BRDF_Unity_Indirect
          \ LightingStandard
          \ LightingStandard_Deferred
          \ LightingStandard_GI
          \ LightingStandardSpecular
          \ LightingStandardSpecular_Deferred
          \ LightingStandardSpecular_GI
    syntax keyword hlslUnityPBSLightingType
          \ SurfaceOutputStandard
          \ SurfaceOutputStandardSpecular
  endif
  " UnityStandardBRDF.cginc
  if !get(g:, 'hlsl_no_unity_standard_brdf', 0)
    syntax keyword hlslUnityStandardBRDFFunction
          \ PerceptualRoughnessToRoughness
          \ RoughnessToPerceptualRoughness
          \ SmoothnessToRoughness
          \ SmoothnessToPerceptualRoughness
          \ Pow4
          \ Pow5
          \ FresnelTerm
          \ FresnelLerp
          \ FresnelLerpFast
          \ DisneyDiffuse
          \ SmithVisibilityTerm
          \ SmithBeckmannVisibilityTerm
          \ SmithJointGGXVisibilityTerm
          \ GGXTerm
          \ PerceptualRoughnessToSpecPower
          \ NDFBlinnPhongNormalizedTerm
          \ GetSpecPowToMip
          \ Unity_SafeNormalize
          \ BRDF1_Unity_PBS
          \ BRDF2_Unity_PBS
          \ BRDF3_Unity_PBS
          \ BRDF3_Direct
          \ BRDF3_Indirect
    syntax keyword hlslUnityStandardBRDFVariable
          \ unity_NHxRoughness
  endif
  " UnityGBuffer.cginc
  if !get(g:, 'hlsl_no_unity_g_buffer', 0)
    syntax keyword hlslUnityGBufferFunction
          \ UnityStandardDataToGbuffer
          \ UnityStandardDataFromGbuffer
          \ UnityStandardDataApplyWeightToGbuffer
    syntax keyword hlslUnityGBufferType UnityStandardData
  endif
  " UnityGlobalIllumination.cginc
  if !get(g:, 'hlsl_no_unity_global_illumination', 0)
    syntax keyword hlslUnityGlobalIlluminationFunction
          \ DecodeDirectionalSpecularLightmap
          \ ResetUnityLight
          \ SubtractMainLightWithRealtimeAttenuationFromLightmap
          \ ResetUnityGI
          \ UnityGI_Base
          \ UnityGI_IndirectSpecular
          \ UnityGlobalIllumination
  endif
  " UnityImageBasedLighting.cginc
  if !get(g:, 'hlsl_no_unity_image_based_lighting', 0)
    syntax keyword hlslUnityImageBasedLightingFunction
          \ ReverseBits32
          \ RadicalInverse_VdC
          \ Hammersley2d
          \ Hash
          \ InitRandom
          \ GetLocalFrame
          \ ImportanceSampleCosDir
          \ ImportanceSampleGGXDir
          \ ImportanceSampleLambert
          \ ImportanceSampleGGX
          \ IntegrateLambertDiffuseIBLRef
          \ IntegrateDisneyDiffuseIBLRef
          \ IntegrateSpecularGGXIBLRef
          \ IntegrateDFG
          \ IntegrateLD
          \ UnityGlossyEnvironmentSetup
          \ perceptualRoughnessToMipmapLevel
          \ mipmapLevelToPerceptualRoughness
          \ Unity_GlossyEnvironment
    syntax keyword hlslUnityImageBasedLightingType Unity_GlossyEnvironmentData
  endif
  " UnityCustomRenderTexture.cginc
  if !get(g:, 'hlsl_no_unity_custom_render_texture', 0)
    syntax keyword hlslUnityCustomRenderTextureType
          \ appdata_customrendertexture
          \ appdata_init_customrendertexture
          \ v2f_customrendertexture
          \ v2f_init_customrendertexture
    syntax keyword hlslUnityCustomRenderTextureVariable
          \ CustomRenderTextureCenters
          \ CustomRenderTextureSizesAndRotations
          \ CustomRenderTexturePrimitiveIDs
          \ CustomRenderTextureParameters
          \ _CustomRenderTextureInfo
          \ _SelfTexture2D
          \ _SelfTextureCube
          \ _SelfTexture3D
    syntax keyword hlslUnityCustomRenderTextureMacroConstant
          \ kCustomTextureBatchSize
    syntax keyword hlslUnityCustomRenderTextureMacroVariable
          \ CustomRenderTextureUpdateSpace
          \ CustomRenderTexture3DTexcoordW
          \ CustomRenderTextureIs3D
          \ _CustomRenderTextureWidth
          \ _CustomRenderTextureHeight
          \ _CustomRenderTextureDepth
          \ _CustomRenderTextureCubeFace
          \ _CustomRenderTexture3DSlice
    syntax keyword hlslUnityCustomRenderTextureFunction
          \ CustomRenderTextureRotate2D
          \ CustomRenderTextureComputeCubeDirection
          \ CustomRenderTextureVertexShader
          \ InitCustomRenderTextureVertexShader
  endif
  if !get(g:, 'hlsl_no_vrchat', 0)
    syntax keyword hlslVRChatVariable
          \ _AudioTexture
          \ _VRChatMirrorMode
          \ _VRChatCameraMode
          \ _VRChatMirrorCameraPos
  endif
endif

" Define the default highlighting.
" For version 5.7 and earlier: only when not done already
" For version 5.8 and later: only when an item doesn't have highlighting yet
if v:version >= 508 || !exists('did_hlsl_syntax_inits')
  if v:version < 508
    let did_hlsl_syntax_inits = 1
    command -nargs=+ HiLink highlight link <args>
  else
    command -nargs=+ HiLink highlight default link <args>
  endif

  HiLink hlslStorageClass StorageClass
  HiLink hlslTypeModifier StorageClass
  HiLink hlslInterpolationModifier StorageClass
  HiLink hlslStatement Statement
  HiLink hlslConditional Conditional
  HiLink hlslRepeat Repeat
  HiLink hlslLabel Label
  HiLink hlslDefine Define
  HiLink hlslPreCondit PreCondit
  HiLink hlslPreProc PreProc
  HiLink hlslStructure Structure
  HiLink hlslType Type
  HiLink hlslAttribute PreProc
  HiLink hlslSemantics Typedef

  HiLink hlslString String
  HiLink hlslDecimalNumber Number
  HiLink hlslOctalNumber Number
  HiLink hlslHexNumber Number
  HiLink hlslFloat Float
  HiLink hlslOperator Operator
  HiLink hlslSwizzleOperator Identifier
  HiLink hlslMatrixSwizzleOperator Identifier

  HiLink hlslFunction Function
  HiLink hlslFunction1 Function
  HiLink hlslFunction2 Function
  HiLink hlslFunction3 Function
  HiLink hlslFunction4 Function
  HiLink hlslFunction5 Function

  HiLink hlslVariable Identifier
  HiLink hlslConstant Constant
  HiLink hlslBoolean Boolean
  HiLink hlslAccess Keyword
  HiLink hlslProfile Statement

  HiLink hlslMacroFunction hlslFunction
  HiLink hlslMacroVariable hlslVariable
  HiLink hlslMacroConstant hlslConstant

  HiLink hlslMacro Macro
  HiLink hlslComment Comment
  HiLink hlslCommentL hlslComment
  HiLink hlslCommentStart hlslComment
  HiLink hlslCommentError Error
  HiLink hlslCommentStartError Error

  if !get(g:, 'hlsl_no_unity', 0)
    HiLink hlslUnityVariable hlslVariable
    HiLink hlslUnityMacro hlslMacro
    if !get(g:, 'hlsl_no_hlsl_support', 0)
      HiLink hlslHlslSupportAttribute hlslAttribute
      HiLink hlslHlslSupportType hlslType
      HiLink hlslHlslSupportMacro hlslMacro
      HiLink hlslHlslSupportMacroFunction hlslMacroFunction
      HiLink hlslHlslSupportMacroConstant hlslMacroConstant
    endif
    if !get(g:, 'hlsl_no_unity_shader_variables', 0)
      HiLink hlslUnityShaderVariablesVariable hlslVariable
      HiLink hlslUnityShaderVariablesMacroVariable hlslMacroVariable
    endif
    if !get(g:, 'hlsl_no_unitycg', 0)
      HiLink hlslUnityCGType hlslType
      HiLink hlslUnityCGMacro hlslMacro
      HiLink hlslUnityCGMacroType hlslType
      HiLink hlslUnityCGMacroSemantics hlslSemantics
      HiLink hlslUnityCGMacroConstant Constant
      HiLink hlslUnityCGMacroVariable hlslVariable
      HiLink hlslUnityCGMacroFunction hlslFunction
      HiLink hlslUnityCGConstant Constant
      HiLink hlslUnityCGVariable hlslVariable
      HiLink hlslUnityCGFunction hlslFunction
    endif
    if !get(g:, 'hlsl_no_unity_instancing', 0)
      HiLink hlslUnityInstancingMacro hlslMacro
      HiLink hlslUnityInstancingMacroFunction hlslMacroFunction
      HiLink hlslUnityInstancingFunction hlslFunction
      HiLink hlslUnityInstancingVariable hlslVariable
      HiLink hlslUnityInstancingConstant hlslConstant
    endif
    if !get(g:, 'hlsl_no_unity_shader_utilities', 0)
      HiLink hlslUnityShaderUtilitiesFunction hlslFunction
    endif
    if !get(g:, 'hlsl_no_unity_standard_core', 0)
      HiLink hlslUnityStandardCoreFunction hlslFunction
      HiLink hlslUnityStandardCoreType hlslType
      HiLink hlslUnityStandardCoreMacro hlslMacro
      HiLink hlslUnityStandardCoreMacroFunction hlslMacroFunction
    endif
    if !get(g:, 'hlsl_no_unity_standard_core_forward_simple', 0)
      HiLink hlslUnityStandardCoreForwardSimpleFunction hlslFunction
      HiLink hlslUnityStandardCoreForwardSimpleType hlslType
      HiLink hlslUnityStandardCoreForwardSimpleMacroFunction hlslMacroFunction
    endif
    if !get(g:, 'hlsl_no_unity_standard_input', 0)
      HiLink hlslUnityStandardInputFunction hlslFunction
      HiLink hlslUnityStandardInputType hlslType
      HiLink hlslUnityStandardInputVariable hlslVariable
    endif
    if !get(g:, 'hlsl_no_unity_standard_meta', 0)
      HiLink hlslUnityStandardMetaType hlslType
      HiLink hlslUnityStandardMetaFunction hlslFunction
    endif
    if !get(g:, 'hlsl_no_unity_standard_utils', 0)
      HiLink hlslUnityStandardUtilsFunction hlslFunction
    endif
    if !get(g:, 'hlsl_no_unity_shadow_library', 0)
      HiLink hlslUnityShadowLibraryMacroType hlslType
      HiLink hlslUnityShadowLibraryMacroVariable hlslVariable
      HiLink hlslUnityShadowLibraryFunction hlslFunction
    endif
    if !get(g:, 'hlsl_no_autolight', 0)
      HiLink hlslAutoLightMacro hlslMacro
      HiLink hlslAutoLightMacroVariable hlslMacroVariable
      HiLink hlslAutoLightMacroFunction hlslAutoLightFunction
      HiLink hlslAutoLightFunction hlslFunction
    endif
    if !get(g:, 'hlsl_no_lighting', 0)
      HiLink hlslLightingVariable hlslVariable
      HiLink hlslLightingFunction hlslFunction
      HiLink hlslLightingType hlslType
    endif
    if !get(g:, 'hlsl_no_unity_lighting_common', 0)
      HiLink hlslUnityLightingCommonVariable hlslVariable
      HiLink hlslUnityLightingCommonType hlslType
    endif
    if !get(g:, 'hlsl_no_unity_meta_pass', 0)
      HiLink hlslUnityMacroConstant hlslConstant
      HiLink hlslUnityMetaPassVariable hlslVariable
      HiLink hlslUnityMetaPassFunction hlslFunction
      HiLink hlslUnityMetaPassType hlslType
      HiLink hlslUnityMetaPassMacroConstant hlslUnityMacroConstant
      HiLink hlslUnityMetaPassMacroVariable hlslMacroVariable
    endif
    if !get(g:, 'hlsl_no_unity_pbs_lighting', 0)
      HiLink hlslUnityPBSLightingMacro hlslFunction
      HiLink hlslUnityPBSLightingMacroFunction hlslUnityPBSLightingFunction
      HiLink hlslUnityPBSLightingFunction hlslFunction
      HiLink hlslUnityPBSLightingType hlslType
    endif
    if !get(g:, 'hlsl_no_unity_standard_brdf', 0)
      HiLink hlslUnityStandardBRDFFunction hlslFunction
      HiLink hlslUnityStandardBRDFVariable hlslVariable
    endif
    if !get(g:, 'hlsl_no_unity_g_buffer', 0)
      HiLink hlslUnityGBufferFunction hlslFunction
      HiLink hlslUnityGBufferType hlslType
    endif
    if !get(g:, 'hlsl_no_unity_global_illumination', 0)
      HiLink hlslUnityGlobalIlluminationFunction hlslFunction
    endif
    if !get(g:, 'hlsl_no_unity_image_based_lighting', 0)
      HiLink hlslUnityImageBasedLightingFunction hlslFunction
      HiLink hlslUnityImageBasedLightingType hlslType
    endif
    if !get(g:, 'hlsl_no_unity_custom_render_texture', 0)
      HiLink hlslUnityCustomRenderTextureType hlslType
      HiLink hlslUnityCustomRenderTextureVariable hlslVariable
      HiLink hlslUnityCustomRenderTextureMacroConstant hlslConstant
      HiLink hlslUnityCustomRenderTextureMacroVariable hlslUnityCustomRenderTextureVariable
      HiLink hlslUnityCustomRenderTextureFunction hlslFunction
    endif
    if !get(g:, 'hlsl_no_vrchat', 0)
      HiLink hlslVRChatVariable hlslVariable
    endif
  endif
  delcommand HiLink
endif

let b:current_syntax = 'hlsl'
