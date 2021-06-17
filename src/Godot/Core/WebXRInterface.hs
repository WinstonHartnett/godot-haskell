{-# LANGUAGE DerivingStrategies, GeneralizedNewtypeDeriving,
  TypeFamilies, TypeOperators, FlexibleContexts, DataKinds,
  MultiParamTypeClasses #-}
module Godot.Core.WebXRInterface
       (Godot.Core.WebXRInterface.sig_reference_space_reset,
        Godot.Core.WebXRInterface.sig_select,
        Godot.Core.WebXRInterface.sig_selectend,
        Godot.Core.WebXRInterface.sig_selectstart,
        Godot.Core.WebXRInterface.sig_session_ended,
        Godot.Core.WebXRInterface.sig_session_failed,
        Godot.Core.WebXRInterface.sig_session_started,
        Godot.Core.WebXRInterface.sig_session_supported,
        Godot.Core.WebXRInterface.sig_squeeze,
        Godot.Core.WebXRInterface.sig_squeezeend,
        Godot.Core.WebXRInterface.sig_squeezestart,
        Godot.Core.WebXRInterface.sig_visibility_state_changed,
        Godot.Core.WebXRInterface.get_bounds_geometry,
        Godot.Core.WebXRInterface.get_controller,
        Godot.Core.WebXRInterface.get_optional_features,
        Godot.Core.WebXRInterface.get_reference_space_type,
        Godot.Core.WebXRInterface.get_requested_reference_space_types,
        Godot.Core.WebXRInterface.get_required_features,
        Godot.Core.WebXRInterface.get_session_mode,
        Godot.Core.WebXRInterface.get_visibility_state,
        Godot.Core.WebXRInterface.is_session_supported,
        Godot.Core.WebXRInterface.set_optional_features,
        Godot.Core.WebXRInterface.set_requested_reference_space_types,
        Godot.Core.WebXRInterface.set_required_features,
        Godot.Core.WebXRInterface.set_session_mode)
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
import Godot.Core.ARVRInterface()

sig_reference_space_reset ::
                          Godot.Internal.Dispatch.Signal WebXRInterface
sig_reference_space_reset
  = Godot.Internal.Dispatch.Signal "reference_space_reset"

instance NodeSignal WebXRInterface "reference_space_reset" '[]

sig_select :: Godot.Internal.Dispatch.Signal WebXRInterface
sig_select = Godot.Internal.Dispatch.Signal "select"

instance NodeSignal WebXRInterface "select" '[Int]

sig_selectend :: Godot.Internal.Dispatch.Signal WebXRInterface
sig_selectend = Godot.Internal.Dispatch.Signal "selectend"

instance NodeSignal WebXRInterface "selectend" '[Int]

sig_selectstart :: Godot.Internal.Dispatch.Signal WebXRInterface
sig_selectstart = Godot.Internal.Dispatch.Signal "selectstart"

instance NodeSignal WebXRInterface "selectstart" '[Int]

sig_session_ended :: Godot.Internal.Dispatch.Signal WebXRInterface
sig_session_ended = Godot.Internal.Dispatch.Signal "session_ended"

instance NodeSignal WebXRInterface "session_ended" '[]

sig_session_failed :: Godot.Internal.Dispatch.Signal WebXRInterface
sig_session_failed
  = Godot.Internal.Dispatch.Signal "session_failed"

instance NodeSignal WebXRInterface "session_failed" '[GodotString]

sig_session_started ::
                    Godot.Internal.Dispatch.Signal WebXRInterface
sig_session_started
  = Godot.Internal.Dispatch.Signal "session_started"

instance NodeSignal WebXRInterface "session_started" '[]

sig_session_supported ::
                      Godot.Internal.Dispatch.Signal WebXRInterface
sig_session_supported
  = Godot.Internal.Dispatch.Signal "session_supported"

instance NodeSignal WebXRInterface "session_supported"
           '[GodotString, Bool]

sig_squeeze :: Godot.Internal.Dispatch.Signal WebXRInterface
sig_squeeze = Godot.Internal.Dispatch.Signal "squeeze"

instance NodeSignal WebXRInterface "squeeze" '[Int]

sig_squeezeend :: Godot.Internal.Dispatch.Signal WebXRInterface
sig_squeezeend = Godot.Internal.Dispatch.Signal "squeezeend"

instance NodeSignal WebXRInterface "squeezeend" '[Int]

sig_squeezestart :: Godot.Internal.Dispatch.Signal WebXRInterface
sig_squeezestart = Godot.Internal.Dispatch.Signal "squeezestart"

instance NodeSignal WebXRInterface "squeezestart" '[Int]

sig_visibility_state_changed ::
                             Godot.Internal.Dispatch.Signal WebXRInterface
sig_visibility_state_changed
  = Godot.Internal.Dispatch.Signal "visibility_state_changed"

instance NodeSignal WebXRInterface "visibility_state_changed" '[]

instance NodeProperty WebXRInterface "bounds_geometry"
           PoolVector3Array
           'True
         where
        nodeProperty = (get_bounds_geometry, (), Nothing)

instance NodeProperty WebXRInterface "optional_features"
           GodotString
           'False
         where
        nodeProperty
          = (get_optional_features, wrapDroppingSetter set_optional_features,
             Nothing)

instance NodeProperty WebXRInterface "reference_space_type"
           GodotString
           'True
         where
        nodeProperty = (get_reference_space_type, (), Nothing)

instance NodeProperty WebXRInterface
           "requested_reference_space_types"
           GodotString
           'False
         where
        nodeProperty
          = (get_requested_reference_space_types,
             wrapDroppingSetter set_requested_reference_space_types, Nothing)

instance NodeProperty WebXRInterface "required_features"
           GodotString
           'False
         where
        nodeProperty
          = (get_required_features, wrapDroppingSetter set_required_features,
             Nothing)

instance NodeProperty WebXRInterface "session_mode" GodotString
           'False
         where
        nodeProperty
          = (get_session_mode, wrapDroppingSetter set_session_mode, Nothing)

instance NodeProperty WebXRInterface "visibility_state" GodotString
           'True
         where
        nodeProperty = (get_visibility_state, (), Nothing)

{-# NOINLINE bindWebXRInterface_get_bounds_geometry #-}

bindWebXRInterface_get_bounds_geometry :: MethodBind
bindWebXRInterface_get_bounds_geometry
  = unsafePerformIO $
      withCString "WebXRInterface" $
        \ clsNamePtr ->
          withCString "get_bounds_geometry" $
            \ methodNamePtr ->
              godot_method_bind_get_method clsNamePtr methodNamePtr

get_bounds_geometry ::
                      (WebXRInterface :< cls, Object :< cls) =>
                      cls -> IO PoolVector3Array
get_bounds_geometry cls
  = withVariantArray []
      (\ (arrPtr, len) ->
         godot_method_bind_call bindWebXRInterface_get_bounds_geometry
           (upcast cls)
           arrPtr
           len
           >>= \ (err, res) -> throwIfErr err >> fromGodotVariant res)

instance NodeMethod WebXRInterface "get_bounds_geometry" '[]
           (IO PoolVector3Array)
         where
        nodeMethod = Godot.Core.WebXRInterface.get_bounds_geometry

{-# NOINLINE bindWebXRInterface_get_controller #-}

bindWebXRInterface_get_controller :: MethodBind
bindWebXRInterface_get_controller
  = unsafePerformIO $
      withCString "WebXRInterface" $
        \ clsNamePtr ->
          withCString "get_controller" $
            \ methodNamePtr ->
              godot_method_bind_get_method clsNamePtr methodNamePtr

get_controller ::
                 (WebXRInterface :< cls, Object :< cls) =>
                 cls -> Int -> IO ARVRPositionalTracker
get_controller cls arg1
  = withVariantArray [toVariant arg1]
      (\ (arrPtr, len) ->
         godot_method_bind_call bindWebXRInterface_get_controller
           (upcast cls)
           arrPtr
           len
           >>= \ (err, res) -> throwIfErr err >> fromGodotVariant res)

instance NodeMethod WebXRInterface "get_controller" '[Int]
           (IO ARVRPositionalTracker)
         where
        nodeMethod = Godot.Core.WebXRInterface.get_controller

{-# NOINLINE bindWebXRInterface_get_optional_features #-}

bindWebXRInterface_get_optional_features :: MethodBind
bindWebXRInterface_get_optional_features
  = unsafePerformIO $
      withCString "WebXRInterface" $
        \ clsNamePtr ->
          withCString "get_optional_features" $
            \ methodNamePtr ->
              godot_method_bind_get_method clsNamePtr methodNamePtr

get_optional_features ::
                        (WebXRInterface :< cls, Object :< cls) => cls -> IO GodotString
get_optional_features cls
  = withVariantArray []
      (\ (arrPtr, len) ->
         godot_method_bind_call bindWebXRInterface_get_optional_features
           (upcast cls)
           arrPtr
           len
           >>= \ (err, res) -> throwIfErr err >> fromGodotVariant res)

instance NodeMethod WebXRInterface "get_optional_features" '[]
           (IO GodotString)
         where
        nodeMethod = Godot.Core.WebXRInterface.get_optional_features

{-# NOINLINE bindWebXRInterface_get_reference_space_type #-}

bindWebXRInterface_get_reference_space_type :: MethodBind
bindWebXRInterface_get_reference_space_type
  = unsafePerformIO $
      withCString "WebXRInterface" $
        \ clsNamePtr ->
          withCString "get_reference_space_type" $
            \ methodNamePtr ->
              godot_method_bind_get_method clsNamePtr methodNamePtr

get_reference_space_type ::
                           (WebXRInterface :< cls, Object :< cls) => cls -> IO GodotString
get_reference_space_type cls
  = withVariantArray []
      (\ (arrPtr, len) ->
         godot_method_bind_call bindWebXRInterface_get_reference_space_type
           (upcast cls)
           arrPtr
           len
           >>= \ (err, res) -> throwIfErr err >> fromGodotVariant res)

instance NodeMethod WebXRInterface "get_reference_space_type" '[]
           (IO GodotString)
         where
        nodeMethod = Godot.Core.WebXRInterface.get_reference_space_type

{-# NOINLINE bindWebXRInterface_get_requested_reference_space_types
             #-}

bindWebXRInterface_get_requested_reference_space_types ::
                                                       MethodBind
bindWebXRInterface_get_requested_reference_space_types
  = unsafePerformIO $
      withCString "WebXRInterface" $
        \ clsNamePtr ->
          withCString "get_requested_reference_space_types" $
            \ methodNamePtr ->
              godot_method_bind_get_method clsNamePtr methodNamePtr

get_requested_reference_space_types ::
                                      (WebXRInterface :< cls, Object :< cls) =>
                                      cls -> IO GodotString
get_requested_reference_space_types cls
  = withVariantArray []
      (\ (arrPtr, len) ->
         godot_method_bind_call
           bindWebXRInterface_get_requested_reference_space_types
           (upcast cls)
           arrPtr
           len
           >>= \ (err, res) -> throwIfErr err >> fromGodotVariant res)

instance NodeMethod WebXRInterface
           "get_requested_reference_space_types"
           '[]
           (IO GodotString)
         where
        nodeMethod
          = Godot.Core.WebXRInterface.get_requested_reference_space_types

{-# NOINLINE bindWebXRInterface_get_required_features #-}

bindWebXRInterface_get_required_features :: MethodBind
bindWebXRInterface_get_required_features
  = unsafePerformIO $
      withCString "WebXRInterface" $
        \ clsNamePtr ->
          withCString "get_required_features" $
            \ methodNamePtr ->
              godot_method_bind_get_method clsNamePtr methodNamePtr

get_required_features ::
                        (WebXRInterface :< cls, Object :< cls) => cls -> IO GodotString
get_required_features cls
  = withVariantArray []
      (\ (arrPtr, len) ->
         godot_method_bind_call bindWebXRInterface_get_required_features
           (upcast cls)
           arrPtr
           len
           >>= \ (err, res) -> throwIfErr err >> fromGodotVariant res)

instance NodeMethod WebXRInterface "get_required_features" '[]
           (IO GodotString)
         where
        nodeMethod = Godot.Core.WebXRInterface.get_required_features

{-# NOINLINE bindWebXRInterface_get_session_mode #-}

bindWebXRInterface_get_session_mode :: MethodBind
bindWebXRInterface_get_session_mode
  = unsafePerformIO $
      withCString "WebXRInterface" $
        \ clsNamePtr ->
          withCString "get_session_mode" $
            \ methodNamePtr ->
              godot_method_bind_get_method clsNamePtr methodNamePtr

get_session_mode ::
                   (WebXRInterface :< cls, Object :< cls) => cls -> IO GodotString
get_session_mode cls
  = withVariantArray []
      (\ (arrPtr, len) ->
         godot_method_bind_call bindWebXRInterface_get_session_mode
           (upcast cls)
           arrPtr
           len
           >>= \ (err, res) -> throwIfErr err >> fromGodotVariant res)

instance NodeMethod WebXRInterface "get_session_mode" '[]
           (IO GodotString)
         where
        nodeMethod = Godot.Core.WebXRInterface.get_session_mode

{-# NOINLINE bindWebXRInterface_get_visibility_state #-}

bindWebXRInterface_get_visibility_state :: MethodBind
bindWebXRInterface_get_visibility_state
  = unsafePerformIO $
      withCString "WebXRInterface" $
        \ clsNamePtr ->
          withCString "get_visibility_state" $
            \ methodNamePtr ->
              godot_method_bind_get_method clsNamePtr methodNamePtr

get_visibility_state ::
                       (WebXRInterface :< cls, Object :< cls) => cls -> IO GodotString
get_visibility_state cls
  = withVariantArray []
      (\ (arrPtr, len) ->
         godot_method_bind_call bindWebXRInterface_get_visibility_state
           (upcast cls)
           arrPtr
           len
           >>= \ (err, res) -> throwIfErr err >> fromGodotVariant res)

instance NodeMethod WebXRInterface "get_visibility_state" '[]
           (IO GodotString)
         where
        nodeMethod = Godot.Core.WebXRInterface.get_visibility_state

{-# NOINLINE bindWebXRInterface_is_session_supported #-}

bindWebXRInterface_is_session_supported :: MethodBind
bindWebXRInterface_is_session_supported
  = unsafePerformIO $
      withCString "WebXRInterface" $
        \ clsNamePtr ->
          withCString "is_session_supported" $
            \ methodNamePtr ->
              godot_method_bind_get_method clsNamePtr methodNamePtr

is_session_supported ::
                       (WebXRInterface :< cls, Object :< cls) =>
                       cls -> GodotString -> IO ()
is_session_supported cls arg1
  = withVariantArray [toVariant arg1]
      (\ (arrPtr, len) ->
         godot_method_bind_call bindWebXRInterface_is_session_supported
           (upcast cls)
           arrPtr
           len
           >>= \ (err, res) -> throwIfErr err >> fromGodotVariant res)

instance NodeMethod WebXRInterface "is_session_supported"
           '[GodotString]
           (IO ())
         where
        nodeMethod = Godot.Core.WebXRInterface.is_session_supported

{-# NOINLINE bindWebXRInterface_set_optional_features #-}

bindWebXRInterface_set_optional_features :: MethodBind
bindWebXRInterface_set_optional_features
  = unsafePerformIO $
      withCString "WebXRInterface" $
        \ clsNamePtr ->
          withCString "set_optional_features" $
            \ methodNamePtr ->
              godot_method_bind_get_method clsNamePtr methodNamePtr

set_optional_features ::
                        (WebXRInterface :< cls, Object :< cls) =>
                        cls -> GodotString -> IO ()
set_optional_features cls arg1
  = withVariantArray [toVariant arg1]
      (\ (arrPtr, len) ->
         godot_method_bind_call bindWebXRInterface_set_optional_features
           (upcast cls)
           arrPtr
           len
           >>= \ (err, res) -> throwIfErr err >> fromGodotVariant res)

instance NodeMethod WebXRInterface "set_optional_features"
           '[GodotString]
           (IO ())
         where
        nodeMethod = Godot.Core.WebXRInterface.set_optional_features

{-# NOINLINE bindWebXRInterface_set_requested_reference_space_types
             #-}

bindWebXRInterface_set_requested_reference_space_types ::
                                                       MethodBind
bindWebXRInterface_set_requested_reference_space_types
  = unsafePerformIO $
      withCString "WebXRInterface" $
        \ clsNamePtr ->
          withCString "set_requested_reference_space_types" $
            \ methodNamePtr ->
              godot_method_bind_get_method clsNamePtr methodNamePtr

set_requested_reference_space_types ::
                                      (WebXRInterface :< cls, Object :< cls) =>
                                      cls -> GodotString -> IO ()
set_requested_reference_space_types cls arg1
  = withVariantArray [toVariant arg1]
      (\ (arrPtr, len) ->
         godot_method_bind_call
           bindWebXRInterface_set_requested_reference_space_types
           (upcast cls)
           arrPtr
           len
           >>= \ (err, res) -> throwIfErr err >> fromGodotVariant res)

instance NodeMethod WebXRInterface
           "set_requested_reference_space_types"
           '[GodotString]
           (IO ())
         where
        nodeMethod
          = Godot.Core.WebXRInterface.set_requested_reference_space_types

{-# NOINLINE bindWebXRInterface_set_required_features #-}

bindWebXRInterface_set_required_features :: MethodBind
bindWebXRInterface_set_required_features
  = unsafePerformIO $
      withCString "WebXRInterface" $
        \ clsNamePtr ->
          withCString "set_required_features" $
            \ methodNamePtr ->
              godot_method_bind_get_method clsNamePtr methodNamePtr

set_required_features ::
                        (WebXRInterface :< cls, Object :< cls) =>
                        cls -> GodotString -> IO ()
set_required_features cls arg1
  = withVariantArray [toVariant arg1]
      (\ (arrPtr, len) ->
         godot_method_bind_call bindWebXRInterface_set_required_features
           (upcast cls)
           arrPtr
           len
           >>= \ (err, res) -> throwIfErr err >> fromGodotVariant res)

instance NodeMethod WebXRInterface "set_required_features"
           '[GodotString]
           (IO ())
         where
        nodeMethod = Godot.Core.WebXRInterface.set_required_features

{-# NOINLINE bindWebXRInterface_set_session_mode #-}

bindWebXRInterface_set_session_mode :: MethodBind
bindWebXRInterface_set_session_mode
  = unsafePerformIO $
      withCString "WebXRInterface" $
        \ clsNamePtr ->
          withCString "set_session_mode" $
            \ methodNamePtr ->
              godot_method_bind_get_method clsNamePtr methodNamePtr

set_session_mode ::
                   (WebXRInterface :< cls, Object :< cls) =>
                   cls -> GodotString -> IO ()
set_session_mode cls arg1
  = withVariantArray [toVariant arg1]
      (\ (arrPtr, len) ->
         godot_method_bind_call bindWebXRInterface_set_session_mode
           (upcast cls)
           arrPtr
           len
           >>= \ (err, res) -> throwIfErr err >> fromGodotVariant res)

instance NodeMethod WebXRInterface "set_session_mode"
           '[GodotString]
           (IO ())
         where
        nodeMethod = Godot.Core.WebXRInterface.set_session_mode