{-# LANGUAGE DerivingStrategies, GeneralizedNewtypeDeriving,
  TypeFamilies, TypeOperators, FlexibleContexts, DataKinds,
  MultiParamTypeClasses #-}
module Godot.Tools.EditorExportPlugin
       (Godot.Tools.EditorExportPlugin._export_begin,
        Godot.Tools.EditorExportPlugin._export_end,
        Godot.Tools.EditorExportPlugin._export_file,
        Godot.Tools.EditorExportPlugin.add_file,
        Godot.Tools.EditorExportPlugin.add_ios_bundle_file,
        Godot.Tools.EditorExportPlugin.add_ios_cpp_code,
        Godot.Tools.EditorExportPlugin.add_ios_embedded_framework,
        Godot.Tools.EditorExportPlugin.add_ios_framework,
        Godot.Tools.EditorExportPlugin.add_ios_linker_flags,
        Godot.Tools.EditorExportPlugin.add_ios_plist_content,
        Godot.Tools.EditorExportPlugin.add_ios_project_static_lib,
        Godot.Tools.EditorExportPlugin.add_shared_object,
        Godot.Tools.EditorExportPlugin.skip)
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
import Godot.Core.Reference()

{-# NOINLINE bindEditorExportPlugin__export_begin #-}

-- | Virtual method to be overridden by the user. It is called when the export starts and provides all information about the export. @features@ is the list of features for the export, @is_debug@ is @true@ for debug builds, @path@ is the target path for the exported project. @flags@ is only used when running a runnable profile, e.g. when using native run on Android.
bindEditorExportPlugin__export_begin :: MethodBind
bindEditorExportPlugin__export_begin
  = unsafePerformIO $
      withCString "EditorExportPlugin" $
        \ clsNamePtr ->
          withCString "_export_begin" $
            \ methodNamePtr ->
              godot_method_bind_get_method clsNamePtr methodNamePtr

-- | Virtual method to be overridden by the user. It is called when the export starts and provides all information about the export. @features@ is the list of features for the export, @is_debug@ is @true@ for debug builds, @path@ is the target path for the exported project. @flags@ is only used when running a runnable profile, e.g. when using native run on Android.
_export_begin ::
                (EditorExportPlugin :< cls, Object :< cls) =>
                cls -> PoolStringArray -> Bool -> GodotString -> Int -> IO ()
_export_begin cls arg1 arg2 arg3 arg4
  = withVariantArray
      [toVariant arg1, toVariant arg2, toVariant arg3, toVariant arg4]
      (\ (arrPtr, len) ->
         godot_method_bind_call bindEditorExportPlugin__export_begin
           (upcast cls)
           arrPtr
           len
           >>= \ (err, res) -> throwIfErr err >> fromGodotVariant res)

instance NodeMethod EditorExportPlugin "_export_begin"
           '[PoolStringArray, Bool, GodotString, Int]
           (IO ())
         where
        nodeMethod = Godot.Tools.EditorExportPlugin._export_begin

{-# NOINLINE bindEditorExportPlugin__export_end #-}

-- | Virtual method to be overridden by the user. Called when the export is finished.
bindEditorExportPlugin__export_end :: MethodBind
bindEditorExportPlugin__export_end
  = unsafePerformIO $
      withCString "EditorExportPlugin" $
        \ clsNamePtr ->
          withCString "_export_end" $
            \ methodNamePtr ->
              godot_method_bind_get_method clsNamePtr methodNamePtr

-- | Virtual method to be overridden by the user. Called when the export is finished.
_export_end ::
              (EditorExportPlugin :< cls, Object :< cls) => cls -> IO ()
_export_end cls
  = withVariantArray []
      (\ (arrPtr, len) ->
         godot_method_bind_call bindEditorExportPlugin__export_end
           (upcast cls)
           arrPtr
           len
           >>= \ (err, res) -> throwIfErr err >> fromGodotVariant res)

instance NodeMethod EditorExportPlugin "_export_end" '[] (IO ())
         where
        nodeMethod = Godot.Tools.EditorExportPlugin._export_end

{-# NOINLINE bindEditorExportPlugin__export_file #-}

-- | Virtual method to be overridden by the user. Called for each exported file, providing arguments that can be used to identify the file. @path@ is the path of the file, @type@ is the @Resource@ represented by the file (e.g. @PackedScene@) and @features@ is the list of features for the export.
--   				Calling @method skip@ inside this callback will make the file not included in the export.
bindEditorExportPlugin__export_file :: MethodBind
bindEditorExportPlugin__export_file
  = unsafePerformIO $
      withCString "EditorExportPlugin" $
        \ clsNamePtr ->
          withCString "_export_file" $
            \ methodNamePtr ->
              godot_method_bind_get_method clsNamePtr methodNamePtr

-- | Virtual method to be overridden by the user. Called for each exported file, providing arguments that can be used to identify the file. @path@ is the path of the file, @type@ is the @Resource@ represented by the file (e.g. @PackedScene@) and @features@ is the list of features for the export.
--   				Calling @method skip@ inside this callback will make the file not included in the export.
_export_file ::
               (EditorExportPlugin :< cls, Object :< cls) =>
               cls -> GodotString -> GodotString -> PoolStringArray -> IO ()
_export_file cls arg1 arg2 arg3
  = withVariantArray [toVariant arg1, toVariant arg2, toVariant arg3]
      (\ (arrPtr, len) ->
         godot_method_bind_call bindEditorExportPlugin__export_file
           (upcast cls)
           arrPtr
           len
           >>= \ (err, res) -> throwIfErr err >> fromGodotVariant res)

instance NodeMethod EditorExportPlugin "_export_file"
           '[GodotString, GodotString, PoolStringArray]
           (IO ())
         where
        nodeMethod = Godot.Tools.EditorExportPlugin._export_file

{-# NOINLINE bindEditorExportPlugin_add_file #-}

-- | Adds a custom file to be exported. @path@ is the virtual path that can be used to load the file, @file@ is the binary data of the file. If @remap@ is @true@, file will not be exported, but instead remapped to the given @path@.
bindEditorExportPlugin_add_file :: MethodBind
bindEditorExportPlugin_add_file
  = unsafePerformIO $
      withCString "EditorExportPlugin" $
        \ clsNamePtr ->
          withCString "add_file" $
            \ methodNamePtr ->
              godot_method_bind_get_method clsNamePtr methodNamePtr

-- | Adds a custom file to be exported. @path@ is the virtual path that can be used to load the file, @file@ is the binary data of the file. If @remap@ is @true@, file will not be exported, but instead remapped to the given @path@.
add_file ::
           (EditorExportPlugin :< cls, Object :< cls) =>
           cls -> GodotString -> PoolByteArray -> Bool -> IO ()
add_file cls arg1 arg2 arg3
  = withVariantArray [toVariant arg1, toVariant arg2, toVariant arg3]
      (\ (arrPtr, len) ->
         godot_method_bind_call bindEditorExportPlugin_add_file (upcast cls)
           arrPtr
           len
           >>= \ (err, res) -> throwIfErr err >> fromGodotVariant res)

instance NodeMethod EditorExportPlugin "add_file"
           '[GodotString, PoolByteArray, Bool]
           (IO ())
         where
        nodeMethod = Godot.Tools.EditorExportPlugin.add_file

{-# NOINLINE bindEditorExportPlugin_add_ios_bundle_file #-}

-- | Adds an iOS bundle file from the given @path@ to the exported project.
bindEditorExportPlugin_add_ios_bundle_file :: MethodBind
bindEditorExportPlugin_add_ios_bundle_file
  = unsafePerformIO $
      withCString "EditorExportPlugin" $
        \ clsNamePtr ->
          withCString "add_ios_bundle_file" $
            \ methodNamePtr ->
              godot_method_bind_get_method clsNamePtr methodNamePtr

-- | Adds an iOS bundle file from the given @path@ to the exported project.
add_ios_bundle_file ::
                      (EditorExportPlugin :< cls, Object :< cls) =>
                      cls -> GodotString -> IO ()
add_ios_bundle_file cls arg1
  = withVariantArray [toVariant arg1]
      (\ (arrPtr, len) ->
         godot_method_bind_call bindEditorExportPlugin_add_ios_bundle_file
           (upcast cls)
           arrPtr
           len
           >>= \ (err, res) -> throwIfErr err >> fromGodotVariant res)

instance NodeMethod EditorExportPlugin "add_ios_bundle_file"
           '[GodotString]
           (IO ())
         where
        nodeMethod = Godot.Tools.EditorExportPlugin.add_ios_bundle_file

{-# NOINLINE bindEditorExportPlugin_add_ios_cpp_code #-}

-- | Adds a C++ code to the iOS export. The final code is created from the code appended by each active export plugin.
bindEditorExportPlugin_add_ios_cpp_code :: MethodBind
bindEditorExportPlugin_add_ios_cpp_code
  = unsafePerformIO $
      withCString "EditorExportPlugin" $
        \ clsNamePtr ->
          withCString "add_ios_cpp_code" $
            \ methodNamePtr ->
              godot_method_bind_get_method clsNamePtr methodNamePtr

-- | Adds a C++ code to the iOS export. The final code is created from the code appended by each active export plugin.
add_ios_cpp_code ::
                   (EditorExportPlugin :< cls, Object :< cls) =>
                   cls -> GodotString -> IO ()
add_ios_cpp_code cls arg1
  = withVariantArray [toVariant arg1]
      (\ (arrPtr, len) ->
         godot_method_bind_call bindEditorExportPlugin_add_ios_cpp_code
           (upcast cls)
           arrPtr
           len
           >>= \ (err, res) -> throwIfErr err >> fromGodotVariant res)

instance NodeMethod EditorExportPlugin "add_ios_cpp_code"
           '[GodotString]
           (IO ())
         where
        nodeMethod = Godot.Tools.EditorExportPlugin.add_ios_cpp_code

{-# NOINLINE bindEditorExportPlugin_add_ios_embedded_framework #-}

-- | Adds a dynamic library (*.dylib, *.framework) to Linking Phase in iOS's Xcode project and embeds it into resulting binary.
--   				__Note:__ For static libraries (*.a) works in same way as @method add_ios_framework@.
--   				This method should not be used for System libraries as they are already present on the device.
bindEditorExportPlugin_add_ios_embedded_framework :: MethodBind
bindEditorExportPlugin_add_ios_embedded_framework
  = unsafePerformIO $
      withCString "EditorExportPlugin" $
        \ clsNamePtr ->
          withCString "add_ios_embedded_framework" $
            \ methodNamePtr ->
              godot_method_bind_get_method clsNamePtr methodNamePtr

-- | Adds a dynamic library (*.dylib, *.framework) to Linking Phase in iOS's Xcode project and embeds it into resulting binary.
--   				__Note:__ For static libraries (*.a) works in same way as @method add_ios_framework@.
--   				This method should not be used for System libraries as they are already present on the device.
add_ios_embedded_framework ::
                             (EditorExportPlugin :< cls, Object :< cls) =>
                             cls -> GodotString -> IO ()
add_ios_embedded_framework cls arg1
  = withVariantArray [toVariant arg1]
      (\ (arrPtr, len) ->
         godot_method_bind_call
           bindEditorExportPlugin_add_ios_embedded_framework
           (upcast cls)
           arrPtr
           len
           >>= \ (err, res) -> throwIfErr err >> fromGodotVariant res)

instance NodeMethod EditorExportPlugin "add_ios_embedded_framework"
           '[GodotString]
           (IO ())
         where
        nodeMethod
          = Godot.Tools.EditorExportPlugin.add_ios_embedded_framework

{-# NOINLINE bindEditorExportPlugin_add_ios_framework #-}

-- | Adds a static library (*.a) or dynamic library (*.dylib, *.framework) to Linking Phase in iOS's Xcode project.
bindEditorExportPlugin_add_ios_framework :: MethodBind
bindEditorExportPlugin_add_ios_framework
  = unsafePerformIO $
      withCString "EditorExportPlugin" $
        \ clsNamePtr ->
          withCString "add_ios_framework" $
            \ methodNamePtr ->
              godot_method_bind_get_method clsNamePtr methodNamePtr

-- | Adds a static library (*.a) or dynamic library (*.dylib, *.framework) to Linking Phase in iOS's Xcode project.
add_ios_framework ::
                    (EditorExportPlugin :< cls, Object :< cls) =>
                    cls -> GodotString -> IO ()
add_ios_framework cls arg1
  = withVariantArray [toVariant arg1]
      (\ (arrPtr, len) ->
         godot_method_bind_call bindEditorExportPlugin_add_ios_framework
           (upcast cls)
           arrPtr
           len
           >>= \ (err, res) -> throwIfErr err >> fromGodotVariant res)

instance NodeMethod EditorExportPlugin "add_ios_framework"
           '[GodotString]
           (IO ())
         where
        nodeMethod = Godot.Tools.EditorExportPlugin.add_ios_framework

{-# NOINLINE bindEditorExportPlugin_add_ios_linker_flags #-}

-- | Adds linker flags for the iOS export.
bindEditorExportPlugin_add_ios_linker_flags :: MethodBind
bindEditorExportPlugin_add_ios_linker_flags
  = unsafePerformIO $
      withCString "EditorExportPlugin" $
        \ clsNamePtr ->
          withCString "add_ios_linker_flags" $
            \ methodNamePtr ->
              godot_method_bind_get_method clsNamePtr methodNamePtr

-- | Adds linker flags for the iOS export.
add_ios_linker_flags ::
                       (EditorExportPlugin :< cls, Object :< cls) =>
                       cls -> GodotString -> IO ()
add_ios_linker_flags cls arg1
  = withVariantArray [toVariant arg1]
      (\ (arrPtr, len) ->
         godot_method_bind_call bindEditorExportPlugin_add_ios_linker_flags
           (upcast cls)
           arrPtr
           len
           >>= \ (err, res) -> throwIfErr err >> fromGodotVariant res)

instance NodeMethod EditorExportPlugin "add_ios_linker_flags"
           '[GodotString]
           (IO ())
         where
        nodeMethod = Godot.Tools.EditorExportPlugin.add_ios_linker_flags

{-# NOINLINE bindEditorExportPlugin_add_ios_plist_content #-}

-- | Adds content for iOS Property List files.
bindEditorExportPlugin_add_ios_plist_content :: MethodBind
bindEditorExportPlugin_add_ios_plist_content
  = unsafePerformIO $
      withCString "EditorExportPlugin" $
        \ clsNamePtr ->
          withCString "add_ios_plist_content" $
            \ methodNamePtr ->
              godot_method_bind_get_method clsNamePtr methodNamePtr

-- | Adds content for iOS Property List files.
add_ios_plist_content ::
                        (EditorExportPlugin :< cls, Object :< cls) =>
                        cls -> GodotString -> IO ()
add_ios_plist_content cls arg1
  = withVariantArray [toVariant arg1]
      (\ (arrPtr, len) ->
         godot_method_bind_call bindEditorExportPlugin_add_ios_plist_content
           (upcast cls)
           arrPtr
           len
           >>= \ (err, res) -> throwIfErr err >> fromGodotVariant res)

instance NodeMethod EditorExportPlugin "add_ios_plist_content"
           '[GodotString]
           (IO ())
         where
        nodeMethod = Godot.Tools.EditorExportPlugin.add_ios_plist_content

{-# NOINLINE bindEditorExportPlugin_add_ios_project_static_lib #-}

-- | Adds a static lib from the given @path@ to the iOS project.
bindEditorExportPlugin_add_ios_project_static_lib :: MethodBind
bindEditorExportPlugin_add_ios_project_static_lib
  = unsafePerformIO $
      withCString "EditorExportPlugin" $
        \ clsNamePtr ->
          withCString "add_ios_project_static_lib" $
            \ methodNamePtr ->
              godot_method_bind_get_method clsNamePtr methodNamePtr

-- | Adds a static lib from the given @path@ to the iOS project.
add_ios_project_static_lib ::
                             (EditorExportPlugin :< cls, Object :< cls) =>
                             cls -> GodotString -> IO ()
add_ios_project_static_lib cls arg1
  = withVariantArray [toVariant arg1]
      (\ (arrPtr, len) ->
         godot_method_bind_call
           bindEditorExportPlugin_add_ios_project_static_lib
           (upcast cls)
           arrPtr
           len
           >>= \ (err, res) -> throwIfErr err >> fromGodotVariant res)

instance NodeMethod EditorExportPlugin "add_ios_project_static_lib"
           '[GodotString]
           (IO ())
         where
        nodeMethod
          = Godot.Tools.EditorExportPlugin.add_ios_project_static_lib

{-# NOINLINE bindEditorExportPlugin_add_shared_object #-}

-- | Adds a shared object with the given @tags@ and destination @path@.
bindEditorExportPlugin_add_shared_object :: MethodBind
bindEditorExportPlugin_add_shared_object
  = unsafePerformIO $
      withCString "EditorExportPlugin" $
        \ clsNamePtr ->
          withCString "add_shared_object" $
            \ methodNamePtr ->
              godot_method_bind_get_method clsNamePtr methodNamePtr

-- | Adds a shared object with the given @tags@ and destination @path@.
add_shared_object ::
                    (EditorExportPlugin :< cls, Object :< cls) =>
                    cls -> GodotString -> PoolStringArray -> IO ()
add_shared_object cls arg1 arg2
  = withVariantArray [toVariant arg1, toVariant arg2]
      (\ (arrPtr, len) ->
         godot_method_bind_call bindEditorExportPlugin_add_shared_object
           (upcast cls)
           arrPtr
           len
           >>= \ (err, res) -> throwIfErr err >> fromGodotVariant res)

instance NodeMethod EditorExportPlugin "add_shared_object"
           '[GodotString, PoolStringArray]
           (IO ())
         where
        nodeMethod = Godot.Tools.EditorExportPlugin.add_shared_object

{-# NOINLINE bindEditorExportPlugin_skip #-}

-- | To be called inside @method _export_file@. Skips the current file, so it's not included in the export.
bindEditorExportPlugin_skip :: MethodBind
bindEditorExportPlugin_skip
  = unsafePerformIO $
      withCString "EditorExportPlugin" $
        \ clsNamePtr ->
          withCString "skip" $
            \ methodNamePtr ->
              godot_method_bind_get_method clsNamePtr methodNamePtr

-- | To be called inside @method _export_file@. Skips the current file, so it's not included in the export.
skip :: (EditorExportPlugin :< cls, Object :< cls) => cls -> IO ()
skip cls
  = withVariantArray []
      (\ (arrPtr, len) ->
         godot_method_bind_call bindEditorExportPlugin_skip (upcast cls)
           arrPtr
           len
           >>= \ (err, res) -> throwIfErr err >> fromGodotVariant res)

instance NodeMethod EditorExportPlugin "skip" '[] (IO ()) where
        nodeMethod = Godot.Tools.EditorExportPlugin.skip