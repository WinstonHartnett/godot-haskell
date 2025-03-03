{-# LANGUAGE DerivingStrategies, GeneralizedNewtypeDeriving,
  TypeFamilies, TypeOperators, FlexibleContexts, DataKinds,
  MultiParamTypeClasses #-}
module Godot.Core.Image
       (Godot.Core.Image._FORMAT_RGF, Godot.Core.Image._FORMAT_RGBAF,
        Godot.Core.Image._ALPHA_BIT, Godot.Core.Image._FORMAT_PVRTC2A,
        Godot.Core.Image._FORMAT_ETC2_RGB8, Godot.Core.Image._FORMAT_LA8,
        Godot.Core.Image._ALPHA_NONE, Godot.Core.Image._COMPRESS_S3TC,
        Godot.Core.Image._INTERPOLATE_BILINEAR,
        Godot.Core.Image._COMPRESS_PVRTC4,
        Godot.Core.Image._FORMAT_RGBA5551, Godot.Core.Image._FORMAT_RGB8,
        Godot.Core.Image._FORMAT_PVRTC4, Godot.Core.Image._FORMAT_RGBH,
        Godot.Core.Image._COMPRESS_ETC,
        Godot.Core.Image._COMPRESS_SOURCE_NORMAL,
        Godot.Core.Image._COMPRESS_PVRTC2, Godot.Core.Image._FORMAT_MAX,
        Godot.Core.Image._FORMAT_RF, Godot.Core.Image._FORMAT_L8,
        Godot.Core.Image._FORMAT_ETC2_RG11S, Godot.Core.Image._FORMAT_RGBF,
        Godot.Core.Image._FORMAT_BPTC_RGBFU, Godot.Core.Image._ALPHA_BLEND,
        Godot.Core.Image._FORMAT_ETC2_R11S,
        Godot.Core.Image._FORMAT_PVRTC4A,
        Godot.Core.Image._INTERPOLATE_NEAREST,
        Godot.Core.Image._FORMAT_RGBE9995,
        Godot.Core.Image._INTERPOLATE_TRILINEAR,
        Godot.Core.Image._COMPRESS_SOURCE_SRGB,
        Godot.Core.Image._FORMAT_DXT3, Godot.Core.Image._FORMAT_BPTC_RGBF,
        Godot.Core.Image._MAX_HEIGHT, Godot.Core.Image._FORMAT_RGTC_RG,
        Godot.Core.Image._FORMAT_ETC2_RGB8A1,
        Godot.Core.Image._COMPRESS_ETC2, Godot.Core.Image._FORMAT_RG8,
        Godot.Core.Image._FORMAT_DXT5, Godot.Core.Image._FORMAT_ETC2_R11,
        Godot.Core.Image._FORMAT_RGH,
        Godot.Core.Image._INTERPOLATE_LANCZOS, Godot.Core.Image._FORMAT_R8,
        Godot.Core.Image._FORMAT_ETC, Godot.Core.Image._INTERPOLATE_CUBIC,
        Godot.Core.Image._FORMAT_ETC2_RG11, Godot.Core.Image._FORMAT_RH,
        Godot.Core.Image._FORMAT_RGTC_R,
        Godot.Core.Image._FORMAT_BPTC_RGBA, Godot.Core.Image._FORMAT_DXT1,
        Godot.Core.Image._FORMAT_ETC2_RGBA8,
        Godot.Core.Image._FORMAT_PVRTC2, Godot.Core.Image._MAX_WIDTH,
        Godot.Core.Image._FORMAT_RGBA8,
        Godot.Core.Image._COMPRESS_SOURCE_GENERIC,
        Godot.Core.Image._FORMAT_RGBAH, Godot.Core.Image._FORMAT_RGBA4444,
        Godot.Core.Image._get_data, Godot.Core.Image._set_data,
        Godot.Core.Image.blend_rect, Godot.Core.Image.blend_rect_mask,
        Godot.Core.Image.blit_rect, Godot.Core.Image.blit_rect_mask,
        Godot.Core.Image.bumpmap_to_normalmap,
        Godot.Core.Image.clear_mipmaps, Godot.Core.Image.compress,
        Godot.Core.Image.convert, Godot.Core.Image.copy_from,
        Godot.Core.Image.create, Godot.Core.Image.create_from_data,
        Godot.Core.Image.crop, Godot.Core.Image.decompress,
        Godot.Core.Image.detect_alpha, Godot.Core.Image.expand_x2_hq2x,
        Godot.Core.Image.fill, Godot.Core.Image.fix_alpha_edges,
        Godot.Core.Image.flip_x, Godot.Core.Image.flip_y,
        Godot.Core.Image.generate_mipmaps, Godot.Core.Image.get_data,
        Godot.Core.Image.get_format, Godot.Core.Image.get_height,
        Godot.Core.Image.get_mipmap_offset, Godot.Core.Image.get_pixel,
        Godot.Core.Image.get_pixelv, Godot.Core.Image.get_rect,
        Godot.Core.Image.get_size, Godot.Core.Image.get_used_rect,
        Godot.Core.Image.get_width, Godot.Core.Image.has_mipmaps,
        Godot.Core.Image.is_compressed, Godot.Core.Image.is_empty,
        Godot.Core.Image.is_invisible, Godot.Core.Image.load,
        Godot.Core.Image.load_bmp_from_buffer,
        Godot.Core.Image.load_jpg_from_buffer,
        Godot.Core.Image.load_png_from_buffer,
        Godot.Core.Image.load_tga_from_buffer,
        Godot.Core.Image.load_webp_from_buffer, Godot.Core.Image.lock,
        Godot.Core.Image.normalmap_to_xy,
        Godot.Core.Image.premultiply_alpha, Godot.Core.Image.resize,
        Godot.Core.Image.resize_to_po2, Godot.Core.Image.rgbe_to_srgb,
        Godot.Core.Image.save_exr, Godot.Core.Image.save_png,
        Godot.Core.Image.save_png_to_buffer, Godot.Core.Image.set_pixel,
        Godot.Core.Image.set_pixelv, Godot.Core.Image.shrink_x2,
        Godot.Core.Image.srgb_to_linear, Godot.Core.Image.unlock)
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
import Godot.Core.Resource()

_FORMAT_RGF :: Int
_FORMAT_RGF = 9

_FORMAT_RGBAF :: Int
_FORMAT_RGBAF = 11

_ALPHA_BIT :: Int
_ALPHA_BIT = 1

_FORMAT_PVRTC2A :: Int
_FORMAT_PVRTC2A = 26

_FORMAT_ETC2_RGB8 :: Int
_FORMAT_ETC2_RGB8 = 34

_FORMAT_LA8 :: Int
_FORMAT_LA8 = 1

_ALPHA_NONE :: Int
_ALPHA_NONE = 0

_COMPRESS_S3TC :: Int
_COMPRESS_S3TC = 0

_INTERPOLATE_BILINEAR :: Int
_INTERPOLATE_BILINEAR = 1

_COMPRESS_PVRTC4 :: Int
_COMPRESS_PVRTC4 = 2

_FORMAT_RGBA5551 :: Int
_FORMAT_RGBA5551 = 7

_FORMAT_RGB8 :: Int
_FORMAT_RGB8 = 4

_FORMAT_PVRTC4 :: Int
_FORMAT_PVRTC4 = 27

_FORMAT_RGBH :: Int
_FORMAT_RGBH = 14

_COMPRESS_ETC :: Int
_COMPRESS_ETC = 3

_COMPRESS_SOURCE_NORMAL :: Int
_COMPRESS_SOURCE_NORMAL = 2

_COMPRESS_PVRTC2 :: Int
_COMPRESS_PVRTC2 = 1

_FORMAT_MAX :: Int
_FORMAT_MAX = 37

_FORMAT_RF :: Int
_FORMAT_RF = 8

_FORMAT_L8 :: Int
_FORMAT_L8 = 0

_FORMAT_ETC2_RG11S :: Int
_FORMAT_ETC2_RG11S = 33

_FORMAT_RGBF :: Int
_FORMAT_RGBF = 10

_FORMAT_BPTC_RGBFU :: Int
_FORMAT_BPTC_RGBFU = 24

_ALPHA_BLEND :: Int
_ALPHA_BLEND = 2

_FORMAT_ETC2_R11S :: Int
_FORMAT_ETC2_R11S = 31

_FORMAT_PVRTC4A :: Int
_FORMAT_PVRTC4A = 28

_INTERPOLATE_NEAREST :: Int
_INTERPOLATE_NEAREST = 0

_FORMAT_RGBE9995 :: Int
_FORMAT_RGBE9995 = 16

_INTERPOLATE_TRILINEAR :: Int
_INTERPOLATE_TRILINEAR = 3

_COMPRESS_SOURCE_SRGB :: Int
_COMPRESS_SOURCE_SRGB = 1

_FORMAT_DXT3 :: Int
_FORMAT_DXT3 = 18

_FORMAT_BPTC_RGBF :: Int
_FORMAT_BPTC_RGBF = 23

_MAX_HEIGHT :: Int
_MAX_HEIGHT = 16384

_FORMAT_RGTC_RG :: Int
_FORMAT_RGTC_RG = 21

_FORMAT_ETC2_RGB8A1 :: Int
_FORMAT_ETC2_RGB8A1 = 36

_COMPRESS_ETC2 :: Int
_COMPRESS_ETC2 = 4

_FORMAT_RG8 :: Int
_FORMAT_RG8 = 3

_FORMAT_DXT5 :: Int
_FORMAT_DXT5 = 19

_FORMAT_ETC2_R11 :: Int
_FORMAT_ETC2_R11 = 30

_FORMAT_RGH :: Int
_FORMAT_RGH = 13

_INTERPOLATE_LANCZOS :: Int
_INTERPOLATE_LANCZOS = 4

_FORMAT_R8 :: Int
_FORMAT_R8 = 2

_FORMAT_ETC :: Int
_FORMAT_ETC = 29

_INTERPOLATE_CUBIC :: Int
_INTERPOLATE_CUBIC = 2

_FORMAT_ETC2_RG11 :: Int
_FORMAT_ETC2_RG11 = 32

_FORMAT_RH :: Int
_FORMAT_RH = 12

_FORMAT_RGTC_R :: Int
_FORMAT_RGTC_R = 20

_FORMAT_BPTC_RGBA :: Int
_FORMAT_BPTC_RGBA = 22

_FORMAT_DXT1 :: Int
_FORMAT_DXT1 = 17

_FORMAT_ETC2_RGBA8 :: Int
_FORMAT_ETC2_RGBA8 = 35

_FORMAT_PVRTC2 :: Int
_FORMAT_PVRTC2 = 25

_MAX_WIDTH :: Int
_MAX_WIDTH = 16384

_FORMAT_RGBA8 :: Int
_FORMAT_RGBA8 = 5

_COMPRESS_SOURCE_GENERIC :: Int
_COMPRESS_SOURCE_GENERIC = 0

_FORMAT_RGBAH :: Int
_FORMAT_RGBAH = 15

_FORMAT_RGBA4444 :: Int
_FORMAT_RGBA4444 = 6

instance NodeProperty Image "data" Dictionary 'False where
        nodeProperty = (_get_data, wrapDroppingSetter _set_data, Nothing)

{-# NOINLINE bindImage__get_data #-}

-- | Holds all the image's color data in a given format. See @enum Format@ constants.
bindImage__get_data :: MethodBind
bindImage__get_data
  = unsafePerformIO $
      withCString "Image" $
        \ clsNamePtr ->
          withCString "_get_data" $
            \ methodNamePtr ->
              godot_method_bind_get_method clsNamePtr methodNamePtr

-- | Holds all the image's color data in a given format. See @enum Format@ constants.
_get_data :: (Image :< cls, Object :< cls) => cls -> IO Dictionary
_get_data cls
  = withVariantArray []
      (\ (arrPtr, len) ->
         godot_method_bind_call bindImage__get_data (upcast cls) arrPtr len
           >>= \ (err, res) -> throwIfErr err >> fromGodotVariant res)

instance NodeMethod Image "_get_data" '[] (IO Dictionary) where
        nodeMethod = Godot.Core.Image._get_data

{-# NOINLINE bindImage__set_data #-}

-- | Holds all the image's color data in a given format. See @enum Format@ constants.
bindImage__set_data :: MethodBind
bindImage__set_data
  = unsafePerformIO $
      withCString "Image" $
        \ clsNamePtr ->
          withCString "_set_data" $
            \ methodNamePtr ->
              godot_method_bind_get_method clsNamePtr methodNamePtr

-- | Holds all the image's color data in a given format. See @enum Format@ constants.
_set_data ::
            (Image :< cls, Object :< cls) => cls -> Dictionary -> IO ()
_set_data cls arg1
  = withVariantArray [toVariant arg1]
      (\ (arrPtr, len) ->
         godot_method_bind_call bindImage__set_data (upcast cls) arrPtr len
           >>= \ (err, res) -> throwIfErr err >> fromGodotVariant res)

instance NodeMethod Image "_set_data" '[Dictionary] (IO ()) where
        nodeMethod = Godot.Core.Image._set_data

{-# NOINLINE bindImage_blend_rect #-}

-- | Alpha-blends @src_rect@ from @src@ image to this image at coordinates @dest@.
bindImage_blend_rect :: MethodBind
bindImage_blend_rect
  = unsafePerformIO $
      withCString "Image" $
        \ clsNamePtr ->
          withCString "blend_rect" $
            \ methodNamePtr ->
              godot_method_bind_get_method clsNamePtr methodNamePtr

-- | Alpha-blends @src_rect@ from @src@ image to this image at coordinates @dest@.
blend_rect ::
             (Image :< cls, Object :< cls) =>
             cls -> Image -> Rect2 -> Vector2 -> IO ()
blend_rect cls arg1 arg2 arg3
  = withVariantArray [toVariant arg1, toVariant arg2, toVariant arg3]
      (\ (arrPtr, len) ->
         godot_method_bind_call bindImage_blend_rect (upcast cls) arrPtr len
           >>= \ (err, res) -> throwIfErr err >> fromGodotVariant res)

instance NodeMethod Image "blend_rect" '[Image, Rect2, Vector2]
           (IO ())
         where
        nodeMethod = Godot.Core.Image.blend_rect

{-# NOINLINE bindImage_blend_rect_mask #-}

-- | Alpha-blends @src_rect@ from @src@ image to this image using @mask@ image at coordinates @dst@. Alpha channels are required for both @src@ and @mask@. @dst@ pixels and @src@ pixels will blend if the corresponding mask pixel's alpha value is not 0. @src@ image and @mask@ image __must__ have the same size (width and height) but they can have different formats.
bindImage_blend_rect_mask :: MethodBind
bindImage_blend_rect_mask
  = unsafePerformIO $
      withCString "Image" $
        \ clsNamePtr ->
          withCString "blend_rect_mask" $
            \ methodNamePtr ->
              godot_method_bind_get_method clsNamePtr methodNamePtr

-- | Alpha-blends @src_rect@ from @src@ image to this image using @mask@ image at coordinates @dst@. Alpha channels are required for both @src@ and @mask@. @dst@ pixels and @src@ pixels will blend if the corresponding mask pixel's alpha value is not 0. @src@ image and @mask@ image __must__ have the same size (width and height) but they can have different formats.
blend_rect_mask ::
                  (Image :< cls, Object :< cls) =>
                  cls -> Image -> Image -> Rect2 -> Vector2 -> IO ()
blend_rect_mask cls arg1 arg2 arg3 arg4
  = withVariantArray
      [toVariant arg1, toVariant arg2, toVariant arg3, toVariant arg4]
      (\ (arrPtr, len) ->
         godot_method_bind_call bindImage_blend_rect_mask (upcast cls)
           arrPtr
           len
           >>= \ (err, res) -> throwIfErr err >> fromGodotVariant res)

instance NodeMethod Image "blend_rect_mask"
           '[Image, Image, Rect2, Vector2]
           (IO ())
         where
        nodeMethod = Godot.Core.Image.blend_rect_mask

{-# NOINLINE bindImage_blit_rect #-}

-- | Copies @src_rect@ from @src@ image to this image at coordinates @dst@.
bindImage_blit_rect :: MethodBind
bindImage_blit_rect
  = unsafePerformIO $
      withCString "Image" $
        \ clsNamePtr ->
          withCString "blit_rect" $
            \ methodNamePtr ->
              godot_method_bind_get_method clsNamePtr methodNamePtr

-- | Copies @src_rect@ from @src@ image to this image at coordinates @dst@.
blit_rect ::
            (Image :< cls, Object :< cls) =>
            cls -> Image -> Rect2 -> Vector2 -> IO ()
blit_rect cls arg1 arg2 arg3
  = withVariantArray [toVariant arg1, toVariant arg2, toVariant arg3]
      (\ (arrPtr, len) ->
         godot_method_bind_call bindImage_blit_rect (upcast cls) arrPtr len
           >>= \ (err, res) -> throwIfErr err >> fromGodotVariant res)

instance NodeMethod Image "blit_rect" '[Image, Rect2, Vector2]
           (IO ())
         where
        nodeMethod = Godot.Core.Image.blit_rect

{-# NOINLINE bindImage_blit_rect_mask #-}

-- | Blits @src_rect@ area from @src@ image to this image at the coordinates given by @dst@. @src@ pixel is copied onto @dst@ if the corresponding @mask@ pixel's alpha value is not 0. @src@ image and @mask@ image __must__ have the same size (width and height) but they can have different formats.
bindImage_blit_rect_mask :: MethodBind
bindImage_blit_rect_mask
  = unsafePerformIO $
      withCString "Image" $
        \ clsNamePtr ->
          withCString "blit_rect_mask" $
            \ methodNamePtr ->
              godot_method_bind_get_method clsNamePtr methodNamePtr

-- | Blits @src_rect@ area from @src@ image to this image at the coordinates given by @dst@. @src@ pixel is copied onto @dst@ if the corresponding @mask@ pixel's alpha value is not 0. @src@ image and @mask@ image __must__ have the same size (width and height) but they can have different formats.
blit_rect_mask ::
                 (Image :< cls, Object :< cls) =>
                 cls -> Image -> Image -> Rect2 -> Vector2 -> IO ()
blit_rect_mask cls arg1 arg2 arg3 arg4
  = withVariantArray
      [toVariant arg1, toVariant arg2, toVariant arg3, toVariant arg4]
      (\ (arrPtr, len) ->
         godot_method_bind_call bindImage_blit_rect_mask (upcast cls) arrPtr
           len
           >>= \ (err, res) -> throwIfErr err >> fromGodotVariant res)

instance NodeMethod Image "blit_rect_mask"
           '[Image, Image, Rect2, Vector2]
           (IO ())
         where
        nodeMethod = Godot.Core.Image.blit_rect_mask

{-# NOINLINE bindImage_bumpmap_to_normalmap #-}

-- | Converts a bumpmap to a normalmap. A bumpmap provides a height offset per-pixel, while a normalmap provides a normal direction per pixel.
bindImage_bumpmap_to_normalmap :: MethodBind
bindImage_bumpmap_to_normalmap
  = unsafePerformIO $
      withCString "Image" $
        \ clsNamePtr ->
          withCString "bumpmap_to_normalmap" $
            \ methodNamePtr ->
              godot_method_bind_get_method clsNamePtr methodNamePtr

-- | Converts a bumpmap to a normalmap. A bumpmap provides a height offset per-pixel, while a normalmap provides a normal direction per pixel.
bumpmap_to_normalmap ::
                       (Image :< cls, Object :< cls) => cls -> Maybe Float -> IO ()
bumpmap_to_normalmap cls arg1
  = withVariantArray [maybe (VariantReal (1)) toVariant arg1]
      (\ (arrPtr, len) ->
         godot_method_bind_call bindImage_bumpmap_to_normalmap (upcast cls)
           arrPtr
           len
           >>= \ (err, res) -> throwIfErr err >> fromGodotVariant res)

instance NodeMethod Image "bumpmap_to_normalmap" '[Maybe Float]
           (IO ())
         where
        nodeMethod = Godot.Core.Image.bumpmap_to_normalmap

{-# NOINLINE bindImage_clear_mipmaps #-}

-- | Removes the image's mipmaps.
bindImage_clear_mipmaps :: MethodBind
bindImage_clear_mipmaps
  = unsafePerformIO $
      withCString "Image" $
        \ clsNamePtr ->
          withCString "clear_mipmaps" $
            \ methodNamePtr ->
              godot_method_bind_get_method clsNamePtr methodNamePtr

-- | Removes the image's mipmaps.
clear_mipmaps :: (Image :< cls, Object :< cls) => cls -> IO ()
clear_mipmaps cls
  = withVariantArray []
      (\ (arrPtr, len) ->
         godot_method_bind_call bindImage_clear_mipmaps (upcast cls) arrPtr
           len
           >>= \ (err, res) -> throwIfErr err >> fromGodotVariant res)

instance NodeMethod Image "clear_mipmaps" '[] (IO ()) where
        nodeMethod = Godot.Core.Image.clear_mipmaps

{-# NOINLINE bindImage_compress #-}

-- | Compresses the image to use less memory. Can not directly access pixel data while the image is compressed. Returns error if the chosen compression mode is not available. See @enum CompressMode@ and @enum CompressSource@ constants.
bindImage_compress :: MethodBind
bindImage_compress
  = unsafePerformIO $
      withCString "Image" $
        \ clsNamePtr ->
          withCString "compress" $
            \ methodNamePtr ->
              godot_method_bind_get_method clsNamePtr methodNamePtr

-- | Compresses the image to use less memory. Can not directly access pixel data while the image is compressed. Returns error if the chosen compression mode is not available. See @enum CompressMode@ and @enum CompressSource@ constants.
compress ::
           (Image :< cls, Object :< cls) =>
           cls -> Int -> Int -> Float -> IO Int
compress cls arg1 arg2 arg3
  = withVariantArray [toVariant arg1, toVariant arg2, toVariant arg3]
      (\ (arrPtr, len) ->
         godot_method_bind_call bindImage_compress (upcast cls) arrPtr len
           >>= \ (err, res) -> throwIfErr err >> fromGodotVariant res)

instance NodeMethod Image "compress" '[Int, Int, Float] (IO Int)
         where
        nodeMethod = Godot.Core.Image.compress

{-# NOINLINE bindImage_convert #-}

-- | Converts the image's format. See @enum Format@ constants.
bindImage_convert :: MethodBind
bindImage_convert
  = unsafePerformIO $
      withCString "Image" $
        \ clsNamePtr ->
          withCString "convert" $
            \ methodNamePtr ->
              godot_method_bind_get_method clsNamePtr methodNamePtr

-- | Converts the image's format. See @enum Format@ constants.
convert :: (Image :< cls, Object :< cls) => cls -> Int -> IO ()
convert cls arg1
  = withVariantArray [toVariant arg1]
      (\ (arrPtr, len) ->
         godot_method_bind_call bindImage_convert (upcast cls) arrPtr len
           >>= \ (err, res) -> throwIfErr err >> fromGodotVariant res)

instance NodeMethod Image "convert" '[Int] (IO ()) where
        nodeMethod = Godot.Core.Image.convert

{-# NOINLINE bindImage_copy_from #-}

-- | Copies @src@ image to this image.
bindImage_copy_from :: MethodBind
bindImage_copy_from
  = unsafePerformIO $
      withCString "Image" $
        \ clsNamePtr ->
          withCString "copy_from" $
            \ methodNamePtr ->
              godot_method_bind_get_method clsNamePtr methodNamePtr

-- | Copies @src@ image to this image.
copy_from :: (Image :< cls, Object :< cls) => cls -> Image -> IO ()
copy_from cls arg1
  = withVariantArray [toVariant arg1]
      (\ (arrPtr, len) ->
         godot_method_bind_call bindImage_copy_from (upcast cls) arrPtr len
           >>= \ (err, res) -> throwIfErr err >> fromGodotVariant res)

instance NodeMethod Image "copy_from" '[Image] (IO ()) where
        nodeMethod = Godot.Core.Image.copy_from

{-# NOINLINE bindImage_create #-}

-- | Creates an empty image of given size and format. See @enum Format@ constants. If @use_mipmaps@ is @true@ then generate mipmaps for this image. See the @method generate_mipmaps@.
bindImage_create :: MethodBind
bindImage_create
  = unsafePerformIO $
      withCString "Image" $
        \ clsNamePtr ->
          withCString "create" $
            \ methodNamePtr ->
              godot_method_bind_get_method clsNamePtr methodNamePtr

-- | Creates an empty image of given size and format. See @enum Format@ constants. If @use_mipmaps@ is @true@ then generate mipmaps for this image. See the @method generate_mipmaps@.
create ::
         (Image :< cls, Object :< cls) =>
         cls -> Int -> Int -> Bool -> Int -> IO ()
create cls arg1 arg2 arg3 arg4
  = withVariantArray
      [toVariant arg1, toVariant arg2, toVariant arg3, toVariant arg4]
      (\ (arrPtr, len) ->
         godot_method_bind_call bindImage_create (upcast cls) arrPtr len >>=
           \ (err, res) -> throwIfErr err >> fromGodotVariant res)

instance NodeMethod Image "create" '[Int, Int, Bool, Int] (IO ())
         where
        nodeMethod = Godot.Core.Image.create

{-# NOINLINE bindImage_create_from_data #-}

-- | Creates a new image of given size and format. See @enum Format@ constants. Fills the image with the given raw data. If @use_mipmaps@ is @true@ then loads mipmaps for this image from @data@. See @method generate_mipmaps@.
bindImage_create_from_data :: MethodBind
bindImage_create_from_data
  = unsafePerformIO $
      withCString "Image" $
        \ clsNamePtr ->
          withCString "create_from_data" $
            \ methodNamePtr ->
              godot_method_bind_get_method clsNamePtr methodNamePtr

-- | Creates a new image of given size and format. See @enum Format@ constants. Fills the image with the given raw data. If @use_mipmaps@ is @true@ then loads mipmaps for this image from @data@. See @method generate_mipmaps@.
create_from_data ::
                   (Image :< cls, Object :< cls) =>
                   cls -> Int -> Int -> Bool -> Int -> PoolByteArray -> IO ()
create_from_data cls arg1 arg2 arg3 arg4 arg5
  = withVariantArray
      [toVariant arg1, toVariant arg2, toVariant arg3, toVariant arg4,
       toVariant arg5]
      (\ (arrPtr, len) ->
         godot_method_bind_call bindImage_create_from_data (upcast cls)
           arrPtr
           len
           >>= \ (err, res) -> throwIfErr err >> fromGodotVariant res)

instance NodeMethod Image "create_from_data"
           '[Int, Int, Bool, Int, PoolByteArray]
           (IO ())
         where
        nodeMethod = Godot.Core.Image.create_from_data

{-# NOINLINE bindImage_crop #-}

-- | Crops the image to the given @width@ and @height@. If the specified size is larger than the current size, the extra area is filled with black pixels.
bindImage_crop :: MethodBind
bindImage_crop
  = unsafePerformIO $
      withCString "Image" $
        \ clsNamePtr ->
          withCString "crop" $
            \ methodNamePtr ->
              godot_method_bind_get_method clsNamePtr methodNamePtr

-- | Crops the image to the given @width@ and @height@. If the specified size is larger than the current size, the extra area is filled with black pixels.
crop :: (Image :< cls, Object :< cls) => cls -> Int -> Int -> IO ()
crop cls arg1 arg2
  = withVariantArray [toVariant arg1, toVariant arg2]
      (\ (arrPtr, len) ->
         godot_method_bind_call bindImage_crop (upcast cls) arrPtr len >>=
           \ (err, res) -> throwIfErr err >> fromGodotVariant res)

instance NodeMethod Image "crop" '[Int, Int] (IO ()) where
        nodeMethod = Godot.Core.Image.crop

{-# NOINLINE bindImage_decompress #-}

-- | Decompresses the image if it is compressed. Returns an error if decompress function is not available.
bindImage_decompress :: MethodBind
bindImage_decompress
  = unsafePerformIO $
      withCString "Image" $
        \ clsNamePtr ->
          withCString "decompress" $
            \ methodNamePtr ->
              godot_method_bind_get_method clsNamePtr methodNamePtr

-- | Decompresses the image if it is compressed. Returns an error if decompress function is not available.
decompress :: (Image :< cls, Object :< cls) => cls -> IO Int
decompress cls
  = withVariantArray []
      (\ (arrPtr, len) ->
         godot_method_bind_call bindImage_decompress (upcast cls) arrPtr len
           >>= \ (err, res) -> throwIfErr err >> fromGodotVariant res)

instance NodeMethod Image "decompress" '[] (IO Int) where
        nodeMethod = Godot.Core.Image.decompress

{-# NOINLINE bindImage_detect_alpha #-}

-- | Returns @ALPHA_BLEND@ if the image has data for alpha values. Returns @ALPHA_BIT@ if all the alpha values are stored in a single bit. Returns @ALPHA_NONE@ if no data for alpha values is found.
bindImage_detect_alpha :: MethodBind
bindImage_detect_alpha
  = unsafePerformIO $
      withCString "Image" $
        \ clsNamePtr ->
          withCString "detect_alpha" $
            \ methodNamePtr ->
              godot_method_bind_get_method clsNamePtr methodNamePtr

-- | Returns @ALPHA_BLEND@ if the image has data for alpha values. Returns @ALPHA_BIT@ if all the alpha values are stored in a single bit. Returns @ALPHA_NONE@ if no data for alpha values is found.
detect_alpha :: (Image :< cls, Object :< cls) => cls -> IO Int
detect_alpha cls
  = withVariantArray []
      (\ (arrPtr, len) ->
         godot_method_bind_call bindImage_detect_alpha (upcast cls) arrPtr
           len
           >>= \ (err, res) -> throwIfErr err >> fromGodotVariant res)

instance NodeMethod Image "detect_alpha" '[] (IO Int) where
        nodeMethod = Godot.Core.Image.detect_alpha

{-# NOINLINE bindImage_expand_x2_hq2x #-}

-- | Stretches the image and enlarges it by a factor of 2. No interpolation is done.
bindImage_expand_x2_hq2x :: MethodBind
bindImage_expand_x2_hq2x
  = unsafePerformIO $
      withCString "Image" $
        \ clsNamePtr ->
          withCString "expand_x2_hq2x" $
            \ methodNamePtr ->
              godot_method_bind_get_method clsNamePtr methodNamePtr

-- | Stretches the image and enlarges it by a factor of 2. No interpolation is done.
expand_x2_hq2x :: (Image :< cls, Object :< cls) => cls -> IO ()
expand_x2_hq2x cls
  = withVariantArray []
      (\ (arrPtr, len) ->
         godot_method_bind_call bindImage_expand_x2_hq2x (upcast cls) arrPtr
           len
           >>= \ (err, res) -> throwIfErr err >> fromGodotVariant res)

instance NodeMethod Image "expand_x2_hq2x" '[] (IO ()) where
        nodeMethod = Godot.Core.Image.expand_x2_hq2x

{-# NOINLINE bindImage_fill #-}

-- | Fills the image with a given @Color@.
bindImage_fill :: MethodBind
bindImage_fill
  = unsafePerformIO $
      withCString "Image" $
        \ clsNamePtr ->
          withCString "fill" $
            \ methodNamePtr ->
              godot_method_bind_get_method clsNamePtr methodNamePtr

-- | Fills the image with a given @Color@.
fill :: (Image :< cls, Object :< cls) => cls -> Color -> IO ()
fill cls arg1
  = withVariantArray [toVariant arg1]
      (\ (arrPtr, len) ->
         godot_method_bind_call bindImage_fill (upcast cls) arrPtr len >>=
           \ (err, res) -> throwIfErr err >> fromGodotVariant res)

instance NodeMethod Image "fill" '[Color] (IO ()) where
        nodeMethod = Godot.Core.Image.fill

{-# NOINLINE bindImage_fix_alpha_edges #-}

-- | Blends low-alpha pixels with nearby pixels.
bindImage_fix_alpha_edges :: MethodBind
bindImage_fix_alpha_edges
  = unsafePerformIO $
      withCString "Image" $
        \ clsNamePtr ->
          withCString "fix_alpha_edges" $
            \ methodNamePtr ->
              godot_method_bind_get_method clsNamePtr methodNamePtr

-- | Blends low-alpha pixels with nearby pixels.
fix_alpha_edges :: (Image :< cls, Object :< cls) => cls -> IO ()
fix_alpha_edges cls
  = withVariantArray []
      (\ (arrPtr, len) ->
         godot_method_bind_call bindImage_fix_alpha_edges (upcast cls)
           arrPtr
           len
           >>= \ (err, res) -> throwIfErr err >> fromGodotVariant res)

instance NodeMethod Image "fix_alpha_edges" '[] (IO ()) where
        nodeMethod = Godot.Core.Image.fix_alpha_edges

{-# NOINLINE bindImage_flip_x #-}

-- | Flips the image horizontally.
bindImage_flip_x :: MethodBind
bindImage_flip_x
  = unsafePerformIO $
      withCString "Image" $
        \ clsNamePtr ->
          withCString "flip_x" $
            \ methodNamePtr ->
              godot_method_bind_get_method clsNamePtr methodNamePtr

-- | Flips the image horizontally.
flip_x :: (Image :< cls, Object :< cls) => cls -> IO ()
flip_x cls
  = withVariantArray []
      (\ (arrPtr, len) ->
         godot_method_bind_call bindImage_flip_x (upcast cls) arrPtr len >>=
           \ (err, res) -> throwIfErr err >> fromGodotVariant res)

instance NodeMethod Image "flip_x" '[] (IO ()) where
        nodeMethod = Godot.Core.Image.flip_x

{-# NOINLINE bindImage_flip_y #-}

-- | Flips the image vertically.
bindImage_flip_y :: MethodBind
bindImage_flip_y
  = unsafePerformIO $
      withCString "Image" $
        \ clsNamePtr ->
          withCString "flip_y" $
            \ methodNamePtr ->
              godot_method_bind_get_method clsNamePtr methodNamePtr

-- | Flips the image vertically.
flip_y :: (Image :< cls, Object :< cls) => cls -> IO ()
flip_y cls
  = withVariantArray []
      (\ (arrPtr, len) ->
         godot_method_bind_call bindImage_flip_y (upcast cls) arrPtr len >>=
           \ (err, res) -> throwIfErr err >> fromGodotVariant res)

instance NodeMethod Image "flip_y" '[] (IO ()) where
        nodeMethod = Godot.Core.Image.flip_y

{-# NOINLINE bindImage_generate_mipmaps #-}

-- | Generates mipmaps for the image. Mipmaps are precalculated lower-resolution copies of the image that are automatically used if the image needs to be scaled down when rendered. They help improve image quality and performance when rendering. This method returns an error if the image is compressed, in a custom format, or if the image's width/height is @0@.
bindImage_generate_mipmaps :: MethodBind
bindImage_generate_mipmaps
  = unsafePerformIO $
      withCString "Image" $
        \ clsNamePtr ->
          withCString "generate_mipmaps" $
            \ methodNamePtr ->
              godot_method_bind_get_method clsNamePtr methodNamePtr

-- | Generates mipmaps for the image. Mipmaps are precalculated lower-resolution copies of the image that are automatically used if the image needs to be scaled down when rendered. They help improve image quality and performance when rendering. This method returns an error if the image is compressed, in a custom format, or if the image's width/height is @0@.
generate_mipmaps ::
                   (Image :< cls, Object :< cls) => cls -> Maybe Bool -> IO Int
generate_mipmaps cls arg1
  = withVariantArray [maybe (VariantBool False) toVariant arg1]
      (\ (arrPtr, len) ->
         godot_method_bind_call bindImage_generate_mipmaps (upcast cls)
           arrPtr
           len
           >>= \ (err, res) -> throwIfErr err >> fromGodotVariant res)

instance NodeMethod Image "generate_mipmaps" '[Maybe Bool] (IO Int)
         where
        nodeMethod = Godot.Core.Image.generate_mipmaps

{-# NOINLINE bindImage_get_data #-}

-- | Returns a copy of the image's raw data.
bindImage_get_data :: MethodBind
bindImage_get_data
  = unsafePerformIO $
      withCString "Image" $
        \ clsNamePtr ->
          withCString "get_data" $
            \ methodNamePtr ->
              godot_method_bind_get_method clsNamePtr methodNamePtr

-- | Returns a copy of the image's raw data.
get_data ::
           (Image :< cls, Object :< cls) => cls -> IO PoolByteArray
get_data cls
  = withVariantArray []
      (\ (arrPtr, len) ->
         godot_method_bind_call bindImage_get_data (upcast cls) arrPtr len
           >>= \ (err, res) -> throwIfErr err >> fromGodotVariant res)

instance NodeMethod Image "get_data" '[] (IO PoolByteArray) where
        nodeMethod = Godot.Core.Image.get_data

{-# NOINLINE bindImage_get_format #-}

-- | Returns the image's format. See @enum Format@ constants.
bindImage_get_format :: MethodBind
bindImage_get_format
  = unsafePerformIO $
      withCString "Image" $
        \ clsNamePtr ->
          withCString "get_format" $
            \ methodNamePtr ->
              godot_method_bind_get_method clsNamePtr methodNamePtr

-- | Returns the image's format. See @enum Format@ constants.
get_format :: (Image :< cls, Object :< cls) => cls -> IO Int
get_format cls
  = withVariantArray []
      (\ (arrPtr, len) ->
         godot_method_bind_call bindImage_get_format (upcast cls) arrPtr len
           >>= \ (err, res) -> throwIfErr err >> fromGodotVariant res)

instance NodeMethod Image "get_format" '[] (IO Int) where
        nodeMethod = Godot.Core.Image.get_format

{-# NOINLINE bindImage_get_height #-}

-- | Returns the image's height.
bindImage_get_height :: MethodBind
bindImage_get_height
  = unsafePerformIO $
      withCString "Image" $
        \ clsNamePtr ->
          withCString "get_height" $
            \ methodNamePtr ->
              godot_method_bind_get_method clsNamePtr methodNamePtr

-- | Returns the image's height.
get_height :: (Image :< cls, Object :< cls) => cls -> IO Int
get_height cls
  = withVariantArray []
      (\ (arrPtr, len) ->
         godot_method_bind_call bindImage_get_height (upcast cls) arrPtr len
           >>= \ (err, res) -> throwIfErr err >> fromGodotVariant res)

instance NodeMethod Image "get_height" '[] (IO Int) where
        nodeMethod = Godot.Core.Image.get_height

{-# NOINLINE bindImage_get_mipmap_offset #-}

-- | Returns the offset where the image's mipmap with index @mipmap@ is stored in the @data@ dictionary.
bindImage_get_mipmap_offset :: MethodBind
bindImage_get_mipmap_offset
  = unsafePerformIO $
      withCString "Image" $
        \ clsNamePtr ->
          withCString "get_mipmap_offset" $
            \ methodNamePtr ->
              godot_method_bind_get_method clsNamePtr methodNamePtr

-- | Returns the offset where the image's mipmap with index @mipmap@ is stored in the @data@ dictionary.
get_mipmap_offset ::
                    (Image :< cls, Object :< cls) => cls -> Int -> IO Int
get_mipmap_offset cls arg1
  = withVariantArray [toVariant arg1]
      (\ (arrPtr, len) ->
         godot_method_bind_call bindImage_get_mipmap_offset (upcast cls)
           arrPtr
           len
           >>= \ (err, res) -> throwIfErr err >> fromGodotVariant res)

instance NodeMethod Image "get_mipmap_offset" '[Int] (IO Int) where
        nodeMethod = Godot.Core.Image.get_mipmap_offset

{-# NOINLINE bindImage_get_pixel #-}

-- | Returns the color of the pixel at @(x, y)@ if the image is locked. If the image is unlocked, it always returns a @Color@ with the value @(0, 0, 0, 1.0)@. This is the same as @method get_pixelv@, but two integer arguments instead of a Vector2 argument.
bindImage_get_pixel :: MethodBind
bindImage_get_pixel
  = unsafePerformIO $
      withCString "Image" $
        \ clsNamePtr ->
          withCString "get_pixel" $
            \ methodNamePtr ->
              godot_method_bind_get_method clsNamePtr methodNamePtr

-- | Returns the color of the pixel at @(x, y)@ if the image is locked. If the image is unlocked, it always returns a @Color@ with the value @(0, 0, 0, 1.0)@. This is the same as @method get_pixelv@, but two integer arguments instead of a Vector2 argument.
get_pixel ::
            (Image :< cls, Object :< cls) => cls -> Int -> Int -> IO Color
get_pixel cls arg1 arg2
  = withVariantArray [toVariant arg1, toVariant arg2]
      (\ (arrPtr, len) ->
         godot_method_bind_call bindImage_get_pixel (upcast cls) arrPtr len
           >>= \ (err, res) -> throwIfErr err >> fromGodotVariant res)

instance NodeMethod Image "get_pixel" '[Int, Int] (IO Color) where
        nodeMethod = Godot.Core.Image.get_pixel

{-# NOINLINE bindImage_get_pixelv #-}

-- | Returns the color of the pixel at @src@ if the image is locked. If the image is unlocked, it always returns a @Color@ with the value @(0, 0, 0, 1.0)@. This is the same as @method get_pixel@, but with a Vector2 argument instead of two integer arguments.
bindImage_get_pixelv :: MethodBind
bindImage_get_pixelv
  = unsafePerformIO $
      withCString "Image" $
        \ clsNamePtr ->
          withCString "get_pixelv" $
            \ methodNamePtr ->
              godot_method_bind_get_method clsNamePtr methodNamePtr

-- | Returns the color of the pixel at @src@ if the image is locked. If the image is unlocked, it always returns a @Color@ with the value @(0, 0, 0, 1.0)@. This is the same as @method get_pixel@, but with a Vector2 argument instead of two integer arguments.
get_pixelv ::
             (Image :< cls, Object :< cls) => cls -> Vector2 -> IO Color
get_pixelv cls arg1
  = withVariantArray [toVariant arg1]
      (\ (arrPtr, len) ->
         godot_method_bind_call bindImage_get_pixelv (upcast cls) arrPtr len
           >>= \ (err, res) -> throwIfErr err >> fromGodotVariant res)

instance NodeMethod Image "get_pixelv" '[Vector2] (IO Color) where
        nodeMethod = Godot.Core.Image.get_pixelv

{-# NOINLINE bindImage_get_rect #-}

-- | Returns a new image that is a copy of the image's area specified with @rect@.
bindImage_get_rect :: MethodBind
bindImage_get_rect
  = unsafePerformIO $
      withCString "Image" $
        \ clsNamePtr ->
          withCString "get_rect" $
            \ methodNamePtr ->
              godot_method_bind_get_method clsNamePtr methodNamePtr

-- | Returns a new image that is a copy of the image's area specified with @rect@.
get_rect ::
           (Image :< cls, Object :< cls) => cls -> Rect2 -> IO Image
get_rect cls arg1
  = withVariantArray [toVariant arg1]
      (\ (arrPtr, len) ->
         godot_method_bind_call bindImage_get_rect (upcast cls) arrPtr len
           >>= \ (err, res) -> throwIfErr err >> fromGodotVariant res)

instance NodeMethod Image "get_rect" '[Rect2] (IO Image) where
        nodeMethod = Godot.Core.Image.get_rect

{-# NOINLINE bindImage_get_size #-}

-- | Returns the image's size (width and height).
bindImage_get_size :: MethodBind
bindImage_get_size
  = unsafePerformIO $
      withCString "Image" $
        \ clsNamePtr ->
          withCString "get_size" $
            \ methodNamePtr ->
              godot_method_bind_get_method clsNamePtr methodNamePtr

-- | Returns the image's size (width and height).
get_size :: (Image :< cls, Object :< cls) => cls -> IO Vector2
get_size cls
  = withVariantArray []
      (\ (arrPtr, len) ->
         godot_method_bind_call bindImage_get_size (upcast cls) arrPtr len
           >>= \ (err, res) -> throwIfErr err >> fromGodotVariant res)

instance NodeMethod Image "get_size" '[] (IO Vector2) where
        nodeMethod = Godot.Core.Image.get_size

{-# NOINLINE bindImage_get_used_rect #-}

-- | Returns a @Rect2@ enclosing the visible portion of the image, considering each pixel with a non-zero alpha channel as visible.
bindImage_get_used_rect :: MethodBind
bindImage_get_used_rect
  = unsafePerformIO $
      withCString "Image" $
        \ clsNamePtr ->
          withCString "get_used_rect" $
            \ methodNamePtr ->
              godot_method_bind_get_method clsNamePtr methodNamePtr

-- | Returns a @Rect2@ enclosing the visible portion of the image, considering each pixel with a non-zero alpha channel as visible.
get_used_rect :: (Image :< cls, Object :< cls) => cls -> IO Rect2
get_used_rect cls
  = withVariantArray []
      (\ (arrPtr, len) ->
         godot_method_bind_call bindImage_get_used_rect (upcast cls) arrPtr
           len
           >>= \ (err, res) -> throwIfErr err >> fromGodotVariant res)

instance NodeMethod Image "get_used_rect" '[] (IO Rect2) where
        nodeMethod = Godot.Core.Image.get_used_rect

{-# NOINLINE bindImage_get_width #-}

-- | Returns the image's width.
bindImage_get_width :: MethodBind
bindImage_get_width
  = unsafePerformIO $
      withCString "Image" $
        \ clsNamePtr ->
          withCString "get_width" $
            \ methodNamePtr ->
              godot_method_bind_get_method clsNamePtr methodNamePtr

-- | Returns the image's width.
get_width :: (Image :< cls, Object :< cls) => cls -> IO Int
get_width cls
  = withVariantArray []
      (\ (arrPtr, len) ->
         godot_method_bind_call bindImage_get_width (upcast cls) arrPtr len
           >>= \ (err, res) -> throwIfErr err >> fromGodotVariant res)

instance NodeMethod Image "get_width" '[] (IO Int) where
        nodeMethod = Godot.Core.Image.get_width

{-# NOINLINE bindImage_has_mipmaps #-}

-- | Returns @true@ if the image has generated mipmaps.
bindImage_has_mipmaps :: MethodBind
bindImage_has_mipmaps
  = unsafePerformIO $
      withCString "Image" $
        \ clsNamePtr ->
          withCString "has_mipmaps" $
            \ methodNamePtr ->
              godot_method_bind_get_method clsNamePtr methodNamePtr

-- | Returns @true@ if the image has generated mipmaps.
has_mipmaps :: (Image :< cls, Object :< cls) => cls -> IO Bool
has_mipmaps cls
  = withVariantArray []
      (\ (arrPtr, len) ->
         godot_method_bind_call bindImage_has_mipmaps (upcast cls) arrPtr
           len
           >>= \ (err, res) -> throwIfErr err >> fromGodotVariant res)

instance NodeMethod Image "has_mipmaps" '[] (IO Bool) where
        nodeMethod = Godot.Core.Image.has_mipmaps

{-# NOINLINE bindImage_is_compressed #-}

-- | Returns @true@ if the image is compressed.
bindImage_is_compressed :: MethodBind
bindImage_is_compressed
  = unsafePerformIO $
      withCString "Image" $
        \ clsNamePtr ->
          withCString "is_compressed" $
            \ methodNamePtr ->
              godot_method_bind_get_method clsNamePtr methodNamePtr

-- | Returns @true@ if the image is compressed.
is_compressed :: (Image :< cls, Object :< cls) => cls -> IO Bool
is_compressed cls
  = withVariantArray []
      (\ (arrPtr, len) ->
         godot_method_bind_call bindImage_is_compressed (upcast cls) arrPtr
           len
           >>= \ (err, res) -> throwIfErr err >> fromGodotVariant res)

instance NodeMethod Image "is_compressed" '[] (IO Bool) where
        nodeMethod = Godot.Core.Image.is_compressed

{-# NOINLINE bindImage_is_empty #-}

-- | Returns @true@ if the image has no data.
bindImage_is_empty :: MethodBind
bindImage_is_empty
  = unsafePerformIO $
      withCString "Image" $
        \ clsNamePtr ->
          withCString "is_empty" $
            \ methodNamePtr ->
              godot_method_bind_get_method clsNamePtr methodNamePtr

-- | Returns @true@ if the image has no data.
is_empty :: (Image :< cls, Object :< cls) => cls -> IO Bool
is_empty cls
  = withVariantArray []
      (\ (arrPtr, len) ->
         godot_method_bind_call bindImage_is_empty (upcast cls) arrPtr len
           >>= \ (err, res) -> throwIfErr err >> fromGodotVariant res)

instance NodeMethod Image "is_empty" '[] (IO Bool) where
        nodeMethod = Godot.Core.Image.is_empty

{-# NOINLINE bindImage_is_invisible #-}

-- | Returns @true@ if all the image's pixels have an alpha value of 0. Returns @false@ if any pixel has an alpha value higher than 0.
bindImage_is_invisible :: MethodBind
bindImage_is_invisible
  = unsafePerformIO $
      withCString "Image" $
        \ clsNamePtr ->
          withCString "is_invisible" $
            \ methodNamePtr ->
              godot_method_bind_get_method clsNamePtr methodNamePtr

-- | Returns @true@ if all the image's pixels have an alpha value of 0. Returns @false@ if any pixel has an alpha value higher than 0.
is_invisible :: (Image :< cls, Object :< cls) => cls -> IO Bool
is_invisible cls
  = withVariantArray []
      (\ (arrPtr, len) ->
         godot_method_bind_call bindImage_is_invisible (upcast cls) arrPtr
           len
           >>= \ (err, res) -> throwIfErr err >> fromGodotVariant res)

instance NodeMethod Image "is_invisible" '[] (IO Bool) where
        nodeMethod = Godot.Core.Image.is_invisible

{-# NOINLINE bindImage_load #-}

-- | Loads an image from file @path@. See @url=https://docs.godotengine.org/en/3.3/getting_started/workflow/assets/importing_images.html#supported-image-formats@Supported image formats@/url@ for a list of supported image formats and limitations.
--   				__Warning:__ This method should only be used in the editor or in cases when you need to load external images at run-time, such as images located at the @user://@ directory, and may not work in exported projects.
--   				See also @ImageTexture@ description for usage examples.
bindImage_load :: MethodBind
bindImage_load
  = unsafePerformIO $
      withCString "Image" $
        \ clsNamePtr ->
          withCString "load" $
            \ methodNamePtr ->
              godot_method_bind_get_method clsNamePtr methodNamePtr

-- | Loads an image from file @path@. See @url=https://docs.godotengine.org/en/3.3/getting_started/workflow/assets/importing_images.html#supported-image-formats@Supported image formats@/url@ for a list of supported image formats and limitations.
--   				__Warning:__ This method should only be used in the editor or in cases when you need to load external images at run-time, such as images located at the @user://@ directory, and may not work in exported projects.
--   				See also @ImageTexture@ description for usage examples.
load ::
       (Image :< cls, Object :< cls) => cls -> GodotString -> IO Int
load cls arg1
  = withVariantArray [toVariant arg1]
      (\ (arrPtr, len) ->
         godot_method_bind_call bindImage_load (upcast cls) arrPtr len >>=
           \ (err, res) -> throwIfErr err >> fromGodotVariant res)

instance NodeMethod Image "load" '[GodotString] (IO Int) where
        nodeMethod = Godot.Core.Image.load

{-# NOINLINE bindImage_load_bmp_from_buffer #-}

-- | Loads an image from the binary contents of a BMP file.
--   				__Note:__ Godot's BMP module doesn't support 16-bit per pixel images. Only 1-bit, 4-bit, 8-bit, 24-bit, and 32-bit per pixel images are supported.
bindImage_load_bmp_from_buffer :: MethodBind
bindImage_load_bmp_from_buffer
  = unsafePerformIO $
      withCString "Image" $
        \ clsNamePtr ->
          withCString "load_bmp_from_buffer" $
            \ methodNamePtr ->
              godot_method_bind_get_method clsNamePtr methodNamePtr

-- | Loads an image from the binary contents of a BMP file.
--   				__Note:__ Godot's BMP module doesn't support 16-bit per pixel images. Only 1-bit, 4-bit, 8-bit, 24-bit, and 32-bit per pixel images are supported.
load_bmp_from_buffer ::
                       (Image :< cls, Object :< cls) => cls -> PoolByteArray -> IO Int
load_bmp_from_buffer cls arg1
  = withVariantArray [toVariant arg1]
      (\ (arrPtr, len) ->
         godot_method_bind_call bindImage_load_bmp_from_buffer (upcast cls)
           arrPtr
           len
           >>= \ (err, res) -> throwIfErr err >> fromGodotVariant res)

instance NodeMethod Image "load_bmp_from_buffer" '[PoolByteArray]
           (IO Int)
         where
        nodeMethod = Godot.Core.Image.load_bmp_from_buffer

{-# NOINLINE bindImage_load_jpg_from_buffer #-}

-- | Loads an image from the binary contents of a JPEG file.
bindImage_load_jpg_from_buffer :: MethodBind
bindImage_load_jpg_from_buffer
  = unsafePerformIO $
      withCString "Image" $
        \ clsNamePtr ->
          withCString "load_jpg_from_buffer" $
            \ methodNamePtr ->
              godot_method_bind_get_method clsNamePtr methodNamePtr

-- | Loads an image from the binary contents of a JPEG file.
load_jpg_from_buffer ::
                       (Image :< cls, Object :< cls) => cls -> PoolByteArray -> IO Int
load_jpg_from_buffer cls arg1
  = withVariantArray [toVariant arg1]
      (\ (arrPtr, len) ->
         godot_method_bind_call bindImage_load_jpg_from_buffer (upcast cls)
           arrPtr
           len
           >>= \ (err, res) -> throwIfErr err >> fromGodotVariant res)

instance NodeMethod Image "load_jpg_from_buffer" '[PoolByteArray]
           (IO Int)
         where
        nodeMethod = Godot.Core.Image.load_jpg_from_buffer

{-# NOINLINE bindImage_load_png_from_buffer #-}

-- | Loads an image from the binary contents of a PNG file.
bindImage_load_png_from_buffer :: MethodBind
bindImage_load_png_from_buffer
  = unsafePerformIO $
      withCString "Image" $
        \ clsNamePtr ->
          withCString "load_png_from_buffer" $
            \ methodNamePtr ->
              godot_method_bind_get_method clsNamePtr methodNamePtr

-- | Loads an image from the binary contents of a PNG file.
load_png_from_buffer ::
                       (Image :< cls, Object :< cls) => cls -> PoolByteArray -> IO Int
load_png_from_buffer cls arg1
  = withVariantArray [toVariant arg1]
      (\ (arrPtr, len) ->
         godot_method_bind_call bindImage_load_png_from_buffer (upcast cls)
           arrPtr
           len
           >>= \ (err, res) -> throwIfErr err >> fromGodotVariant res)

instance NodeMethod Image "load_png_from_buffer" '[PoolByteArray]
           (IO Int)
         where
        nodeMethod = Godot.Core.Image.load_png_from_buffer

{-# NOINLINE bindImage_load_tga_from_buffer #-}

-- | Loads an image from the binary contents of a TGA file.
bindImage_load_tga_from_buffer :: MethodBind
bindImage_load_tga_from_buffer
  = unsafePerformIO $
      withCString "Image" $
        \ clsNamePtr ->
          withCString "load_tga_from_buffer" $
            \ methodNamePtr ->
              godot_method_bind_get_method clsNamePtr methodNamePtr

-- | Loads an image from the binary contents of a TGA file.
load_tga_from_buffer ::
                       (Image :< cls, Object :< cls) => cls -> PoolByteArray -> IO Int
load_tga_from_buffer cls arg1
  = withVariantArray [toVariant arg1]
      (\ (arrPtr, len) ->
         godot_method_bind_call bindImage_load_tga_from_buffer (upcast cls)
           arrPtr
           len
           >>= \ (err, res) -> throwIfErr err >> fromGodotVariant res)

instance NodeMethod Image "load_tga_from_buffer" '[PoolByteArray]
           (IO Int)
         where
        nodeMethod = Godot.Core.Image.load_tga_from_buffer

{-# NOINLINE bindImage_load_webp_from_buffer #-}

-- | Loads an image from the binary contents of a WebP file.
bindImage_load_webp_from_buffer :: MethodBind
bindImage_load_webp_from_buffer
  = unsafePerformIO $
      withCString "Image" $
        \ clsNamePtr ->
          withCString "load_webp_from_buffer" $
            \ methodNamePtr ->
              godot_method_bind_get_method clsNamePtr methodNamePtr

-- | Loads an image from the binary contents of a WebP file.
load_webp_from_buffer ::
                        (Image :< cls, Object :< cls) => cls -> PoolByteArray -> IO Int
load_webp_from_buffer cls arg1
  = withVariantArray [toVariant arg1]
      (\ (arrPtr, len) ->
         godot_method_bind_call bindImage_load_webp_from_buffer (upcast cls)
           arrPtr
           len
           >>= \ (err, res) -> throwIfErr err >> fromGodotVariant res)

instance NodeMethod Image "load_webp_from_buffer" '[PoolByteArray]
           (IO Int)
         where
        nodeMethod = Godot.Core.Image.load_webp_from_buffer

{-# NOINLINE bindImage_lock #-}

-- | Locks the data for reading and writing access. Sends an error to the console if the image is not locked when reading or writing a pixel.
bindImage_lock :: MethodBind
bindImage_lock
  = unsafePerformIO $
      withCString "Image" $
        \ clsNamePtr ->
          withCString "lock" $
            \ methodNamePtr ->
              godot_method_bind_get_method clsNamePtr methodNamePtr

-- | Locks the data for reading and writing access. Sends an error to the console if the image is not locked when reading or writing a pixel.
lock :: (Image :< cls, Object :< cls) => cls -> IO ()
lock cls
  = withVariantArray []
      (\ (arrPtr, len) ->
         godot_method_bind_call bindImage_lock (upcast cls) arrPtr len >>=
           \ (err, res) -> throwIfErr err >> fromGodotVariant res)

instance NodeMethod Image "lock" '[] (IO ()) where
        nodeMethod = Godot.Core.Image.lock

{-# NOINLINE bindImage_normalmap_to_xy #-}

-- | Converts the image's data to represent coordinates on a 3D plane. This is used when the image represents a normalmap. A normalmap can add lots of detail to a 3D surface without increasing the polygon count.
bindImage_normalmap_to_xy :: MethodBind
bindImage_normalmap_to_xy
  = unsafePerformIO $
      withCString "Image" $
        \ clsNamePtr ->
          withCString "normalmap_to_xy" $
            \ methodNamePtr ->
              godot_method_bind_get_method clsNamePtr methodNamePtr

-- | Converts the image's data to represent coordinates on a 3D plane. This is used when the image represents a normalmap. A normalmap can add lots of detail to a 3D surface without increasing the polygon count.
normalmap_to_xy :: (Image :< cls, Object :< cls) => cls -> IO ()
normalmap_to_xy cls
  = withVariantArray []
      (\ (arrPtr, len) ->
         godot_method_bind_call bindImage_normalmap_to_xy (upcast cls)
           arrPtr
           len
           >>= \ (err, res) -> throwIfErr err >> fromGodotVariant res)

instance NodeMethod Image "normalmap_to_xy" '[] (IO ()) where
        nodeMethod = Godot.Core.Image.normalmap_to_xy

{-# NOINLINE bindImage_premultiply_alpha #-}

-- | Multiplies color values with alpha values. Resulting color values for a pixel are @(color * alpha)/256@.
bindImage_premultiply_alpha :: MethodBind
bindImage_premultiply_alpha
  = unsafePerformIO $
      withCString "Image" $
        \ clsNamePtr ->
          withCString "premultiply_alpha" $
            \ methodNamePtr ->
              godot_method_bind_get_method clsNamePtr methodNamePtr

-- | Multiplies color values with alpha values. Resulting color values for a pixel are @(color * alpha)/256@.
premultiply_alpha :: (Image :< cls, Object :< cls) => cls -> IO ()
premultiply_alpha cls
  = withVariantArray []
      (\ (arrPtr, len) ->
         godot_method_bind_call bindImage_premultiply_alpha (upcast cls)
           arrPtr
           len
           >>= \ (err, res) -> throwIfErr err >> fromGodotVariant res)

instance NodeMethod Image "premultiply_alpha" '[] (IO ()) where
        nodeMethod = Godot.Core.Image.premultiply_alpha

{-# NOINLINE bindImage_resize #-}

-- | Resizes the image to the given @width@ and @height@. New pixels are calculated using the @interpolation@ mode defined via @enum Interpolation@ constants.
bindImage_resize :: MethodBind
bindImage_resize
  = unsafePerformIO $
      withCString "Image" $
        \ clsNamePtr ->
          withCString "resize" $
            \ methodNamePtr ->
              godot_method_bind_get_method clsNamePtr methodNamePtr

-- | Resizes the image to the given @width@ and @height@. New pixels are calculated using the @interpolation@ mode defined via @enum Interpolation@ constants.
resize ::
         (Image :< cls, Object :< cls) =>
         cls -> Int -> Int -> Maybe Int -> IO ()
resize cls arg1 arg2 arg3
  = withVariantArray
      [toVariant arg1, toVariant arg2,
       maybe (VariantInt (1)) toVariant arg3]
      (\ (arrPtr, len) ->
         godot_method_bind_call bindImage_resize (upcast cls) arrPtr len >>=
           \ (err, res) -> throwIfErr err >> fromGodotVariant res)

instance NodeMethod Image "resize" '[Int, Int, Maybe Int] (IO ())
         where
        nodeMethod = Godot.Core.Image.resize

{-# NOINLINE bindImage_resize_to_po2 #-}

-- | Resizes the image to the nearest power of 2 for the width and height. If @square@ is @true@ then set width and height to be the same. New pixels are calculated using the @interpolation@ mode defined via @enum Interpolation@ constants.
bindImage_resize_to_po2 :: MethodBind
bindImage_resize_to_po2
  = unsafePerformIO $
      withCString "Image" $
        \ clsNamePtr ->
          withCString "resize_to_po2" $
            \ methodNamePtr ->
              godot_method_bind_get_method clsNamePtr methodNamePtr

-- | Resizes the image to the nearest power of 2 for the width and height. If @square@ is @true@ then set width and height to be the same. New pixels are calculated using the @interpolation@ mode defined via @enum Interpolation@ constants.
resize_to_po2 ::
                (Image :< cls, Object :< cls) =>
                cls -> Maybe Bool -> Maybe Int -> IO ()
resize_to_po2 cls arg1 arg2
  = withVariantArray
      [maybe (VariantBool False) toVariant arg1,
       maybe (VariantInt (1)) toVariant arg2]
      (\ (arrPtr, len) ->
         godot_method_bind_call bindImage_resize_to_po2 (upcast cls) arrPtr
           len
           >>= \ (err, res) -> throwIfErr err >> fromGodotVariant res)

instance NodeMethod Image "resize_to_po2" '[Maybe Bool, Maybe Int]
           (IO ())
         where
        nodeMethod = Godot.Core.Image.resize_to_po2

{-# NOINLINE bindImage_rgbe_to_srgb #-}

-- | Converts a standard RGBE (Red Green Blue Exponent) image to an sRGB image.
bindImage_rgbe_to_srgb :: MethodBind
bindImage_rgbe_to_srgb
  = unsafePerformIO $
      withCString "Image" $
        \ clsNamePtr ->
          withCString "rgbe_to_srgb" $
            \ methodNamePtr ->
              godot_method_bind_get_method clsNamePtr methodNamePtr

-- | Converts a standard RGBE (Red Green Blue Exponent) image to an sRGB image.
rgbe_to_srgb :: (Image :< cls, Object :< cls) => cls -> IO Image
rgbe_to_srgb cls
  = withVariantArray []
      (\ (arrPtr, len) ->
         godot_method_bind_call bindImage_rgbe_to_srgb (upcast cls) arrPtr
           len
           >>= \ (err, res) -> throwIfErr err >> fromGodotVariant res)

instance NodeMethod Image "rgbe_to_srgb" '[] (IO Image) where
        nodeMethod = Godot.Core.Image.rgbe_to_srgb

{-# NOINLINE bindImage_save_exr #-}

-- | Saves the image as an EXR file to @path@. If @grayscale@ is @true@ and the image has only one channel, it will be saved explicitly as monochrome rather than one red channel. This function will return @ERR_UNAVAILABLE@ if Godot was compiled without the TinyEXR module.
--   				__Note:__ The TinyEXR module is disabled in non-editor builds, which means @method save_exr@ will return @ERR_UNAVAILABLE@ when it is called from an exported project.
bindImage_save_exr :: MethodBind
bindImage_save_exr
  = unsafePerformIO $
      withCString "Image" $
        \ clsNamePtr ->
          withCString "save_exr" $
            \ methodNamePtr ->
              godot_method_bind_get_method clsNamePtr methodNamePtr

-- | Saves the image as an EXR file to @path@. If @grayscale@ is @true@ and the image has only one channel, it will be saved explicitly as monochrome rather than one red channel. This function will return @ERR_UNAVAILABLE@ if Godot was compiled without the TinyEXR module.
--   				__Note:__ The TinyEXR module is disabled in non-editor builds, which means @method save_exr@ will return @ERR_UNAVAILABLE@ when it is called from an exported project.
save_exr ::
           (Image :< cls, Object :< cls) =>
           cls -> GodotString -> Maybe Bool -> IO Int
save_exr cls arg1 arg2
  = withVariantArray
      [toVariant arg1, maybe (VariantBool False) toVariant arg2]
      (\ (arrPtr, len) ->
         godot_method_bind_call bindImage_save_exr (upcast cls) arrPtr len
           >>= \ (err, res) -> throwIfErr err >> fromGodotVariant res)

instance NodeMethod Image "save_exr" '[GodotString, Maybe Bool]
           (IO Int)
         where
        nodeMethod = Godot.Core.Image.save_exr

{-# NOINLINE bindImage_save_png #-}

-- | Saves the image as a PNG file to @path@.
bindImage_save_png :: MethodBind
bindImage_save_png
  = unsafePerformIO $
      withCString "Image" $
        \ clsNamePtr ->
          withCString "save_png" $
            \ methodNamePtr ->
              godot_method_bind_get_method clsNamePtr methodNamePtr

-- | Saves the image as a PNG file to @path@.
save_png ::
           (Image :< cls, Object :< cls) => cls -> GodotString -> IO Int
save_png cls arg1
  = withVariantArray [toVariant arg1]
      (\ (arrPtr, len) ->
         godot_method_bind_call bindImage_save_png (upcast cls) arrPtr len
           >>= \ (err, res) -> throwIfErr err >> fromGodotVariant res)

instance NodeMethod Image "save_png" '[GodotString] (IO Int) where
        nodeMethod = Godot.Core.Image.save_png

{-# NOINLINE bindImage_save_png_to_buffer #-}

bindImage_save_png_to_buffer :: MethodBind
bindImage_save_png_to_buffer
  = unsafePerformIO $
      withCString "Image" $
        \ clsNamePtr ->
          withCString "save_png_to_buffer" $
            \ methodNamePtr ->
              godot_method_bind_get_method clsNamePtr methodNamePtr

save_png_to_buffer ::
                     (Image :< cls, Object :< cls) => cls -> IO PoolByteArray
save_png_to_buffer cls
  = withVariantArray []
      (\ (arrPtr, len) ->
         godot_method_bind_call bindImage_save_png_to_buffer (upcast cls)
           arrPtr
           len
           >>= \ (err, res) -> throwIfErr err >> fromGodotVariant res)

instance NodeMethod Image "save_png_to_buffer" '[]
           (IO PoolByteArray)
         where
        nodeMethod = Godot.Core.Image.save_png_to_buffer

{-# NOINLINE bindImage_set_pixel #-}

-- | Sets the @Color@ of the pixel at @(x, y)@ if the image is locked. Example:
--   				
--   @
--   
--   				var img = Image.new()
--   				img.create(img_width, img_height, false, Image.FORMAT_RGBA8)
--   				img.lock()
--   				img.set_pixel(x, y, color) # Works
--   				img.unlock()
--   				img.set_pixel(x, y, color) # Does not have an effect
--   				
--   @
bindImage_set_pixel :: MethodBind
bindImage_set_pixel
  = unsafePerformIO $
      withCString "Image" $
        \ clsNamePtr ->
          withCString "set_pixel" $
            \ methodNamePtr ->
              godot_method_bind_get_method clsNamePtr methodNamePtr

-- | Sets the @Color@ of the pixel at @(x, y)@ if the image is locked. Example:
--   				
--   @
--   
--   				var img = Image.new()
--   				img.create(img_width, img_height, false, Image.FORMAT_RGBA8)
--   				img.lock()
--   				img.set_pixel(x, y, color) # Works
--   				img.unlock()
--   				img.set_pixel(x, y, color) # Does not have an effect
--   				
--   @
set_pixel ::
            (Image :< cls, Object :< cls) =>
            cls -> Int -> Int -> Color -> IO ()
set_pixel cls arg1 arg2 arg3
  = withVariantArray [toVariant arg1, toVariant arg2, toVariant arg3]
      (\ (arrPtr, len) ->
         godot_method_bind_call bindImage_set_pixel (upcast cls) arrPtr len
           >>= \ (err, res) -> throwIfErr err >> fromGodotVariant res)

instance NodeMethod Image "set_pixel" '[Int, Int, Color] (IO ())
         where
        nodeMethod = Godot.Core.Image.set_pixel

{-# NOINLINE bindImage_set_pixelv #-}

-- | Sets the @Color@ of the pixel at @(dst.x, dst.y)@ if the image is locked. Note that the @dst@ values must be integers. Example:
--   				
--   @
--   
--   				var img = Image.new()
--   				img.create(img_width, img_height, false, Image.FORMAT_RGBA8)
--   				img.lock()
--   				img.set_pixelv(Vector2(x, y), color) # Works
--   				img.unlock()
--   				img.set_pixelv(Vector2(x, y), color) # Does not have an effect
--   				
--   @
bindImage_set_pixelv :: MethodBind
bindImage_set_pixelv
  = unsafePerformIO $
      withCString "Image" $
        \ clsNamePtr ->
          withCString "set_pixelv" $
            \ methodNamePtr ->
              godot_method_bind_get_method clsNamePtr methodNamePtr

-- | Sets the @Color@ of the pixel at @(dst.x, dst.y)@ if the image is locked. Note that the @dst@ values must be integers. Example:
--   				
--   @
--   
--   				var img = Image.new()
--   				img.create(img_width, img_height, false, Image.FORMAT_RGBA8)
--   				img.lock()
--   				img.set_pixelv(Vector2(x, y), color) # Works
--   				img.unlock()
--   				img.set_pixelv(Vector2(x, y), color) # Does not have an effect
--   				
--   @
set_pixelv ::
             (Image :< cls, Object :< cls) => cls -> Vector2 -> Color -> IO ()
set_pixelv cls arg1 arg2
  = withVariantArray [toVariant arg1, toVariant arg2]
      (\ (arrPtr, len) ->
         godot_method_bind_call bindImage_set_pixelv (upcast cls) arrPtr len
           >>= \ (err, res) -> throwIfErr err >> fromGodotVariant res)

instance NodeMethod Image "set_pixelv" '[Vector2, Color] (IO ())
         where
        nodeMethod = Godot.Core.Image.set_pixelv

{-# NOINLINE bindImage_shrink_x2 #-}

-- | Shrinks the image by a factor of 2.
bindImage_shrink_x2 :: MethodBind
bindImage_shrink_x2
  = unsafePerformIO $
      withCString "Image" $
        \ clsNamePtr ->
          withCString "shrink_x2" $
            \ methodNamePtr ->
              godot_method_bind_get_method clsNamePtr methodNamePtr

-- | Shrinks the image by a factor of 2.
shrink_x2 :: (Image :< cls, Object :< cls) => cls -> IO ()
shrink_x2 cls
  = withVariantArray []
      (\ (arrPtr, len) ->
         godot_method_bind_call bindImage_shrink_x2 (upcast cls) arrPtr len
           >>= \ (err, res) -> throwIfErr err >> fromGodotVariant res)

instance NodeMethod Image "shrink_x2" '[] (IO ()) where
        nodeMethod = Godot.Core.Image.shrink_x2

{-# NOINLINE bindImage_srgb_to_linear #-}

-- | Converts the raw data from the sRGB colorspace to a linear scale.
bindImage_srgb_to_linear :: MethodBind
bindImage_srgb_to_linear
  = unsafePerformIO $
      withCString "Image" $
        \ clsNamePtr ->
          withCString "srgb_to_linear" $
            \ methodNamePtr ->
              godot_method_bind_get_method clsNamePtr methodNamePtr

-- | Converts the raw data from the sRGB colorspace to a linear scale.
srgb_to_linear :: (Image :< cls, Object :< cls) => cls -> IO ()
srgb_to_linear cls
  = withVariantArray []
      (\ (arrPtr, len) ->
         godot_method_bind_call bindImage_srgb_to_linear (upcast cls) arrPtr
           len
           >>= \ (err, res) -> throwIfErr err >> fromGodotVariant res)

instance NodeMethod Image "srgb_to_linear" '[] (IO ()) where
        nodeMethod = Godot.Core.Image.srgb_to_linear

{-# NOINLINE bindImage_unlock #-}

-- | Unlocks the data and prevents changes.
bindImage_unlock :: MethodBind
bindImage_unlock
  = unsafePerformIO $
      withCString "Image" $
        \ clsNamePtr ->
          withCString "unlock" $
            \ methodNamePtr ->
              godot_method_bind_get_method clsNamePtr methodNamePtr

-- | Unlocks the data and prevents changes.
unlock :: (Image :< cls, Object :< cls) => cls -> IO ()
unlock cls
  = withVariantArray []
      (\ (arrPtr, len) ->
         godot_method_bind_call bindImage_unlock (upcast cls) arrPtr len >>=
           \ (err, res) -> throwIfErr err >> fromGodotVariant res)

instance NodeMethod Image "unlock" '[] (IO ()) where
        nodeMethod = Godot.Core.Image.unlock