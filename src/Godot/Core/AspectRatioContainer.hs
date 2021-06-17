{-# LANGUAGE DerivingStrategies, GeneralizedNewtypeDeriving,
  TypeFamilies, TypeOperators, FlexibleContexts, DataKinds,
  MultiParamTypeClasses #-}
module Godot.Core.AspectRatioContainer
       (Godot.Core.AspectRatioContainer._STRETCH_HEIGHT_CONTROLS_WIDTH,
        Godot.Core.AspectRatioContainer._ALIGN_END,
        Godot.Core.AspectRatioContainer._STRETCH_FIT,
        Godot.Core.AspectRatioContainer._STRETCH_WIDTH_CONTROLS_HEIGHT,
        Godot.Core.AspectRatioContainer._ALIGN_BEGIN,
        Godot.Core.AspectRatioContainer._STRETCH_COVER,
        Godot.Core.AspectRatioContainer._ALIGN_CENTER,
        Godot.Core.AspectRatioContainer.get_alignment_horizontal,
        Godot.Core.AspectRatioContainer.get_alignment_vertical,
        Godot.Core.AspectRatioContainer.get_ratio,
        Godot.Core.AspectRatioContainer.get_stretch_mode,
        Godot.Core.AspectRatioContainer.set_alignment_horizontal,
        Godot.Core.AspectRatioContainer.set_alignment_vertical,
        Godot.Core.AspectRatioContainer.set_ratio,
        Godot.Core.AspectRatioContainer.set_stretch_mode)
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
import Godot.Core.Container()

_STRETCH_HEIGHT_CONTROLS_WIDTH :: Int
_STRETCH_HEIGHT_CONTROLS_WIDTH = 1

_ALIGN_END :: Int
_ALIGN_END = 2

_STRETCH_FIT :: Int
_STRETCH_FIT = 2

_STRETCH_WIDTH_CONTROLS_HEIGHT :: Int
_STRETCH_WIDTH_CONTROLS_HEIGHT = 0

_ALIGN_BEGIN :: Int
_ALIGN_BEGIN = 0

_STRETCH_COVER :: Int
_STRETCH_COVER = 3

_ALIGN_CENTER :: Int
_ALIGN_CENTER = 1

instance NodeProperty AspectRatioContainer "alignment_horizontal"
           Int
           'False
         where
        nodeProperty
          = (get_alignment_horizontal,
             wrapDroppingSetter set_alignment_horizontal, Nothing)

instance NodeProperty AspectRatioContainer "alignment_vertical" Int
           'False
         where
        nodeProperty
          = (get_alignment_vertical,
             wrapDroppingSetter set_alignment_vertical, Nothing)

instance NodeProperty AspectRatioContainer "ratio" Float 'False
         where
        nodeProperty = (get_ratio, wrapDroppingSetter set_ratio, Nothing)

instance NodeProperty AspectRatioContainer "stretch_mode" Int
           'False
         where
        nodeProperty
          = (get_stretch_mode, wrapDroppingSetter set_stretch_mode, Nothing)

{-# NOINLINE bindAspectRatioContainer_get_alignment_horizontal #-}

-- | Specifies the horizontal relative position of child controls.
bindAspectRatioContainer_get_alignment_horizontal :: MethodBind
bindAspectRatioContainer_get_alignment_horizontal
  = unsafePerformIO $
      withCString "AspectRatioContainer" $
        \ clsNamePtr ->
          withCString "get_alignment_horizontal" $
            \ methodNamePtr ->
              godot_method_bind_get_method clsNamePtr methodNamePtr

-- | Specifies the horizontal relative position of child controls.
get_alignment_horizontal ::
                           (AspectRatioContainer :< cls, Object :< cls) => cls -> IO Int
get_alignment_horizontal cls
  = withVariantArray []
      (\ (arrPtr, len) ->
         godot_method_bind_call
           bindAspectRatioContainer_get_alignment_horizontal
           (upcast cls)
           arrPtr
           len
           >>= \ (err, res) -> throwIfErr err >> fromGodotVariant res)

instance NodeMethod AspectRatioContainer "get_alignment_horizontal"
           '[]
           (IO Int)
         where
        nodeMethod
          = Godot.Core.AspectRatioContainer.get_alignment_horizontal

{-# NOINLINE bindAspectRatioContainer_get_alignment_vertical #-}

-- | Specifies the vertical relative position of child controls.
bindAspectRatioContainer_get_alignment_vertical :: MethodBind
bindAspectRatioContainer_get_alignment_vertical
  = unsafePerformIO $
      withCString "AspectRatioContainer" $
        \ clsNamePtr ->
          withCString "get_alignment_vertical" $
            \ methodNamePtr ->
              godot_method_bind_get_method clsNamePtr methodNamePtr

-- | Specifies the vertical relative position of child controls.
get_alignment_vertical ::
                         (AspectRatioContainer :< cls, Object :< cls) => cls -> IO Int
get_alignment_vertical cls
  = withVariantArray []
      (\ (arrPtr, len) ->
         godot_method_bind_call
           bindAspectRatioContainer_get_alignment_vertical
           (upcast cls)
           arrPtr
           len
           >>= \ (err, res) -> throwIfErr err >> fromGodotVariant res)

instance NodeMethod AspectRatioContainer "get_alignment_vertical"
           '[]
           (IO Int)
         where
        nodeMethod = Godot.Core.AspectRatioContainer.get_alignment_vertical

{-# NOINLINE bindAspectRatioContainer_get_ratio #-}

-- | The aspect ratio to enforce on child controls. This is the width divided by the height. The ratio depends on the @stretch_mode@.
bindAspectRatioContainer_get_ratio :: MethodBind
bindAspectRatioContainer_get_ratio
  = unsafePerformIO $
      withCString "AspectRatioContainer" $
        \ clsNamePtr ->
          withCString "get_ratio" $
            \ methodNamePtr ->
              godot_method_bind_get_method clsNamePtr methodNamePtr

-- | The aspect ratio to enforce on child controls. This is the width divided by the height. The ratio depends on the @stretch_mode@.
get_ratio ::
            (AspectRatioContainer :< cls, Object :< cls) => cls -> IO Float
get_ratio cls
  = withVariantArray []
      (\ (arrPtr, len) ->
         godot_method_bind_call bindAspectRatioContainer_get_ratio
           (upcast cls)
           arrPtr
           len
           >>= \ (err, res) -> throwIfErr err >> fromGodotVariant res)

instance NodeMethod AspectRatioContainer "get_ratio" '[] (IO Float)
         where
        nodeMethod = Godot.Core.AspectRatioContainer.get_ratio

{-# NOINLINE bindAspectRatioContainer_get_stretch_mode #-}

-- | The stretch mode used to align child controls.
bindAspectRatioContainer_get_stretch_mode :: MethodBind
bindAspectRatioContainer_get_stretch_mode
  = unsafePerformIO $
      withCString "AspectRatioContainer" $
        \ clsNamePtr ->
          withCString "get_stretch_mode" $
            \ methodNamePtr ->
              godot_method_bind_get_method clsNamePtr methodNamePtr

-- | The stretch mode used to align child controls.
get_stretch_mode ::
                   (AspectRatioContainer :< cls, Object :< cls) => cls -> IO Int
get_stretch_mode cls
  = withVariantArray []
      (\ (arrPtr, len) ->
         godot_method_bind_call bindAspectRatioContainer_get_stretch_mode
           (upcast cls)
           arrPtr
           len
           >>= \ (err, res) -> throwIfErr err >> fromGodotVariant res)

instance NodeMethod AspectRatioContainer "get_stretch_mode" '[]
           (IO Int)
         where
        nodeMethod = Godot.Core.AspectRatioContainer.get_stretch_mode

{-# NOINLINE bindAspectRatioContainer_set_alignment_horizontal #-}

-- | Specifies the horizontal relative position of child controls.
bindAspectRatioContainer_set_alignment_horizontal :: MethodBind
bindAspectRatioContainer_set_alignment_horizontal
  = unsafePerformIO $
      withCString "AspectRatioContainer" $
        \ clsNamePtr ->
          withCString "set_alignment_horizontal" $
            \ methodNamePtr ->
              godot_method_bind_get_method clsNamePtr methodNamePtr

-- | Specifies the horizontal relative position of child controls.
set_alignment_horizontal ::
                           (AspectRatioContainer :< cls, Object :< cls) => cls -> Int -> IO ()
set_alignment_horizontal cls arg1
  = withVariantArray [toVariant arg1]
      (\ (arrPtr, len) ->
         godot_method_bind_call
           bindAspectRatioContainer_set_alignment_horizontal
           (upcast cls)
           arrPtr
           len
           >>= \ (err, res) -> throwIfErr err >> fromGodotVariant res)

instance NodeMethod AspectRatioContainer "set_alignment_horizontal"
           '[Int]
           (IO ())
         where
        nodeMethod
          = Godot.Core.AspectRatioContainer.set_alignment_horizontal

{-# NOINLINE bindAspectRatioContainer_set_alignment_vertical #-}

-- | Specifies the vertical relative position of child controls.
bindAspectRatioContainer_set_alignment_vertical :: MethodBind
bindAspectRatioContainer_set_alignment_vertical
  = unsafePerformIO $
      withCString "AspectRatioContainer" $
        \ clsNamePtr ->
          withCString "set_alignment_vertical" $
            \ methodNamePtr ->
              godot_method_bind_get_method clsNamePtr methodNamePtr

-- | Specifies the vertical relative position of child controls.
set_alignment_vertical ::
                         (AspectRatioContainer :< cls, Object :< cls) => cls -> Int -> IO ()
set_alignment_vertical cls arg1
  = withVariantArray [toVariant arg1]
      (\ (arrPtr, len) ->
         godot_method_bind_call
           bindAspectRatioContainer_set_alignment_vertical
           (upcast cls)
           arrPtr
           len
           >>= \ (err, res) -> throwIfErr err >> fromGodotVariant res)

instance NodeMethod AspectRatioContainer "set_alignment_vertical"
           '[Int]
           (IO ())
         where
        nodeMethod = Godot.Core.AspectRatioContainer.set_alignment_vertical

{-# NOINLINE bindAspectRatioContainer_set_ratio #-}

-- | The aspect ratio to enforce on child controls. This is the width divided by the height. The ratio depends on the @stretch_mode@.
bindAspectRatioContainer_set_ratio :: MethodBind
bindAspectRatioContainer_set_ratio
  = unsafePerformIO $
      withCString "AspectRatioContainer" $
        \ clsNamePtr ->
          withCString "set_ratio" $
            \ methodNamePtr ->
              godot_method_bind_get_method clsNamePtr methodNamePtr

-- | The aspect ratio to enforce on child controls. This is the width divided by the height. The ratio depends on the @stretch_mode@.
set_ratio ::
            (AspectRatioContainer :< cls, Object :< cls) =>
            cls -> Float -> IO ()
set_ratio cls arg1
  = withVariantArray [toVariant arg1]
      (\ (arrPtr, len) ->
         godot_method_bind_call bindAspectRatioContainer_set_ratio
           (upcast cls)
           arrPtr
           len
           >>= \ (err, res) -> throwIfErr err >> fromGodotVariant res)

instance NodeMethod AspectRatioContainer "set_ratio" '[Float]
           (IO ())
         where
        nodeMethod = Godot.Core.AspectRatioContainer.set_ratio

{-# NOINLINE bindAspectRatioContainer_set_stretch_mode #-}

-- | The stretch mode used to align child controls.
bindAspectRatioContainer_set_stretch_mode :: MethodBind
bindAspectRatioContainer_set_stretch_mode
  = unsafePerformIO $
      withCString "AspectRatioContainer" $
        \ clsNamePtr ->
          withCString "set_stretch_mode" $
            \ methodNamePtr ->
              godot_method_bind_get_method clsNamePtr methodNamePtr

-- | The stretch mode used to align child controls.
set_stretch_mode ::
                   (AspectRatioContainer :< cls, Object :< cls) => cls -> Int -> IO ()
set_stretch_mode cls arg1
  = withVariantArray [toVariant arg1]
      (\ (arrPtr, len) ->
         godot_method_bind_call bindAspectRatioContainer_set_stretch_mode
           (upcast cls)
           arrPtr
           len
           >>= \ (err, res) -> throwIfErr err >> fromGodotVariant res)

instance NodeMethod AspectRatioContainer "set_stretch_mode" '[Int]
           (IO ())
         where
        nodeMethod = Godot.Core.AspectRatioContainer.set_stretch_mode