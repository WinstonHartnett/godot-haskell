{-# LANGUAGE DerivingStrategies, GeneralizedNewtypeDeriving,
  TypeFamilies, TypeOperators, FlexibleContexts, DataKinds,
  MultiParamTypeClasses #-}
module Godot.Core.BakedLightmap
       (Godot.Core.BakedLightmap._BAKE_QUALITY_LOW,
        Godot.Core.BakedLightmap._ENVIRONMENT_MODE_CUSTOM_SKY,
        Godot.Core.BakedLightmap._ENVIRONMENT_MODE_SCENE,
        Godot.Core.BakedLightmap._BAKE_ERROR_INVALID_MESH,
        Godot.Core.BakedLightmap._BAKE_ERROR_USER_ABORTED,
        Godot.Core.BakedLightmap._BAKE_ERROR_NO_SAVE_PATH,
        Godot.Core.BakedLightmap._BAKE_ERROR_LIGHTMAP_SIZE,
        Godot.Core.BakedLightmap._BAKE_QUALITY_MEDIUM,
        Godot.Core.BakedLightmap._ENVIRONMENT_MODE_CUSTOM_COLOR,
        Godot.Core.BakedLightmap._BAKE_ERROR_OK,
        Godot.Core.BakedLightmap._BAKE_ERROR_NO_MESHES,
        Godot.Core.BakedLightmap._ENVIRONMENT_MODE_DISABLED,
        Godot.Core.BakedLightmap._BAKE_ERROR_NO_LIGHTMAPPER,
        Godot.Core.BakedLightmap._BAKE_QUALITY_HIGH,
        Godot.Core.BakedLightmap._BAKE_ERROR_CANT_CREATE_IMAGE,
        Godot.Core.BakedLightmap._BAKE_QUALITY_ULTRA,
        Godot.Core.BakedLightmap.bake,
        Godot.Core.BakedLightmap.get_bake_quality,
        Godot.Core.BakedLightmap.get_bias,
        Godot.Core.BakedLightmap.get_bounces,
        Godot.Core.BakedLightmap.get_capture_cell_size,
        Godot.Core.BakedLightmap.get_capture_enabled,
        Godot.Core.BakedLightmap.get_capture_propagation,
        Godot.Core.BakedLightmap.get_capture_quality,
        Godot.Core.BakedLightmap.get_default_texels_per_unit,
        Godot.Core.BakedLightmap.get_environment_custom_color,
        Godot.Core.BakedLightmap.get_environment_custom_energy,
        Godot.Core.BakedLightmap.get_environment_custom_sky,
        Godot.Core.BakedLightmap.get_environment_custom_sky_rotation_degrees,
        Godot.Core.BakedLightmap.get_environment_min_light,
        Godot.Core.BakedLightmap.get_environment_mode,
        Godot.Core.BakedLightmap.get_extents,
        Godot.Core.BakedLightmap.get_image_path,
        Godot.Core.BakedLightmap.get_light_data,
        Godot.Core.BakedLightmap.get_max_atlas_size,
        Godot.Core.BakedLightmap.is_generate_atlas_enabled,
        Godot.Core.BakedLightmap.is_using_color,
        Godot.Core.BakedLightmap.is_using_denoiser,
        Godot.Core.BakedLightmap.is_using_hdr,
        Godot.Core.BakedLightmap.set_bake_quality,
        Godot.Core.BakedLightmap.set_bias,
        Godot.Core.BakedLightmap.set_bounces,
        Godot.Core.BakedLightmap.set_capture_cell_size,
        Godot.Core.BakedLightmap.set_capture_enabled,
        Godot.Core.BakedLightmap.set_capture_propagation,
        Godot.Core.BakedLightmap.set_capture_quality,
        Godot.Core.BakedLightmap.set_default_texels_per_unit,
        Godot.Core.BakedLightmap.set_environment_custom_color,
        Godot.Core.BakedLightmap.set_environment_custom_energy,
        Godot.Core.BakedLightmap.set_environment_custom_sky,
        Godot.Core.BakedLightmap.set_environment_custom_sky_rotation_degrees,
        Godot.Core.BakedLightmap.set_environment_min_light,
        Godot.Core.BakedLightmap.set_environment_mode,
        Godot.Core.BakedLightmap.set_extents,
        Godot.Core.BakedLightmap.set_generate_atlas,
        Godot.Core.BakedLightmap.set_image_path,
        Godot.Core.BakedLightmap.set_light_data,
        Godot.Core.BakedLightmap.set_max_atlas_size,
        Godot.Core.BakedLightmap.set_use_color,
        Godot.Core.BakedLightmap.set_use_denoiser,
        Godot.Core.BakedLightmap.set_use_hdr)
       where
import Data.Coerce
import Foreign.C
import Godot.Internal.Dispatch
import qualified Data.Vector as V
import Linear(V2(..),V3(..),M22)
import Data.Colour(withOpacity)
import Data.Colour.SRGB(sRGB)
import System.IO.Unsafe
import Godot.Gdnative.Internal
import Godot.Api.Types
import Godot.Core.VisualInstance()

_BAKE_QUALITY_LOW :: Int
_BAKE_QUALITY_LOW = 0

_ENVIRONMENT_MODE_CUSTOM_SKY :: Int
_ENVIRONMENT_MODE_CUSTOM_SKY = 2

_ENVIRONMENT_MODE_SCENE :: Int
_ENVIRONMENT_MODE_SCENE = 1

_BAKE_ERROR_INVALID_MESH :: Int
_BAKE_ERROR_INVALID_MESH = 5

_BAKE_ERROR_USER_ABORTED :: Int
_BAKE_ERROR_USER_ABORTED = 6

_BAKE_ERROR_NO_SAVE_PATH :: Int
_BAKE_ERROR_NO_SAVE_PATH = 1

_BAKE_ERROR_LIGHTMAP_SIZE :: Int
_BAKE_ERROR_LIGHTMAP_SIZE = 4

_BAKE_QUALITY_MEDIUM :: Int
_BAKE_QUALITY_MEDIUM = 1

_ENVIRONMENT_MODE_CUSTOM_COLOR :: Int
_ENVIRONMENT_MODE_CUSTOM_COLOR = 3

_BAKE_ERROR_OK :: Int
_BAKE_ERROR_OK = 0

_BAKE_ERROR_NO_MESHES :: Int
_BAKE_ERROR_NO_MESHES = 2

_ENVIRONMENT_MODE_DISABLED :: Int
_ENVIRONMENT_MODE_DISABLED = 0

_BAKE_ERROR_NO_LIGHTMAPPER :: Int
_BAKE_ERROR_NO_LIGHTMAPPER = 7

_BAKE_QUALITY_HIGH :: Int
_BAKE_QUALITY_HIGH = 2

_BAKE_ERROR_CANT_CREATE_IMAGE :: Int
_BAKE_ERROR_CANT_CREATE_IMAGE = 3

_BAKE_QUALITY_ULTRA :: Int
_BAKE_QUALITY_ULTRA = 3

instance NodeProperty BakedLightmap "atlas_generate" Bool 'False
         where
        nodeProperty
          = (is_generate_atlas_enabled,
             wrapDroppingSetter set_generate_atlas, Nothing)

instance NodeProperty BakedLightmap "atlas_max_size" Int 'False
         where
        nodeProperty
          = (get_max_atlas_size, wrapDroppingSetter set_max_atlas_size,
             Nothing)

instance NodeProperty BakedLightmap "bias" Float 'False where
        nodeProperty = (get_bias, wrapDroppingSetter set_bias, Nothing)

instance NodeProperty BakedLightmap "bounces" Int 'False where
        nodeProperty
          = (get_bounces, wrapDroppingSetter set_bounces, Nothing)

instance NodeProperty BakedLightmap "capture_cell_size" Float
           'False
         where
        nodeProperty
          = (get_capture_cell_size, wrapDroppingSetter set_capture_cell_size,
             Nothing)

instance NodeProperty BakedLightmap "capture_enabled" Bool 'False
         where
        nodeProperty
          = (get_capture_enabled, wrapDroppingSetter set_capture_enabled,
             Nothing)

instance NodeProperty BakedLightmap "capture_propagation" Float
           'False
         where
        nodeProperty
          = (get_capture_propagation,
             wrapDroppingSetter set_capture_propagation, Nothing)

instance NodeProperty BakedLightmap "capture_quality" Int 'False
         where
        nodeProperty
          = (get_capture_quality, wrapDroppingSetter set_capture_quality,
             Nothing)

instance NodeProperty BakedLightmap "default_texels_per_unit" Float
           'False
         where
        nodeProperty
          = (get_default_texels_per_unit,
             wrapDroppingSetter set_default_texels_per_unit, Nothing)

instance NodeProperty BakedLightmap "environment_custom_color"
           Color
           'False
         where
        nodeProperty
          = (get_environment_custom_color,
             wrapDroppingSetter set_environment_custom_color, Nothing)

instance NodeProperty BakedLightmap "environment_custom_energy"
           Float
           'False
         where
        nodeProperty
          = (get_environment_custom_energy,
             wrapDroppingSetter set_environment_custom_energy, Nothing)

instance NodeProperty BakedLightmap "environment_custom_sky" Sky
           'False
         where
        nodeProperty
          = (get_environment_custom_sky,
             wrapDroppingSetter set_environment_custom_sky, Nothing)

instance NodeProperty BakedLightmap
           "environment_custom_sky_rotation_degrees"
           Vector3
           'False
         where
        nodeProperty
          = (get_environment_custom_sky_rotation_degrees,
             wrapDroppingSetter set_environment_custom_sky_rotation_degrees,
             Nothing)

instance NodeProperty BakedLightmap "environment_min_light" Color
           'False
         where
        nodeProperty
          = (get_environment_min_light,
             wrapDroppingSetter set_environment_min_light, Nothing)

instance NodeProperty BakedLightmap "environment_mode" Int 'False
         where
        nodeProperty
          = (get_environment_mode, wrapDroppingSetter set_environment_mode,
             Nothing)

instance NodeProperty BakedLightmap "extents" Vector3 'False where
        nodeProperty
          = (get_extents, wrapDroppingSetter set_extents, Nothing)

instance NodeProperty BakedLightmap "image_path" GodotString 'False
         where
        nodeProperty
          = (get_image_path, wrapDroppingSetter set_image_path, Nothing)

instance NodeProperty BakedLightmap "light_data" BakedLightmapData
           'False
         where
        nodeProperty
          = (get_light_data, wrapDroppingSetter set_light_data, Nothing)

instance NodeProperty BakedLightmap "quality" Int 'False where
        nodeProperty
          = (get_bake_quality, wrapDroppingSetter set_bake_quality, Nothing)

instance NodeProperty BakedLightmap "use_color" Bool 'False where
        nodeProperty
          = (is_using_color, wrapDroppingSetter set_use_color, Nothing)

instance NodeProperty BakedLightmap "use_denoiser" Bool 'False
         where
        nodeProperty
          = (is_using_denoiser, wrapDroppingSetter set_use_denoiser, Nothing)

instance NodeProperty BakedLightmap "use_hdr" Bool 'False where
        nodeProperty
          = (is_using_hdr, wrapDroppingSetter set_use_hdr, Nothing)

{-# NOINLINE bindBakedLightmap_bake #-}

-- | Bakes the lightmap, scanning from the given @from_node@ root and saves the resulting @BakedLightmapData@ in @data_save_path@. If no save path is provided it will try to match the path from the current @light_data@.
bindBakedLightmap_bake :: MethodBind
bindBakedLightmap_bake
  = unsafePerformIO $
      withCString "BakedLightmap" $
        \ clsNamePtr ->
          withCString "bake" $
            \ methodNamePtr ->
              godot_method_bind_get_method clsNamePtr methodNamePtr

-- | Bakes the lightmap, scanning from the given @from_node@ root and saves the resulting @BakedLightmapData@ in @data_save_path@. If no save path is provided it will try to match the path from the current @light_data@.
bake ::
       (BakedLightmap :< cls, Object :< cls) =>
       cls -> Maybe Node -> Maybe GodotString -> IO Int
bake cls arg1 arg2
  = withVariantArray
      [maybe VariantNil toVariant arg1,
       defaultedVariant VariantString "" arg2]
      (\ (arrPtr, len) ->
         godot_method_bind_call bindBakedLightmap_bake (upcast cls) arrPtr
           len
           >>= \ (err, res) -> throwIfErr err >> fromGodotVariant res)

instance NodeMethod BakedLightmap "bake"
           '[Maybe Node, Maybe GodotString]
           (IO Int)
         where
        nodeMethod = Godot.Core.BakedLightmap.bake

{-# NOINLINE bindBakedLightmap_get_bake_quality #-}

-- | Determines the amount of samples per texel used in indrect light baking. The amount of samples for each quality level can be configured in the project settings.
bindBakedLightmap_get_bake_quality :: MethodBind
bindBakedLightmap_get_bake_quality
  = unsafePerformIO $
      withCString "BakedLightmap" $
        \ clsNamePtr ->
          withCString "get_bake_quality" $
            \ methodNamePtr ->
              godot_method_bind_get_method clsNamePtr methodNamePtr

-- | Determines the amount of samples per texel used in indrect light baking. The amount of samples for each quality level can be configured in the project settings.
get_bake_quality ::
                   (BakedLightmap :< cls, Object :< cls) => cls -> IO Int
get_bake_quality cls
  = withVariantArray []
      (\ (arrPtr, len) ->
         godot_method_bind_call bindBakedLightmap_get_bake_quality
           (upcast cls)
           arrPtr
           len
           >>= \ (err, res) -> throwIfErr err >> fromGodotVariant res)

instance NodeMethod BakedLightmap "get_bake_quality" '[] (IO Int)
         where
        nodeMethod = Godot.Core.BakedLightmap.get_bake_quality

{-# NOINLINE bindBakedLightmap_get_bias #-}

-- | Raycasting bias used during baking to avoid floating point precission issues.
bindBakedLightmap_get_bias :: MethodBind
bindBakedLightmap_get_bias
  = unsafePerformIO $
      withCString "BakedLightmap" $
        \ clsNamePtr ->
          withCString "get_bias" $
            \ methodNamePtr ->
              godot_method_bind_get_method clsNamePtr methodNamePtr

-- | Raycasting bias used during baking to avoid floating point precission issues.
get_bias ::
           (BakedLightmap :< cls, Object :< cls) => cls -> IO Float
get_bias cls
  = withVariantArray []
      (\ (arrPtr, len) ->
         godot_method_bind_call bindBakedLightmap_get_bias (upcast cls)
           arrPtr
           len
           >>= \ (err, res) -> throwIfErr err >> fromGodotVariant res)

instance NodeMethod BakedLightmap "get_bias" '[] (IO Float) where
        nodeMethod = Godot.Core.BakedLightmap.get_bias

{-# NOINLINE bindBakedLightmap_get_bounces #-}

-- | Number of light bounces that are taken into account during baking.
bindBakedLightmap_get_bounces :: MethodBind
bindBakedLightmap_get_bounces
  = unsafePerformIO $
      withCString "BakedLightmap" $
        \ clsNamePtr ->
          withCString "get_bounces" $
            \ methodNamePtr ->
              godot_method_bind_get_method clsNamePtr methodNamePtr

-- | Number of light bounces that are taken into account during baking.
get_bounces ::
              (BakedLightmap :< cls, Object :< cls) => cls -> IO Int
get_bounces cls
  = withVariantArray []
      (\ (arrPtr, len) ->
         godot_method_bind_call bindBakedLightmap_get_bounces (upcast cls)
           arrPtr
           len
           >>= \ (err, res) -> throwIfErr err >> fromGodotVariant res)

instance NodeMethod BakedLightmap "get_bounces" '[] (IO Int) where
        nodeMethod = Godot.Core.BakedLightmap.get_bounces

{-# NOINLINE bindBakedLightmap_get_capture_cell_size #-}

-- | Grid size used for real-time capture information on dynamic objects.
bindBakedLightmap_get_capture_cell_size :: MethodBind
bindBakedLightmap_get_capture_cell_size
  = unsafePerformIO $
      withCString "BakedLightmap" $
        \ clsNamePtr ->
          withCString "get_capture_cell_size" $
            \ methodNamePtr ->
              godot_method_bind_get_method clsNamePtr methodNamePtr

-- | Grid size used for real-time capture information on dynamic objects.
get_capture_cell_size ::
                        (BakedLightmap :< cls, Object :< cls) => cls -> IO Float
get_capture_cell_size cls
  = withVariantArray []
      (\ (arrPtr, len) ->
         godot_method_bind_call bindBakedLightmap_get_capture_cell_size
           (upcast cls)
           arrPtr
           len
           >>= \ (err, res) -> throwIfErr err >> fromGodotVariant res)

instance NodeMethod BakedLightmap "get_capture_cell_size" '[]
           (IO Float)
         where
        nodeMethod = Godot.Core.BakedLightmap.get_capture_cell_size

{-# NOINLINE bindBakedLightmap_get_capture_enabled #-}

-- | When enabled, an octree containing the scene's lighting information will be computed. This octree will then be used to light dynamic objects in the scene.
bindBakedLightmap_get_capture_enabled :: MethodBind
bindBakedLightmap_get_capture_enabled
  = unsafePerformIO $
      withCString "BakedLightmap" $
        \ clsNamePtr ->
          withCString "get_capture_enabled" $
            \ methodNamePtr ->
              godot_method_bind_get_method clsNamePtr methodNamePtr

-- | When enabled, an octree containing the scene's lighting information will be computed. This octree will then be used to light dynamic objects in the scene.
get_capture_enabled ::
                      (BakedLightmap :< cls, Object :< cls) => cls -> IO Bool
get_capture_enabled cls
  = withVariantArray []
      (\ (arrPtr, len) ->
         godot_method_bind_call bindBakedLightmap_get_capture_enabled
           (upcast cls)
           arrPtr
           len
           >>= \ (err, res) -> throwIfErr err >> fromGodotVariant res)

instance NodeMethod BakedLightmap "get_capture_enabled" '[]
           (IO Bool)
         where
        nodeMethod = Godot.Core.BakedLightmap.get_capture_enabled

{-# NOINLINE bindBakedLightmap_get_capture_propagation #-}

-- | Bias value to reduce the amount of light proagation in the captured octree.
bindBakedLightmap_get_capture_propagation :: MethodBind
bindBakedLightmap_get_capture_propagation
  = unsafePerformIO $
      withCString "BakedLightmap" $
        \ clsNamePtr ->
          withCString "get_capture_propagation" $
            \ methodNamePtr ->
              godot_method_bind_get_method clsNamePtr methodNamePtr

-- | Bias value to reduce the amount of light proagation in the captured octree.
get_capture_propagation ::
                          (BakedLightmap :< cls, Object :< cls) => cls -> IO Float
get_capture_propagation cls
  = withVariantArray []
      (\ (arrPtr, len) ->
         godot_method_bind_call bindBakedLightmap_get_capture_propagation
           (upcast cls)
           arrPtr
           len
           >>= \ (err, res) -> throwIfErr err >> fromGodotVariant res)

instance NodeMethod BakedLightmap "get_capture_propagation" '[]
           (IO Float)
         where
        nodeMethod = Godot.Core.BakedLightmap.get_capture_propagation

{-# NOINLINE bindBakedLightmap_get_capture_quality #-}

-- | Bake quality of the capture data.
bindBakedLightmap_get_capture_quality :: MethodBind
bindBakedLightmap_get_capture_quality
  = unsafePerformIO $
      withCString "BakedLightmap" $
        \ clsNamePtr ->
          withCString "get_capture_quality" $
            \ methodNamePtr ->
              godot_method_bind_get_method clsNamePtr methodNamePtr

-- | Bake quality of the capture data.
get_capture_quality ::
                      (BakedLightmap :< cls, Object :< cls) => cls -> IO Int
get_capture_quality cls
  = withVariantArray []
      (\ (arrPtr, len) ->
         godot_method_bind_call bindBakedLightmap_get_capture_quality
           (upcast cls)
           arrPtr
           len
           >>= \ (err, res) -> throwIfErr err >> fromGodotVariant res)

instance NodeMethod BakedLightmap "get_capture_quality" '[]
           (IO Int)
         where
        nodeMethod = Godot.Core.BakedLightmap.get_capture_quality

{-# NOINLINE bindBakedLightmap_get_default_texels_per_unit #-}

-- | If a baked mesh doesn't have a UV2 size hint, this value will be used to roughly compute a suitable lightmap size.
bindBakedLightmap_get_default_texels_per_unit :: MethodBind
bindBakedLightmap_get_default_texels_per_unit
  = unsafePerformIO $
      withCString "BakedLightmap" $
        \ clsNamePtr ->
          withCString "get_default_texels_per_unit" $
            \ methodNamePtr ->
              godot_method_bind_get_method clsNamePtr methodNamePtr

-- | If a baked mesh doesn't have a UV2 size hint, this value will be used to roughly compute a suitable lightmap size.
get_default_texels_per_unit ::
                              (BakedLightmap :< cls, Object :< cls) => cls -> IO Float
get_default_texels_per_unit cls
  = withVariantArray []
      (\ (arrPtr, len) ->
         godot_method_bind_call
           bindBakedLightmap_get_default_texels_per_unit
           (upcast cls)
           arrPtr
           len
           >>= \ (err, res) -> throwIfErr err >> fromGodotVariant res)

instance NodeMethod BakedLightmap "get_default_texels_per_unit" '[]
           (IO Float)
         where
        nodeMethod = Godot.Core.BakedLightmap.get_default_texels_per_unit

{-# NOINLINE bindBakedLightmap_get_environment_custom_color #-}

-- | The environment color when @environment_mode@ is set to @ENVIRONMENT_MODE_CUSTOM_COLOR@.
bindBakedLightmap_get_environment_custom_color :: MethodBind
bindBakedLightmap_get_environment_custom_color
  = unsafePerformIO $
      withCString "BakedLightmap" $
        \ clsNamePtr ->
          withCString "get_environment_custom_color" $
            \ methodNamePtr ->
              godot_method_bind_get_method clsNamePtr methodNamePtr

-- | The environment color when @environment_mode@ is set to @ENVIRONMENT_MODE_CUSTOM_COLOR@.
get_environment_custom_color ::
                               (BakedLightmap :< cls, Object :< cls) => cls -> IO Color
get_environment_custom_color cls
  = withVariantArray []
      (\ (arrPtr, len) ->
         godot_method_bind_call
           bindBakedLightmap_get_environment_custom_color
           (upcast cls)
           arrPtr
           len
           >>= \ (err, res) -> throwIfErr err >> fromGodotVariant res)

instance NodeMethod BakedLightmap "get_environment_custom_color"
           '[]
           (IO Color)
         where
        nodeMethod = Godot.Core.BakedLightmap.get_environment_custom_color

{-# NOINLINE bindBakedLightmap_get_environment_custom_energy #-}

-- | The energy scaling factor when when @environment_mode@ is set to @ENVIRONMENT_MODE_CUSTOM_COLOR@ or @ENVIRONMENT_MODE_CUSTOM_SKY@.
bindBakedLightmap_get_environment_custom_energy :: MethodBind
bindBakedLightmap_get_environment_custom_energy
  = unsafePerformIO $
      withCString "BakedLightmap" $
        \ clsNamePtr ->
          withCString "get_environment_custom_energy" $
            \ methodNamePtr ->
              godot_method_bind_get_method clsNamePtr methodNamePtr

-- | The energy scaling factor when when @environment_mode@ is set to @ENVIRONMENT_MODE_CUSTOM_COLOR@ or @ENVIRONMENT_MODE_CUSTOM_SKY@.
get_environment_custom_energy ::
                                (BakedLightmap :< cls, Object :< cls) => cls -> IO Float
get_environment_custom_energy cls
  = withVariantArray []
      (\ (arrPtr, len) ->
         godot_method_bind_call
           bindBakedLightmap_get_environment_custom_energy
           (upcast cls)
           arrPtr
           len
           >>= \ (err, res) -> throwIfErr err >> fromGodotVariant res)

instance NodeMethod BakedLightmap "get_environment_custom_energy"
           '[]
           (IO Float)
         where
        nodeMethod = Godot.Core.BakedLightmap.get_environment_custom_energy

{-# NOINLINE bindBakedLightmap_get_environment_custom_sky #-}

-- | The @Sky@ resource to use when @environment_mode@ is set o @ENVIRONMENT_MODE_CUSTOM_SKY@.
bindBakedLightmap_get_environment_custom_sky :: MethodBind
bindBakedLightmap_get_environment_custom_sky
  = unsafePerformIO $
      withCString "BakedLightmap" $
        \ clsNamePtr ->
          withCString "get_environment_custom_sky" $
            \ methodNamePtr ->
              godot_method_bind_get_method clsNamePtr methodNamePtr

-- | The @Sky@ resource to use when @environment_mode@ is set o @ENVIRONMENT_MODE_CUSTOM_SKY@.
get_environment_custom_sky ::
                             (BakedLightmap :< cls, Object :< cls) => cls -> IO Sky
get_environment_custom_sky cls
  = withVariantArray []
      (\ (arrPtr, len) ->
         godot_method_bind_call bindBakedLightmap_get_environment_custom_sky
           (upcast cls)
           arrPtr
           len
           >>= \ (err, res) -> throwIfErr err >> fromGodotVariant res)

instance NodeMethod BakedLightmap "get_environment_custom_sky" '[]
           (IO Sky)
         where
        nodeMethod = Godot.Core.BakedLightmap.get_environment_custom_sky

{-# NOINLINE bindBakedLightmap_get_environment_custom_sky_rotation_degrees
             #-}

-- | The rotation of the baked custom sky.
bindBakedLightmap_get_environment_custom_sky_rotation_degrees ::
                                                              MethodBind
bindBakedLightmap_get_environment_custom_sky_rotation_degrees
  = unsafePerformIO $
      withCString "BakedLightmap" $
        \ clsNamePtr ->
          withCString "get_environment_custom_sky_rotation_degrees" $
            \ methodNamePtr ->
              godot_method_bind_get_method clsNamePtr methodNamePtr

-- | The rotation of the baked custom sky.
get_environment_custom_sky_rotation_degrees ::
                                              (BakedLightmap :< cls, Object :< cls) =>
                                              cls -> IO Vector3
get_environment_custom_sky_rotation_degrees cls
  = withVariantArray []
      (\ (arrPtr, len) ->
         godot_method_bind_call
           bindBakedLightmap_get_environment_custom_sky_rotation_degrees
           (upcast cls)
           arrPtr
           len
           >>= \ (err, res) -> throwIfErr err >> fromGodotVariant res)

instance NodeMethod BakedLightmap
           "get_environment_custom_sky_rotation_degrees"
           '[]
           (IO Vector3)
         where
        nodeMethod
          = Godot.Core.BakedLightmap.get_environment_custom_sky_rotation_degrees

{-# NOINLINE bindBakedLightmap_get_environment_min_light #-}

-- | Minimum ambient light for all the lightmap texels. This doesn't take into account any occlusion from the scene's geometry, it simply ensures a minimum amount of light on all the lightmap texels. Can be used for artistic control on shadow color.
bindBakedLightmap_get_environment_min_light :: MethodBind
bindBakedLightmap_get_environment_min_light
  = unsafePerformIO $
      withCString "BakedLightmap" $
        \ clsNamePtr ->
          withCString "get_environment_min_light" $
            \ methodNamePtr ->
              godot_method_bind_get_method clsNamePtr methodNamePtr

-- | Minimum ambient light for all the lightmap texels. This doesn't take into account any occlusion from the scene's geometry, it simply ensures a minimum amount of light on all the lightmap texels. Can be used for artistic control on shadow color.
get_environment_min_light ::
                            (BakedLightmap :< cls, Object :< cls) => cls -> IO Color
get_environment_min_light cls
  = withVariantArray []
      (\ (arrPtr, len) ->
         godot_method_bind_call bindBakedLightmap_get_environment_min_light
           (upcast cls)
           arrPtr
           len
           >>= \ (err, res) -> throwIfErr err >> fromGodotVariant res)

instance NodeMethod BakedLightmap "get_environment_min_light" '[]
           (IO Color)
         where
        nodeMethod = Godot.Core.BakedLightmap.get_environment_min_light

{-# NOINLINE bindBakedLightmap_get_environment_mode #-}

-- | Decides which environment to use during baking.
bindBakedLightmap_get_environment_mode :: MethodBind
bindBakedLightmap_get_environment_mode
  = unsafePerformIO $
      withCString "BakedLightmap" $
        \ clsNamePtr ->
          withCString "get_environment_mode" $
            \ methodNamePtr ->
              godot_method_bind_get_method clsNamePtr methodNamePtr

-- | Decides which environment to use during baking.
get_environment_mode ::
                       (BakedLightmap :< cls, Object :< cls) => cls -> IO Int
get_environment_mode cls
  = withVariantArray []
      (\ (arrPtr, len) ->
         godot_method_bind_call bindBakedLightmap_get_environment_mode
           (upcast cls)
           arrPtr
           len
           >>= \ (err, res) -> throwIfErr err >> fromGodotVariant res)

instance NodeMethod BakedLightmap "get_environment_mode" '[]
           (IO Int)
         where
        nodeMethod = Godot.Core.BakedLightmap.get_environment_mode

{-# NOINLINE bindBakedLightmap_get_extents #-}

-- | Size of the baked lightmap. Only meshes inside this region will be included in the baked lightmap, also used as the bounds of the captured region for dynamic lighting.
bindBakedLightmap_get_extents :: MethodBind
bindBakedLightmap_get_extents
  = unsafePerformIO $
      withCString "BakedLightmap" $
        \ clsNamePtr ->
          withCString "get_extents" $
            \ methodNamePtr ->
              godot_method_bind_get_method clsNamePtr methodNamePtr

-- | Size of the baked lightmap. Only meshes inside this region will be included in the baked lightmap, also used as the bounds of the captured region for dynamic lighting.
get_extents ::
              (BakedLightmap :< cls, Object :< cls) => cls -> IO Vector3
get_extents cls
  = withVariantArray []
      (\ (arrPtr, len) ->
         godot_method_bind_call bindBakedLightmap_get_extents (upcast cls)
           arrPtr
           len
           >>= \ (err, res) -> throwIfErr err >> fromGodotVariant res)

instance NodeMethod BakedLightmap "get_extents" '[] (IO Vector3)
         where
        nodeMethod = Godot.Core.BakedLightmap.get_extents

{-# NOINLINE bindBakedLightmap_get_image_path #-}

-- | Deprecated, in previous versions it determined the location where lightmaps were be saved.
bindBakedLightmap_get_image_path :: MethodBind
bindBakedLightmap_get_image_path
  = unsafePerformIO $
      withCString "BakedLightmap" $
        \ clsNamePtr ->
          withCString "get_image_path" $
            \ methodNamePtr ->
              godot_method_bind_get_method clsNamePtr methodNamePtr

-- | Deprecated, in previous versions it determined the location where lightmaps were be saved.
get_image_path ::
                 (BakedLightmap :< cls, Object :< cls) => cls -> IO GodotString
get_image_path cls
  = withVariantArray []
      (\ (arrPtr, len) ->
         godot_method_bind_call bindBakedLightmap_get_image_path
           (upcast cls)
           arrPtr
           len
           >>= \ (err, res) -> throwIfErr err >> fromGodotVariant res)

instance NodeMethod BakedLightmap "get_image_path" '[]
           (IO GodotString)
         where
        nodeMethod = Godot.Core.BakedLightmap.get_image_path

{-# NOINLINE bindBakedLightmap_get_light_data #-}

-- | The calculated light data.
bindBakedLightmap_get_light_data :: MethodBind
bindBakedLightmap_get_light_data
  = unsafePerformIO $
      withCString "BakedLightmap" $
        \ clsNamePtr ->
          withCString "get_light_data" $
            \ methodNamePtr ->
              godot_method_bind_get_method clsNamePtr methodNamePtr

-- | The calculated light data.
get_light_data ::
                 (BakedLightmap :< cls, Object :< cls) =>
                 cls -> IO BakedLightmapData
get_light_data cls
  = withVariantArray []
      (\ (arrPtr, len) ->
         godot_method_bind_call bindBakedLightmap_get_light_data
           (upcast cls)
           arrPtr
           len
           >>= \ (err, res) -> throwIfErr err >> fromGodotVariant res)

instance NodeMethod BakedLightmap "get_light_data" '[]
           (IO BakedLightmapData)
         where
        nodeMethod = Godot.Core.BakedLightmap.get_light_data

{-# NOINLINE bindBakedLightmap_get_max_atlas_size #-}

-- | Maximum size of each lightmap layer, only used when @atlas_generate@ is enabled.
bindBakedLightmap_get_max_atlas_size :: MethodBind
bindBakedLightmap_get_max_atlas_size
  = unsafePerformIO $
      withCString "BakedLightmap" $
        \ clsNamePtr ->
          withCString "get_max_atlas_size" $
            \ methodNamePtr ->
              godot_method_bind_get_method clsNamePtr methodNamePtr

-- | Maximum size of each lightmap layer, only used when @atlas_generate@ is enabled.
get_max_atlas_size ::
                     (BakedLightmap :< cls, Object :< cls) => cls -> IO Int
get_max_atlas_size cls
  = withVariantArray []
      (\ (arrPtr, len) ->
         godot_method_bind_call bindBakedLightmap_get_max_atlas_size
           (upcast cls)
           arrPtr
           len
           >>= \ (err, res) -> throwIfErr err >> fromGodotVariant res)

instance NodeMethod BakedLightmap "get_max_atlas_size" '[] (IO Int)
         where
        nodeMethod = Godot.Core.BakedLightmap.get_max_atlas_size

{-# NOINLINE bindBakedLightmap_is_generate_atlas_enabled #-}

-- | When enabled, the lightmapper will merge the textures for all meshes into a single large layered texture. Not supported in GLES2.
bindBakedLightmap_is_generate_atlas_enabled :: MethodBind
bindBakedLightmap_is_generate_atlas_enabled
  = unsafePerformIO $
      withCString "BakedLightmap" $
        \ clsNamePtr ->
          withCString "is_generate_atlas_enabled" $
            \ methodNamePtr ->
              godot_method_bind_get_method clsNamePtr methodNamePtr

-- | When enabled, the lightmapper will merge the textures for all meshes into a single large layered texture. Not supported in GLES2.
is_generate_atlas_enabled ::
                            (BakedLightmap :< cls, Object :< cls) => cls -> IO Bool
is_generate_atlas_enabled cls
  = withVariantArray []
      (\ (arrPtr, len) ->
         godot_method_bind_call bindBakedLightmap_is_generate_atlas_enabled
           (upcast cls)
           arrPtr
           len
           >>= \ (err, res) -> throwIfErr err >> fromGodotVariant res)

instance NodeMethod BakedLightmap "is_generate_atlas_enabled" '[]
           (IO Bool)
         where
        nodeMethod = Godot.Core.BakedLightmap.is_generate_atlas_enabled

{-# NOINLINE bindBakedLightmap_is_using_color #-}

-- | Store full color values in the lightmap textures. When disabled, lightmap textures will store a single brightness channel. Can be disabled to reduce disk usage if the scene contains only white lights or you don't mind losing color information in indirect lighting.
bindBakedLightmap_is_using_color :: MethodBind
bindBakedLightmap_is_using_color
  = unsafePerformIO $
      withCString "BakedLightmap" $
        \ clsNamePtr ->
          withCString "is_using_color" $
            \ methodNamePtr ->
              godot_method_bind_get_method clsNamePtr methodNamePtr

-- | Store full color values in the lightmap textures. When disabled, lightmap textures will store a single brightness channel. Can be disabled to reduce disk usage if the scene contains only white lights or you don't mind losing color information in indirect lighting.
is_using_color ::
                 (BakedLightmap :< cls, Object :< cls) => cls -> IO Bool
is_using_color cls
  = withVariantArray []
      (\ (arrPtr, len) ->
         godot_method_bind_call bindBakedLightmap_is_using_color
           (upcast cls)
           arrPtr
           len
           >>= \ (err, res) -> throwIfErr err >> fromGodotVariant res)

instance NodeMethod BakedLightmap "is_using_color" '[] (IO Bool)
         where
        nodeMethod = Godot.Core.BakedLightmap.is_using_color

{-# NOINLINE bindBakedLightmap_is_using_denoiser #-}

-- | When enabled, a lightmap denoiser will be used to reduce the noise inherent to Monte Carlo based global illumination.
bindBakedLightmap_is_using_denoiser :: MethodBind
bindBakedLightmap_is_using_denoiser
  = unsafePerformIO $
      withCString "BakedLightmap" $
        \ clsNamePtr ->
          withCString "is_using_denoiser" $
            \ methodNamePtr ->
              godot_method_bind_get_method clsNamePtr methodNamePtr

-- | When enabled, a lightmap denoiser will be used to reduce the noise inherent to Monte Carlo based global illumination.
is_using_denoiser ::
                    (BakedLightmap :< cls, Object :< cls) => cls -> IO Bool
is_using_denoiser cls
  = withVariantArray []
      (\ (arrPtr, len) ->
         godot_method_bind_call bindBakedLightmap_is_using_denoiser
           (upcast cls)
           arrPtr
           len
           >>= \ (err, res) -> throwIfErr err >> fromGodotVariant res)

instance NodeMethod BakedLightmap "is_using_denoiser" '[] (IO Bool)
         where
        nodeMethod = Godot.Core.BakedLightmap.is_using_denoiser

{-# NOINLINE bindBakedLightmap_is_using_hdr #-}

-- | If @true@, stores the lightmap textures in a high dynamic range format (EXR). If @false@, stores the lightmap texture in a low dynamic range PNG image. This can be set to @false@ to reduce disk usage, but light values over 1.0 will be clamped and you may see banding caused by the reduced precision.
--   			__Note:__ Setting @use_hdr@ to @true@ will decrease lightmap banding even when using the GLES2 backend or if @ProjectSettings.rendering/quality/depth/hdr@ is @false@.
bindBakedLightmap_is_using_hdr :: MethodBind
bindBakedLightmap_is_using_hdr
  = unsafePerformIO $
      withCString "BakedLightmap" $
        \ clsNamePtr ->
          withCString "is_using_hdr" $
            \ methodNamePtr ->
              godot_method_bind_get_method clsNamePtr methodNamePtr

-- | If @true@, stores the lightmap textures in a high dynamic range format (EXR). If @false@, stores the lightmap texture in a low dynamic range PNG image. This can be set to @false@ to reduce disk usage, but light values over 1.0 will be clamped and you may see banding caused by the reduced precision.
--   			__Note:__ Setting @use_hdr@ to @true@ will decrease lightmap banding even when using the GLES2 backend or if @ProjectSettings.rendering/quality/depth/hdr@ is @false@.
is_using_hdr ::
               (BakedLightmap :< cls, Object :< cls) => cls -> IO Bool
is_using_hdr cls
  = withVariantArray []
      (\ (arrPtr, len) ->
         godot_method_bind_call bindBakedLightmap_is_using_hdr (upcast cls)
           arrPtr
           len
           >>= \ (err, res) -> throwIfErr err >> fromGodotVariant res)

instance NodeMethod BakedLightmap "is_using_hdr" '[] (IO Bool)
         where
        nodeMethod = Godot.Core.BakedLightmap.is_using_hdr

{-# NOINLINE bindBakedLightmap_set_bake_quality #-}

-- | Determines the amount of samples per texel used in indrect light baking. The amount of samples for each quality level can be configured in the project settings.
bindBakedLightmap_set_bake_quality :: MethodBind
bindBakedLightmap_set_bake_quality
  = unsafePerformIO $
      withCString "BakedLightmap" $
        \ clsNamePtr ->
          withCString "set_bake_quality" $
            \ methodNamePtr ->
              godot_method_bind_get_method clsNamePtr methodNamePtr

-- | Determines the amount of samples per texel used in indrect light baking. The amount of samples for each quality level can be configured in the project settings.
set_bake_quality ::
                   (BakedLightmap :< cls, Object :< cls) => cls -> Int -> IO ()
set_bake_quality cls arg1
  = withVariantArray [toVariant arg1]
      (\ (arrPtr, len) ->
         godot_method_bind_call bindBakedLightmap_set_bake_quality
           (upcast cls)
           arrPtr
           len
           >>= \ (err, res) -> throwIfErr err >> fromGodotVariant res)

instance NodeMethod BakedLightmap "set_bake_quality" '[Int] (IO ())
         where
        nodeMethod = Godot.Core.BakedLightmap.set_bake_quality

{-# NOINLINE bindBakedLightmap_set_bias #-}

-- | Raycasting bias used during baking to avoid floating point precission issues.
bindBakedLightmap_set_bias :: MethodBind
bindBakedLightmap_set_bias
  = unsafePerformIO $
      withCString "BakedLightmap" $
        \ clsNamePtr ->
          withCString "set_bias" $
            \ methodNamePtr ->
              godot_method_bind_get_method clsNamePtr methodNamePtr

-- | Raycasting bias used during baking to avoid floating point precission issues.
set_bias ::
           (BakedLightmap :< cls, Object :< cls) => cls -> Float -> IO ()
set_bias cls arg1
  = withVariantArray [toVariant arg1]
      (\ (arrPtr, len) ->
         godot_method_bind_call bindBakedLightmap_set_bias (upcast cls)
           arrPtr
           len
           >>= \ (err, res) -> throwIfErr err >> fromGodotVariant res)

instance NodeMethod BakedLightmap "set_bias" '[Float] (IO ()) where
        nodeMethod = Godot.Core.BakedLightmap.set_bias

{-# NOINLINE bindBakedLightmap_set_bounces #-}

-- | Number of light bounces that are taken into account during baking.
bindBakedLightmap_set_bounces :: MethodBind
bindBakedLightmap_set_bounces
  = unsafePerformIO $
      withCString "BakedLightmap" $
        \ clsNamePtr ->
          withCString "set_bounces" $
            \ methodNamePtr ->
              godot_method_bind_get_method clsNamePtr methodNamePtr

-- | Number of light bounces that are taken into account during baking.
set_bounces ::
              (BakedLightmap :< cls, Object :< cls) => cls -> Int -> IO ()
set_bounces cls arg1
  = withVariantArray [toVariant arg1]
      (\ (arrPtr, len) ->
         godot_method_bind_call bindBakedLightmap_set_bounces (upcast cls)
           arrPtr
           len
           >>= \ (err, res) -> throwIfErr err >> fromGodotVariant res)

instance NodeMethod BakedLightmap "set_bounces" '[Int] (IO ())
         where
        nodeMethod = Godot.Core.BakedLightmap.set_bounces

{-# NOINLINE bindBakedLightmap_set_capture_cell_size #-}

-- | Grid size used for real-time capture information on dynamic objects.
bindBakedLightmap_set_capture_cell_size :: MethodBind
bindBakedLightmap_set_capture_cell_size
  = unsafePerformIO $
      withCString "BakedLightmap" $
        \ clsNamePtr ->
          withCString "set_capture_cell_size" $
            \ methodNamePtr ->
              godot_method_bind_get_method clsNamePtr methodNamePtr

-- | Grid size used for real-time capture information on dynamic objects.
set_capture_cell_size ::
                        (BakedLightmap :< cls, Object :< cls) => cls -> Float -> IO ()
set_capture_cell_size cls arg1
  = withVariantArray [toVariant arg1]
      (\ (arrPtr, len) ->
         godot_method_bind_call bindBakedLightmap_set_capture_cell_size
           (upcast cls)
           arrPtr
           len
           >>= \ (err, res) -> throwIfErr err >> fromGodotVariant res)

instance NodeMethod BakedLightmap "set_capture_cell_size" '[Float]
           (IO ())
         where
        nodeMethod = Godot.Core.BakedLightmap.set_capture_cell_size

{-# NOINLINE bindBakedLightmap_set_capture_enabled #-}

-- | When enabled, an octree containing the scene's lighting information will be computed. This octree will then be used to light dynamic objects in the scene.
bindBakedLightmap_set_capture_enabled :: MethodBind
bindBakedLightmap_set_capture_enabled
  = unsafePerformIO $
      withCString "BakedLightmap" $
        \ clsNamePtr ->
          withCString "set_capture_enabled" $
            \ methodNamePtr ->
              godot_method_bind_get_method clsNamePtr methodNamePtr

-- | When enabled, an octree containing the scene's lighting information will be computed. This octree will then be used to light dynamic objects in the scene.
set_capture_enabled ::
                      (BakedLightmap :< cls, Object :< cls) => cls -> Bool -> IO ()
set_capture_enabled cls arg1
  = withVariantArray [toVariant arg1]
      (\ (arrPtr, len) ->
         godot_method_bind_call bindBakedLightmap_set_capture_enabled
           (upcast cls)
           arrPtr
           len
           >>= \ (err, res) -> throwIfErr err >> fromGodotVariant res)

instance NodeMethod BakedLightmap "set_capture_enabled" '[Bool]
           (IO ())
         where
        nodeMethod = Godot.Core.BakedLightmap.set_capture_enabled

{-# NOINLINE bindBakedLightmap_set_capture_propagation #-}

-- | Bias value to reduce the amount of light proagation in the captured octree.
bindBakedLightmap_set_capture_propagation :: MethodBind
bindBakedLightmap_set_capture_propagation
  = unsafePerformIO $
      withCString "BakedLightmap" $
        \ clsNamePtr ->
          withCString "set_capture_propagation" $
            \ methodNamePtr ->
              godot_method_bind_get_method clsNamePtr methodNamePtr

-- | Bias value to reduce the amount of light proagation in the captured octree.
set_capture_propagation ::
                          (BakedLightmap :< cls, Object :< cls) => cls -> Float -> IO ()
set_capture_propagation cls arg1
  = withVariantArray [toVariant arg1]
      (\ (arrPtr, len) ->
         godot_method_bind_call bindBakedLightmap_set_capture_propagation
           (upcast cls)
           arrPtr
           len
           >>= \ (err, res) -> throwIfErr err >> fromGodotVariant res)

instance NodeMethod BakedLightmap "set_capture_propagation"
           '[Float]
           (IO ())
         where
        nodeMethod = Godot.Core.BakedLightmap.set_capture_propagation

{-# NOINLINE bindBakedLightmap_set_capture_quality #-}

-- | Bake quality of the capture data.
bindBakedLightmap_set_capture_quality :: MethodBind
bindBakedLightmap_set_capture_quality
  = unsafePerformIO $
      withCString "BakedLightmap" $
        \ clsNamePtr ->
          withCString "set_capture_quality" $
            \ methodNamePtr ->
              godot_method_bind_get_method clsNamePtr methodNamePtr

-- | Bake quality of the capture data.
set_capture_quality ::
                      (BakedLightmap :< cls, Object :< cls) => cls -> Int -> IO ()
set_capture_quality cls arg1
  = withVariantArray [toVariant arg1]
      (\ (arrPtr, len) ->
         godot_method_bind_call bindBakedLightmap_set_capture_quality
           (upcast cls)
           arrPtr
           len
           >>= \ (err, res) -> throwIfErr err >> fromGodotVariant res)

instance NodeMethod BakedLightmap "set_capture_quality" '[Int]
           (IO ())
         where
        nodeMethod = Godot.Core.BakedLightmap.set_capture_quality

{-# NOINLINE bindBakedLightmap_set_default_texels_per_unit #-}

-- | If a baked mesh doesn't have a UV2 size hint, this value will be used to roughly compute a suitable lightmap size.
bindBakedLightmap_set_default_texels_per_unit :: MethodBind
bindBakedLightmap_set_default_texels_per_unit
  = unsafePerformIO $
      withCString "BakedLightmap" $
        \ clsNamePtr ->
          withCString "set_default_texels_per_unit" $
            \ methodNamePtr ->
              godot_method_bind_get_method clsNamePtr methodNamePtr

-- | If a baked mesh doesn't have a UV2 size hint, this value will be used to roughly compute a suitable lightmap size.
set_default_texels_per_unit ::
                              (BakedLightmap :< cls, Object :< cls) => cls -> Float -> IO ()
set_default_texels_per_unit cls arg1
  = withVariantArray [toVariant arg1]
      (\ (arrPtr, len) ->
         godot_method_bind_call
           bindBakedLightmap_set_default_texels_per_unit
           (upcast cls)
           arrPtr
           len
           >>= \ (err, res) -> throwIfErr err >> fromGodotVariant res)

instance NodeMethod BakedLightmap "set_default_texels_per_unit"
           '[Float]
           (IO ())
         where
        nodeMethod = Godot.Core.BakedLightmap.set_default_texels_per_unit

{-# NOINLINE bindBakedLightmap_set_environment_custom_color #-}

-- | The environment color when @environment_mode@ is set to @ENVIRONMENT_MODE_CUSTOM_COLOR@.
bindBakedLightmap_set_environment_custom_color :: MethodBind
bindBakedLightmap_set_environment_custom_color
  = unsafePerformIO $
      withCString "BakedLightmap" $
        \ clsNamePtr ->
          withCString "set_environment_custom_color" $
            \ methodNamePtr ->
              godot_method_bind_get_method clsNamePtr methodNamePtr

-- | The environment color when @environment_mode@ is set to @ENVIRONMENT_MODE_CUSTOM_COLOR@.
set_environment_custom_color ::
                               (BakedLightmap :< cls, Object :< cls) => cls -> Color -> IO ()
set_environment_custom_color cls arg1
  = withVariantArray [toVariant arg1]
      (\ (arrPtr, len) ->
         godot_method_bind_call
           bindBakedLightmap_set_environment_custom_color
           (upcast cls)
           arrPtr
           len
           >>= \ (err, res) -> throwIfErr err >> fromGodotVariant res)

instance NodeMethod BakedLightmap "set_environment_custom_color"
           '[Color]
           (IO ())
         where
        nodeMethod = Godot.Core.BakedLightmap.set_environment_custom_color

{-# NOINLINE bindBakedLightmap_set_environment_custom_energy #-}

-- | The energy scaling factor when when @environment_mode@ is set to @ENVIRONMENT_MODE_CUSTOM_COLOR@ or @ENVIRONMENT_MODE_CUSTOM_SKY@.
bindBakedLightmap_set_environment_custom_energy :: MethodBind
bindBakedLightmap_set_environment_custom_energy
  = unsafePerformIO $
      withCString "BakedLightmap" $
        \ clsNamePtr ->
          withCString "set_environment_custom_energy" $
            \ methodNamePtr ->
              godot_method_bind_get_method clsNamePtr methodNamePtr

-- | The energy scaling factor when when @environment_mode@ is set to @ENVIRONMENT_MODE_CUSTOM_COLOR@ or @ENVIRONMENT_MODE_CUSTOM_SKY@.
set_environment_custom_energy ::
                                (BakedLightmap :< cls, Object :< cls) => cls -> Float -> IO ()
set_environment_custom_energy cls arg1
  = withVariantArray [toVariant arg1]
      (\ (arrPtr, len) ->
         godot_method_bind_call
           bindBakedLightmap_set_environment_custom_energy
           (upcast cls)
           arrPtr
           len
           >>= \ (err, res) -> throwIfErr err >> fromGodotVariant res)

instance NodeMethod BakedLightmap "set_environment_custom_energy"
           '[Float]
           (IO ())
         where
        nodeMethod = Godot.Core.BakedLightmap.set_environment_custom_energy

{-# NOINLINE bindBakedLightmap_set_environment_custom_sky #-}

-- | The @Sky@ resource to use when @environment_mode@ is set o @ENVIRONMENT_MODE_CUSTOM_SKY@.
bindBakedLightmap_set_environment_custom_sky :: MethodBind
bindBakedLightmap_set_environment_custom_sky
  = unsafePerformIO $
      withCString "BakedLightmap" $
        \ clsNamePtr ->
          withCString "set_environment_custom_sky" $
            \ methodNamePtr ->
              godot_method_bind_get_method clsNamePtr methodNamePtr

-- | The @Sky@ resource to use when @environment_mode@ is set o @ENVIRONMENT_MODE_CUSTOM_SKY@.
set_environment_custom_sky ::
                             (BakedLightmap :< cls, Object :< cls) => cls -> Sky -> IO ()
set_environment_custom_sky cls arg1
  = withVariantArray [toVariant arg1]
      (\ (arrPtr, len) ->
         godot_method_bind_call bindBakedLightmap_set_environment_custom_sky
           (upcast cls)
           arrPtr
           len
           >>= \ (err, res) -> throwIfErr err >> fromGodotVariant res)

instance NodeMethod BakedLightmap "set_environment_custom_sky"
           '[Sky]
           (IO ())
         where
        nodeMethod = Godot.Core.BakedLightmap.set_environment_custom_sky

{-# NOINLINE bindBakedLightmap_set_environment_custom_sky_rotation_degrees
             #-}

-- | The rotation of the baked custom sky.
bindBakedLightmap_set_environment_custom_sky_rotation_degrees ::
                                                              MethodBind
bindBakedLightmap_set_environment_custom_sky_rotation_degrees
  = unsafePerformIO $
      withCString "BakedLightmap" $
        \ clsNamePtr ->
          withCString "set_environment_custom_sky_rotation_degrees" $
            \ methodNamePtr ->
              godot_method_bind_get_method clsNamePtr methodNamePtr

-- | The rotation of the baked custom sky.
set_environment_custom_sky_rotation_degrees ::
                                              (BakedLightmap :< cls, Object :< cls) =>
                                              cls -> Vector3 -> IO ()
set_environment_custom_sky_rotation_degrees cls arg1
  = withVariantArray [toVariant arg1]
      (\ (arrPtr, len) ->
         godot_method_bind_call
           bindBakedLightmap_set_environment_custom_sky_rotation_degrees
           (upcast cls)
           arrPtr
           len
           >>= \ (err, res) -> throwIfErr err >> fromGodotVariant res)

instance NodeMethod BakedLightmap
           "set_environment_custom_sky_rotation_degrees"
           '[Vector3]
           (IO ())
         where
        nodeMethod
          = Godot.Core.BakedLightmap.set_environment_custom_sky_rotation_degrees

{-# NOINLINE bindBakedLightmap_set_environment_min_light #-}

-- | Minimum ambient light for all the lightmap texels. This doesn't take into account any occlusion from the scene's geometry, it simply ensures a minimum amount of light on all the lightmap texels. Can be used for artistic control on shadow color.
bindBakedLightmap_set_environment_min_light :: MethodBind
bindBakedLightmap_set_environment_min_light
  = unsafePerformIO $
      withCString "BakedLightmap" $
        \ clsNamePtr ->
          withCString "set_environment_min_light" $
            \ methodNamePtr ->
              godot_method_bind_get_method clsNamePtr methodNamePtr

-- | Minimum ambient light for all the lightmap texels. This doesn't take into account any occlusion from the scene's geometry, it simply ensures a minimum amount of light on all the lightmap texels. Can be used for artistic control on shadow color.
set_environment_min_light ::
                            (BakedLightmap :< cls, Object :< cls) => cls -> Color -> IO ()
set_environment_min_light cls arg1
  = withVariantArray [toVariant arg1]
      (\ (arrPtr, len) ->
         godot_method_bind_call bindBakedLightmap_set_environment_min_light
           (upcast cls)
           arrPtr
           len
           >>= \ (err, res) -> throwIfErr err >> fromGodotVariant res)

instance NodeMethod BakedLightmap "set_environment_min_light"
           '[Color]
           (IO ())
         where
        nodeMethod = Godot.Core.BakedLightmap.set_environment_min_light

{-# NOINLINE bindBakedLightmap_set_environment_mode #-}

-- | Decides which environment to use during baking.
bindBakedLightmap_set_environment_mode :: MethodBind
bindBakedLightmap_set_environment_mode
  = unsafePerformIO $
      withCString "BakedLightmap" $
        \ clsNamePtr ->
          withCString "set_environment_mode" $
            \ methodNamePtr ->
              godot_method_bind_get_method clsNamePtr methodNamePtr

-- | Decides which environment to use during baking.
set_environment_mode ::
                       (BakedLightmap :< cls, Object :< cls) => cls -> Int -> IO ()
set_environment_mode cls arg1
  = withVariantArray [toVariant arg1]
      (\ (arrPtr, len) ->
         godot_method_bind_call bindBakedLightmap_set_environment_mode
           (upcast cls)
           arrPtr
           len
           >>= \ (err, res) -> throwIfErr err >> fromGodotVariant res)

instance NodeMethod BakedLightmap "set_environment_mode" '[Int]
           (IO ())
         where
        nodeMethod = Godot.Core.BakedLightmap.set_environment_mode

{-# NOINLINE bindBakedLightmap_set_extents #-}

-- | Size of the baked lightmap. Only meshes inside this region will be included in the baked lightmap, also used as the bounds of the captured region for dynamic lighting.
bindBakedLightmap_set_extents :: MethodBind
bindBakedLightmap_set_extents
  = unsafePerformIO $
      withCString "BakedLightmap" $
        \ clsNamePtr ->
          withCString "set_extents" $
            \ methodNamePtr ->
              godot_method_bind_get_method clsNamePtr methodNamePtr

-- | Size of the baked lightmap. Only meshes inside this region will be included in the baked lightmap, also used as the bounds of the captured region for dynamic lighting.
set_extents ::
              (BakedLightmap :< cls, Object :< cls) => cls -> Vector3 -> IO ()
set_extents cls arg1
  = withVariantArray [toVariant arg1]
      (\ (arrPtr, len) ->
         godot_method_bind_call bindBakedLightmap_set_extents (upcast cls)
           arrPtr
           len
           >>= \ (err, res) -> throwIfErr err >> fromGodotVariant res)

instance NodeMethod BakedLightmap "set_extents" '[Vector3] (IO ())
         where
        nodeMethod = Godot.Core.BakedLightmap.set_extents

{-# NOINLINE bindBakedLightmap_set_generate_atlas #-}

-- | When enabled, the lightmapper will merge the textures for all meshes into a single large layered texture. Not supported in GLES2.
bindBakedLightmap_set_generate_atlas :: MethodBind
bindBakedLightmap_set_generate_atlas
  = unsafePerformIO $
      withCString "BakedLightmap" $
        \ clsNamePtr ->
          withCString "set_generate_atlas" $
            \ methodNamePtr ->
              godot_method_bind_get_method clsNamePtr methodNamePtr

-- | When enabled, the lightmapper will merge the textures for all meshes into a single large layered texture. Not supported in GLES2.
set_generate_atlas ::
                     (BakedLightmap :< cls, Object :< cls) => cls -> Bool -> IO ()
set_generate_atlas cls arg1
  = withVariantArray [toVariant arg1]
      (\ (arrPtr, len) ->
         godot_method_bind_call bindBakedLightmap_set_generate_atlas
           (upcast cls)
           arrPtr
           len
           >>= \ (err, res) -> throwIfErr err >> fromGodotVariant res)

instance NodeMethod BakedLightmap "set_generate_atlas" '[Bool]
           (IO ())
         where
        nodeMethod = Godot.Core.BakedLightmap.set_generate_atlas

{-# NOINLINE bindBakedLightmap_set_image_path #-}

-- | Deprecated, in previous versions it determined the location where lightmaps were be saved.
bindBakedLightmap_set_image_path :: MethodBind
bindBakedLightmap_set_image_path
  = unsafePerformIO $
      withCString "BakedLightmap" $
        \ clsNamePtr ->
          withCString "set_image_path" $
            \ methodNamePtr ->
              godot_method_bind_get_method clsNamePtr methodNamePtr

-- | Deprecated, in previous versions it determined the location where lightmaps were be saved.
set_image_path ::
                 (BakedLightmap :< cls, Object :< cls) =>
                 cls -> GodotString -> IO ()
set_image_path cls arg1
  = withVariantArray [toVariant arg1]
      (\ (arrPtr, len) ->
         godot_method_bind_call bindBakedLightmap_set_image_path
           (upcast cls)
           arrPtr
           len
           >>= \ (err, res) -> throwIfErr err >> fromGodotVariant res)

instance NodeMethod BakedLightmap "set_image_path" '[GodotString]
           (IO ())
         where
        nodeMethod = Godot.Core.BakedLightmap.set_image_path

{-# NOINLINE bindBakedLightmap_set_light_data #-}

-- | The calculated light data.
bindBakedLightmap_set_light_data :: MethodBind
bindBakedLightmap_set_light_data
  = unsafePerformIO $
      withCString "BakedLightmap" $
        \ clsNamePtr ->
          withCString "set_light_data" $
            \ methodNamePtr ->
              godot_method_bind_get_method clsNamePtr methodNamePtr

-- | The calculated light data.
set_light_data ::
                 (BakedLightmap :< cls, Object :< cls) =>
                 cls -> BakedLightmapData -> IO ()
set_light_data cls arg1
  = withVariantArray [toVariant arg1]
      (\ (arrPtr, len) ->
         godot_method_bind_call bindBakedLightmap_set_light_data
           (upcast cls)
           arrPtr
           len
           >>= \ (err, res) -> throwIfErr err >> fromGodotVariant res)

instance NodeMethod BakedLightmap "set_light_data"
           '[BakedLightmapData]
           (IO ())
         where
        nodeMethod = Godot.Core.BakedLightmap.set_light_data

{-# NOINLINE bindBakedLightmap_set_max_atlas_size #-}

-- | Maximum size of each lightmap layer, only used when @atlas_generate@ is enabled.
bindBakedLightmap_set_max_atlas_size :: MethodBind
bindBakedLightmap_set_max_atlas_size
  = unsafePerformIO $
      withCString "BakedLightmap" $
        \ clsNamePtr ->
          withCString "set_max_atlas_size" $
            \ methodNamePtr ->
              godot_method_bind_get_method clsNamePtr methodNamePtr

-- | Maximum size of each lightmap layer, only used when @atlas_generate@ is enabled.
set_max_atlas_size ::
                     (BakedLightmap :< cls, Object :< cls) => cls -> Int -> IO ()
set_max_atlas_size cls arg1
  = withVariantArray [toVariant arg1]
      (\ (arrPtr, len) ->
         godot_method_bind_call bindBakedLightmap_set_max_atlas_size
           (upcast cls)
           arrPtr
           len
           >>= \ (err, res) -> throwIfErr err >> fromGodotVariant res)

instance NodeMethod BakedLightmap "set_max_atlas_size" '[Int]
           (IO ())
         where
        nodeMethod = Godot.Core.BakedLightmap.set_max_atlas_size

{-# NOINLINE bindBakedLightmap_set_use_color #-}

-- | Store full color values in the lightmap textures. When disabled, lightmap textures will store a single brightness channel. Can be disabled to reduce disk usage if the scene contains only white lights or you don't mind losing color information in indirect lighting.
bindBakedLightmap_set_use_color :: MethodBind
bindBakedLightmap_set_use_color
  = unsafePerformIO $
      withCString "BakedLightmap" $
        \ clsNamePtr ->
          withCString "set_use_color" $
            \ methodNamePtr ->
              godot_method_bind_get_method clsNamePtr methodNamePtr

-- | Store full color values in the lightmap textures. When disabled, lightmap textures will store a single brightness channel. Can be disabled to reduce disk usage if the scene contains only white lights or you don't mind losing color information in indirect lighting.
set_use_color ::
                (BakedLightmap :< cls, Object :< cls) => cls -> Bool -> IO ()
set_use_color cls arg1
  = withVariantArray [toVariant arg1]
      (\ (arrPtr, len) ->
         godot_method_bind_call bindBakedLightmap_set_use_color (upcast cls)
           arrPtr
           len
           >>= \ (err, res) -> throwIfErr err >> fromGodotVariant res)

instance NodeMethod BakedLightmap "set_use_color" '[Bool] (IO ())
         where
        nodeMethod = Godot.Core.BakedLightmap.set_use_color

{-# NOINLINE bindBakedLightmap_set_use_denoiser #-}

-- | When enabled, a lightmap denoiser will be used to reduce the noise inherent to Monte Carlo based global illumination.
bindBakedLightmap_set_use_denoiser :: MethodBind
bindBakedLightmap_set_use_denoiser
  = unsafePerformIO $
      withCString "BakedLightmap" $
        \ clsNamePtr ->
          withCString "set_use_denoiser" $
            \ methodNamePtr ->
              godot_method_bind_get_method clsNamePtr methodNamePtr

-- | When enabled, a lightmap denoiser will be used to reduce the noise inherent to Monte Carlo based global illumination.
set_use_denoiser ::
                   (BakedLightmap :< cls, Object :< cls) => cls -> Bool -> IO ()
set_use_denoiser cls arg1
  = withVariantArray [toVariant arg1]
      (\ (arrPtr, len) ->
         godot_method_bind_call bindBakedLightmap_set_use_denoiser
           (upcast cls)
           arrPtr
           len
           >>= \ (err, res) -> throwIfErr err >> fromGodotVariant res)

instance NodeMethod BakedLightmap "set_use_denoiser" '[Bool]
           (IO ())
         where
        nodeMethod = Godot.Core.BakedLightmap.set_use_denoiser

{-# NOINLINE bindBakedLightmap_set_use_hdr #-}

-- | If @true@, stores the lightmap textures in a high dynamic range format (EXR). If @false@, stores the lightmap texture in a low dynamic range PNG image. This can be set to @false@ to reduce disk usage, but light values over 1.0 will be clamped and you may see banding caused by the reduced precision.
--   			__Note:__ Setting @use_hdr@ to @true@ will decrease lightmap banding even when using the GLES2 backend or if @ProjectSettings.rendering/quality/depth/hdr@ is @false@.
bindBakedLightmap_set_use_hdr :: MethodBind
bindBakedLightmap_set_use_hdr
  = unsafePerformIO $
      withCString "BakedLightmap" $
        \ clsNamePtr ->
          withCString "set_use_hdr" $
            \ methodNamePtr ->
              godot_method_bind_get_method clsNamePtr methodNamePtr

-- | If @true@, stores the lightmap textures in a high dynamic range format (EXR). If @false@, stores the lightmap texture in a low dynamic range PNG image. This can be set to @false@ to reduce disk usage, but light values over 1.0 will be clamped and you may see banding caused by the reduced precision.
--   			__Note:__ Setting @use_hdr@ to @true@ will decrease lightmap banding even when using the GLES2 backend or if @ProjectSettings.rendering/quality/depth/hdr@ is @false@.
set_use_hdr ::
              (BakedLightmap :< cls, Object :< cls) => cls -> Bool -> IO ()
set_use_hdr cls arg1
  = withVariantArray [toVariant arg1]
      (\ (arrPtr, len) ->
         godot_method_bind_call bindBakedLightmap_set_use_hdr (upcast cls)
           arrPtr
           len
           >>= \ (err, res) -> throwIfErr err >> fromGodotVariant res)

instance NodeMethod BakedLightmap "set_use_hdr" '[Bool] (IO ())
         where
        nodeMethod = Godot.Core.BakedLightmap.set_use_hdr