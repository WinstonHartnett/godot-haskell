{-# LANGUAGE DerivingStrategies, GeneralizedNewtypeDeriving,
  TypeFamilies, TypeOperators, FlexibleContexts, DataKinds,
  MultiParamTypeClasses #-}
module Godot.Tools.EditorInterface
       (Godot.Tools.EditorInterface.edit_node,
        Godot.Tools.EditorInterface.edit_resource,
        Godot.Tools.EditorInterface.get_base_control,
        Godot.Tools.EditorInterface.get_current_path,
        Godot.Tools.EditorInterface.get_edited_scene_root,
        Godot.Tools.EditorInterface.get_editor_scale,
        Godot.Tools.EditorInterface.get_editor_settings,
        Godot.Tools.EditorInterface.get_editor_viewport,
        Godot.Tools.EditorInterface.get_file_system_dock,
        Godot.Tools.EditorInterface.get_inspector,
        Godot.Tools.EditorInterface.get_open_scenes,
        Godot.Tools.EditorInterface.get_playing_scene,
        Godot.Tools.EditorInterface.get_resource_filesystem,
        Godot.Tools.EditorInterface.get_resource_previewer,
        Godot.Tools.EditorInterface.get_script_editor,
        Godot.Tools.EditorInterface.get_selected_path,
        Godot.Tools.EditorInterface.get_selection,
        Godot.Tools.EditorInterface.inspect_object,
        Godot.Tools.EditorInterface.is_distraction_free_mode_enabled,
        Godot.Tools.EditorInterface.is_playing_scene,
        Godot.Tools.EditorInterface.is_plugin_enabled,
        Godot.Tools.EditorInterface.make_mesh_previews,
        Godot.Tools.EditorInterface.open_scene_from_path,
        Godot.Tools.EditorInterface.play_current_scene,
        Godot.Tools.EditorInterface.play_custom_scene,
        Godot.Tools.EditorInterface.play_main_scene,
        Godot.Tools.EditorInterface.reload_scene_from_path,
        Godot.Tools.EditorInterface.save_scene,
        Godot.Tools.EditorInterface.save_scene_as,
        Godot.Tools.EditorInterface.select_file,
        Godot.Tools.EditorInterface.set_distraction_free_mode,
        Godot.Tools.EditorInterface.set_main_screen_editor,
        Godot.Tools.EditorInterface.set_plugin_enabled,
        Godot.Tools.EditorInterface.stop_playing_scene)
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
import Godot.Core.Node()

instance NodeProperty EditorInterface "distraction_free_mode" Bool
           'False
         where
        nodeProperty
          = (is_distraction_free_mode_enabled,
             wrapDroppingSetter set_distraction_free_mode, Nothing)

{-# NOINLINE bindEditorInterface_edit_node #-}

-- | Edits the given @Node@. The node will be also selected if it's inside the scene tree.
bindEditorInterface_edit_node :: MethodBind
bindEditorInterface_edit_node
  = unsafePerformIO $
      withCString "EditorInterface" $
        \ clsNamePtr ->
          withCString "edit_node" $
            \ methodNamePtr ->
              godot_method_bind_get_method clsNamePtr methodNamePtr

-- | Edits the given @Node@. The node will be also selected if it's inside the scene tree.
edit_node ::
            (EditorInterface :< cls, Object :< cls) => cls -> Node -> IO ()
edit_node cls arg1
  = withVariantArray [toVariant arg1]
      (\ (arrPtr, len) ->
         godot_method_bind_call bindEditorInterface_edit_node (upcast cls)
           arrPtr
           len
           >>= \ (err, res) -> throwIfErr err >> fromGodotVariant res)

instance NodeMethod EditorInterface "edit_node" '[Node] (IO ())
         where
        nodeMethod = Godot.Tools.EditorInterface.edit_node

{-# NOINLINE bindEditorInterface_edit_resource #-}

-- | Edits the given @Resource@.
bindEditorInterface_edit_resource :: MethodBind
bindEditorInterface_edit_resource
  = unsafePerformIO $
      withCString "EditorInterface" $
        \ clsNamePtr ->
          withCString "edit_resource" $
            \ methodNamePtr ->
              godot_method_bind_get_method clsNamePtr methodNamePtr

-- | Edits the given @Resource@.
edit_resource ::
                (EditorInterface :< cls, Object :< cls) => cls -> Resource -> IO ()
edit_resource cls arg1
  = withVariantArray [toVariant arg1]
      (\ (arrPtr, len) ->
         godot_method_bind_call bindEditorInterface_edit_resource
           (upcast cls)
           arrPtr
           len
           >>= \ (err, res) -> throwIfErr err >> fromGodotVariant res)

instance NodeMethod EditorInterface "edit_resource" '[Resource]
           (IO ())
         where
        nodeMethod = Godot.Tools.EditorInterface.edit_resource

{-# NOINLINE bindEditorInterface_get_base_control #-}

-- | Returns the main container of Godot editor's window. For example, you can use it to retrieve the size of the container and place your controls accordingly.
bindEditorInterface_get_base_control :: MethodBind
bindEditorInterface_get_base_control
  = unsafePerformIO $
      withCString "EditorInterface" $
        \ clsNamePtr ->
          withCString "get_base_control" $
            \ methodNamePtr ->
              godot_method_bind_get_method clsNamePtr methodNamePtr

-- | Returns the main container of Godot editor's window. For example, you can use it to retrieve the size of the container and place your controls accordingly.
get_base_control ::
                   (EditorInterface :< cls, Object :< cls) => cls -> IO Control
get_base_control cls
  = withVariantArray []
      (\ (arrPtr, len) ->
         godot_method_bind_call bindEditorInterface_get_base_control
           (upcast cls)
           arrPtr
           len
           >>= \ (err, res) -> throwIfErr err >> fromGodotVariant res)

instance NodeMethod EditorInterface "get_base_control" '[]
           (IO Control)
         where
        nodeMethod = Godot.Tools.EditorInterface.get_base_control

{-# NOINLINE bindEditorInterface_get_current_path #-}

-- | Returns the current path being viewed in the @FileSystemDock@.
bindEditorInterface_get_current_path :: MethodBind
bindEditorInterface_get_current_path
  = unsafePerformIO $
      withCString "EditorInterface" $
        \ clsNamePtr ->
          withCString "get_current_path" $
            \ methodNamePtr ->
              godot_method_bind_get_method clsNamePtr methodNamePtr

-- | Returns the current path being viewed in the @FileSystemDock@.
get_current_path ::
                   (EditorInterface :< cls, Object :< cls) => cls -> IO GodotString
get_current_path cls
  = withVariantArray []
      (\ (arrPtr, len) ->
         godot_method_bind_call bindEditorInterface_get_current_path
           (upcast cls)
           arrPtr
           len
           >>= \ (err, res) -> throwIfErr err >> fromGodotVariant res)

instance NodeMethod EditorInterface "get_current_path" '[]
           (IO GodotString)
         where
        nodeMethod = Godot.Tools.EditorInterface.get_current_path

{-# NOINLINE bindEditorInterface_get_edited_scene_root #-}

-- | Returns the edited (current) scene's root @Node@.
bindEditorInterface_get_edited_scene_root :: MethodBind
bindEditorInterface_get_edited_scene_root
  = unsafePerformIO $
      withCString "EditorInterface" $
        \ clsNamePtr ->
          withCString "get_edited_scene_root" $
            \ methodNamePtr ->
              godot_method_bind_get_method clsNamePtr methodNamePtr

-- | Returns the edited (current) scene's root @Node@.
get_edited_scene_root ::
                        (EditorInterface :< cls, Object :< cls) => cls -> IO Node
get_edited_scene_root cls
  = withVariantArray []
      (\ (arrPtr, len) ->
         godot_method_bind_call bindEditorInterface_get_edited_scene_root
           (upcast cls)
           arrPtr
           len
           >>= \ (err, res) -> throwIfErr err >> fromGodotVariant res)

instance NodeMethod EditorInterface "get_edited_scene_root" '[]
           (IO Node)
         where
        nodeMethod = Godot.Tools.EditorInterface.get_edited_scene_root

{-# NOINLINE bindEditorInterface_get_editor_scale #-}

-- | Returns the actual scale of the editor UI (@1.0@ being 100% scale). This can be used to adjust position and dimensions of the UI added by plugins.
--   				__Note:__ This value is set via the @interface/editor/display_scale@ and @interface/editor/custom_display_scale@ editor settings. Editor must be restarted for changes to be properly applied.
bindEditorInterface_get_editor_scale :: MethodBind
bindEditorInterface_get_editor_scale
  = unsafePerformIO $
      withCString "EditorInterface" $
        \ clsNamePtr ->
          withCString "get_editor_scale" $
            \ methodNamePtr ->
              godot_method_bind_get_method clsNamePtr methodNamePtr

-- | Returns the actual scale of the editor UI (@1.0@ being 100% scale). This can be used to adjust position and dimensions of the UI added by plugins.
--   				__Note:__ This value is set via the @interface/editor/display_scale@ and @interface/editor/custom_display_scale@ editor settings. Editor must be restarted for changes to be properly applied.
get_editor_scale ::
                   (EditorInterface :< cls, Object :< cls) => cls -> IO Float
get_editor_scale cls
  = withVariantArray []
      (\ (arrPtr, len) ->
         godot_method_bind_call bindEditorInterface_get_editor_scale
           (upcast cls)
           arrPtr
           len
           >>= \ (err, res) -> throwIfErr err >> fromGodotVariant res)

instance NodeMethod EditorInterface "get_editor_scale" '[]
           (IO Float)
         where
        nodeMethod = Godot.Tools.EditorInterface.get_editor_scale

{-# NOINLINE bindEditorInterface_get_editor_settings #-}

-- | Returns the editor's @EditorSettings@ instance.
bindEditorInterface_get_editor_settings :: MethodBind
bindEditorInterface_get_editor_settings
  = unsafePerformIO $
      withCString "EditorInterface" $
        \ clsNamePtr ->
          withCString "get_editor_settings" $
            \ methodNamePtr ->
              godot_method_bind_get_method clsNamePtr methodNamePtr

-- | Returns the editor's @EditorSettings@ instance.
get_editor_settings ::
                      (EditorInterface :< cls, Object :< cls) => cls -> IO EditorSettings
get_editor_settings cls
  = withVariantArray []
      (\ (arrPtr, len) ->
         godot_method_bind_call bindEditorInterface_get_editor_settings
           (upcast cls)
           arrPtr
           len
           >>= \ (err, res) -> throwIfErr err >> fromGodotVariant res)

instance NodeMethod EditorInterface "get_editor_settings" '[]
           (IO EditorSettings)
         where
        nodeMethod = Godot.Tools.EditorInterface.get_editor_settings

{-# NOINLINE bindEditorInterface_get_editor_viewport #-}

-- | Returns the main editor control. Use this as a parent for main screens.
--   				__Note:__ This returns the main editor control containing the whole editor, not the 2D or 3D viewports specifically.
bindEditorInterface_get_editor_viewport :: MethodBind
bindEditorInterface_get_editor_viewport
  = unsafePerformIO $
      withCString "EditorInterface" $
        \ clsNamePtr ->
          withCString "get_editor_viewport" $
            \ methodNamePtr ->
              godot_method_bind_get_method clsNamePtr methodNamePtr

-- | Returns the main editor control. Use this as a parent for main screens.
--   				__Note:__ This returns the main editor control containing the whole editor, not the 2D or 3D viewports specifically.
get_editor_viewport ::
                      (EditorInterface :< cls, Object :< cls) => cls -> IO Control
get_editor_viewport cls
  = withVariantArray []
      (\ (arrPtr, len) ->
         godot_method_bind_call bindEditorInterface_get_editor_viewport
           (upcast cls)
           arrPtr
           len
           >>= \ (err, res) -> throwIfErr err >> fromGodotVariant res)

instance NodeMethod EditorInterface "get_editor_viewport" '[]
           (IO Control)
         where
        nodeMethod = Godot.Tools.EditorInterface.get_editor_viewport

{-# NOINLINE bindEditorInterface_get_file_system_dock #-}

-- | Returns the editor's @FileSystemDock@ instance.
bindEditorInterface_get_file_system_dock :: MethodBind
bindEditorInterface_get_file_system_dock
  = unsafePerformIO $
      withCString "EditorInterface" $
        \ clsNamePtr ->
          withCString "get_file_system_dock" $
            \ methodNamePtr ->
              godot_method_bind_get_method clsNamePtr methodNamePtr

-- | Returns the editor's @FileSystemDock@ instance.
get_file_system_dock ::
                       (EditorInterface :< cls, Object :< cls) => cls -> IO FileSystemDock
get_file_system_dock cls
  = withVariantArray []
      (\ (arrPtr, len) ->
         godot_method_bind_call bindEditorInterface_get_file_system_dock
           (upcast cls)
           arrPtr
           len
           >>= \ (err, res) -> throwIfErr err >> fromGodotVariant res)

instance NodeMethod EditorInterface "get_file_system_dock" '[]
           (IO FileSystemDock)
         where
        nodeMethod = Godot.Tools.EditorInterface.get_file_system_dock

{-# NOINLINE bindEditorInterface_get_inspector #-}

-- | Returns the editor's @EditorInspector@ instance.
bindEditorInterface_get_inspector :: MethodBind
bindEditorInterface_get_inspector
  = unsafePerformIO $
      withCString "EditorInterface" $
        \ clsNamePtr ->
          withCString "get_inspector" $
            \ methodNamePtr ->
              godot_method_bind_get_method clsNamePtr methodNamePtr

-- | Returns the editor's @EditorInspector@ instance.
get_inspector ::
                (EditorInterface :< cls, Object :< cls) =>
                cls -> IO EditorInspector
get_inspector cls
  = withVariantArray []
      (\ (arrPtr, len) ->
         godot_method_bind_call bindEditorInterface_get_inspector
           (upcast cls)
           arrPtr
           len
           >>= \ (err, res) -> throwIfErr err >> fromGodotVariant res)

instance NodeMethod EditorInterface "get_inspector" '[]
           (IO EditorInspector)
         where
        nodeMethod = Godot.Tools.EditorInterface.get_inspector

{-# NOINLINE bindEditorInterface_get_open_scenes #-}

-- | Returns an @Array@ with the file paths of the currently opened scenes.
bindEditorInterface_get_open_scenes :: MethodBind
bindEditorInterface_get_open_scenes
  = unsafePerformIO $
      withCString "EditorInterface" $
        \ clsNamePtr ->
          withCString "get_open_scenes" $
            \ methodNamePtr ->
              godot_method_bind_get_method clsNamePtr methodNamePtr

-- | Returns an @Array@ with the file paths of the currently opened scenes.
get_open_scenes ::
                  (EditorInterface :< cls, Object :< cls) => cls -> IO Array
get_open_scenes cls
  = withVariantArray []
      (\ (arrPtr, len) ->
         godot_method_bind_call bindEditorInterface_get_open_scenes
           (upcast cls)
           arrPtr
           len
           >>= \ (err, res) -> throwIfErr err >> fromGodotVariant res)

instance NodeMethod EditorInterface "get_open_scenes" '[]
           (IO Array)
         where
        nodeMethod = Godot.Tools.EditorInterface.get_open_scenes

{-# NOINLINE bindEditorInterface_get_playing_scene #-}

-- | Returns the name of the scene that is being played. If no scene is currently being played, returns an empty string.
bindEditorInterface_get_playing_scene :: MethodBind
bindEditorInterface_get_playing_scene
  = unsafePerformIO $
      withCString "EditorInterface" $
        \ clsNamePtr ->
          withCString "get_playing_scene" $
            \ methodNamePtr ->
              godot_method_bind_get_method clsNamePtr methodNamePtr

-- | Returns the name of the scene that is being played. If no scene is currently being played, returns an empty string.
get_playing_scene ::
                    (EditorInterface :< cls, Object :< cls) => cls -> IO GodotString
get_playing_scene cls
  = withVariantArray []
      (\ (arrPtr, len) ->
         godot_method_bind_call bindEditorInterface_get_playing_scene
           (upcast cls)
           arrPtr
           len
           >>= \ (err, res) -> throwIfErr err >> fromGodotVariant res)

instance NodeMethod EditorInterface "get_playing_scene" '[]
           (IO GodotString)
         where
        nodeMethod = Godot.Tools.EditorInterface.get_playing_scene

{-# NOINLINE bindEditorInterface_get_resource_filesystem #-}

-- | Returns the editor's @EditorFileSystem@ instance.
bindEditorInterface_get_resource_filesystem :: MethodBind
bindEditorInterface_get_resource_filesystem
  = unsafePerformIO $
      withCString "EditorInterface" $
        \ clsNamePtr ->
          withCString "get_resource_filesystem" $
            \ methodNamePtr ->
              godot_method_bind_get_method clsNamePtr methodNamePtr

-- | Returns the editor's @EditorFileSystem@ instance.
get_resource_filesystem ::
                          (EditorInterface :< cls, Object :< cls) =>
                          cls -> IO EditorFileSystem
get_resource_filesystem cls
  = withVariantArray []
      (\ (arrPtr, len) ->
         godot_method_bind_call bindEditorInterface_get_resource_filesystem
           (upcast cls)
           arrPtr
           len
           >>= \ (err, res) -> throwIfErr err >> fromGodotVariant res)

instance NodeMethod EditorInterface "get_resource_filesystem" '[]
           (IO EditorFileSystem)
         where
        nodeMethod = Godot.Tools.EditorInterface.get_resource_filesystem

{-# NOINLINE bindEditorInterface_get_resource_previewer #-}

-- | Returns the editor's @EditorResourcePreview@ instance.
bindEditorInterface_get_resource_previewer :: MethodBind
bindEditorInterface_get_resource_previewer
  = unsafePerformIO $
      withCString "EditorInterface" $
        \ clsNamePtr ->
          withCString "get_resource_previewer" $
            \ methodNamePtr ->
              godot_method_bind_get_method clsNamePtr methodNamePtr

-- | Returns the editor's @EditorResourcePreview@ instance.
get_resource_previewer ::
                         (EditorInterface :< cls, Object :< cls) =>
                         cls -> IO EditorResourcePreview
get_resource_previewer cls
  = withVariantArray []
      (\ (arrPtr, len) ->
         godot_method_bind_call bindEditorInterface_get_resource_previewer
           (upcast cls)
           arrPtr
           len
           >>= \ (err, res) -> throwIfErr err >> fromGodotVariant res)

instance NodeMethod EditorInterface "get_resource_previewer" '[]
           (IO EditorResourcePreview)
         where
        nodeMethod = Godot.Tools.EditorInterface.get_resource_previewer

{-# NOINLINE bindEditorInterface_get_script_editor #-}

-- | Returns the editor's @ScriptEditor@ instance.
bindEditorInterface_get_script_editor :: MethodBind
bindEditorInterface_get_script_editor
  = unsafePerformIO $
      withCString "EditorInterface" $
        \ clsNamePtr ->
          withCString "get_script_editor" $
            \ methodNamePtr ->
              godot_method_bind_get_method clsNamePtr methodNamePtr

-- | Returns the editor's @ScriptEditor@ instance.
get_script_editor ::
                    (EditorInterface :< cls, Object :< cls) => cls -> IO ScriptEditor
get_script_editor cls
  = withVariantArray []
      (\ (arrPtr, len) ->
         godot_method_bind_call bindEditorInterface_get_script_editor
           (upcast cls)
           arrPtr
           len
           >>= \ (err, res) -> throwIfErr err >> fromGodotVariant res)

instance NodeMethod EditorInterface "get_script_editor" '[]
           (IO ScriptEditor)
         where
        nodeMethod = Godot.Tools.EditorInterface.get_script_editor

{-# NOINLINE bindEditorInterface_get_selected_path #-}

-- | Returns the path of the directory currently selected in the @FileSystemDock@. If a file is selected, its base directory will be returned using @method String.get_base_dir@ instead.
bindEditorInterface_get_selected_path :: MethodBind
bindEditorInterface_get_selected_path
  = unsafePerformIO $
      withCString "EditorInterface" $
        \ clsNamePtr ->
          withCString "get_selected_path" $
            \ methodNamePtr ->
              godot_method_bind_get_method clsNamePtr methodNamePtr

-- | Returns the path of the directory currently selected in the @FileSystemDock@. If a file is selected, its base directory will be returned using @method String.get_base_dir@ instead.
get_selected_path ::
                    (EditorInterface :< cls, Object :< cls) => cls -> IO GodotString
get_selected_path cls
  = withVariantArray []
      (\ (arrPtr, len) ->
         godot_method_bind_call bindEditorInterface_get_selected_path
           (upcast cls)
           arrPtr
           len
           >>= \ (err, res) -> throwIfErr err >> fromGodotVariant res)

instance NodeMethod EditorInterface "get_selected_path" '[]
           (IO GodotString)
         where
        nodeMethod = Godot.Tools.EditorInterface.get_selected_path

{-# NOINLINE bindEditorInterface_get_selection #-}

-- | Returns the editor's @EditorSelection@ instance.
bindEditorInterface_get_selection :: MethodBind
bindEditorInterface_get_selection
  = unsafePerformIO $
      withCString "EditorInterface" $
        \ clsNamePtr ->
          withCString "get_selection" $
            \ methodNamePtr ->
              godot_method_bind_get_method clsNamePtr methodNamePtr

-- | Returns the editor's @EditorSelection@ instance.
get_selection ::
                (EditorInterface :< cls, Object :< cls) =>
                cls -> IO EditorSelection
get_selection cls
  = withVariantArray []
      (\ (arrPtr, len) ->
         godot_method_bind_call bindEditorInterface_get_selection
           (upcast cls)
           arrPtr
           len
           >>= \ (err, res) -> throwIfErr err >> fromGodotVariant res)

instance NodeMethod EditorInterface "get_selection" '[]
           (IO EditorSelection)
         where
        nodeMethod = Godot.Tools.EditorInterface.get_selection

{-# NOINLINE bindEditorInterface_inspect_object #-}

-- | Shows the given property on the given @object@ in the editor's Inspector dock. If @inspector_only@ is @true@, plugins will not attempt to edit @object@.
bindEditorInterface_inspect_object :: MethodBind
bindEditorInterface_inspect_object
  = unsafePerformIO $
      withCString "EditorInterface" $
        \ clsNamePtr ->
          withCString "inspect_object" $
            \ methodNamePtr ->
              godot_method_bind_get_method clsNamePtr methodNamePtr

-- | Shows the given property on the given @object@ in the editor's Inspector dock. If @inspector_only@ is @true@, plugins will not attempt to edit @object@.
inspect_object ::
                 (EditorInterface :< cls, Object :< cls) =>
                 cls -> Object -> Maybe GodotString -> Maybe Bool -> IO ()
inspect_object cls arg1 arg2 arg3
  = withVariantArray
      [toVariant arg1, defaultedVariant VariantString "" arg2,
       maybe (VariantBool False) toVariant arg3]
      (\ (arrPtr, len) ->
         godot_method_bind_call bindEditorInterface_inspect_object
           (upcast cls)
           arrPtr
           len
           >>= \ (err, res) -> throwIfErr err >> fromGodotVariant res)

instance NodeMethod EditorInterface "inspect_object"
           '[Object, Maybe GodotString, Maybe Bool]
           (IO ())
         where
        nodeMethod = Godot.Tools.EditorInterface.inspect_object

{-# NOINLINE bindEditorInterface_is_distraction_free_mode_enabled
             #-}

-- | If @true@, enables distraction-free mode which hides side docks to increase the space available for the main view.
bindEditorInterface_is_distraction_free_mode_enabled :: MethodBind
bindEditorInterface_is_distraction_free_mode_enabled
  = unsafePerformIO $
      withCString "EditorInterface" $
        \ clsNamePtr ->
          withCString "is_distraction_free_mode_enabled" $
            \ methodNamePtr ->
              godot_method_bind_get_method clsNamePtr methodNamePtr

-- | If @true@, enables distraction-free mode which hides side docks to increase the space available for the main view.
is_distraction_free_mode_enabled ::
                                   (EditorInterface :< cls, Object :< cls) => cls -> IO Bool
is_distraction_free_mode_enabled cls
  = withVariantArray []
      (\ (arrPtr, len) ->
         godot_method_bind_call
           bindEditorInterface_is_distraction_free_mode_enabled
           (upcast cls)
           arrPtr
           len
           >>= \ (err, res) -> throwIfErr err >> fromGodotVariant res)

instance NodeMethod EditorInterface
           "is_distraction_free_mode_enabled"
           '[]
           (IO Bool)
         where
        nodeMethod
          = Godot.Tools.EditorInterface.is_distraction_free_mode_enabled

{-# NOINLINE bindEditorInterface_is_playing_scene #-}

-- | Returns @true@ if a scene is currently being played, @false@ otherwise. Paused scenes are considered as being played.
bindEditorInterface_is_playing_scene :: MethodBind
bindEditorInterface_is_playing_scene
  = unsafePerformIO $
      withCString "EditorInterface" $
        \ clsNamePtr ->
          withCString "is_playing_scene" $
            \ methodNamePtr ->
              godot_method_bind_get_method clsNamePtr methodNamePtr

-- | Returns @true@ if a scene is currently being played, @false@ otherwise. Paused scenes are considered as being played.
is_playing_scene ::
                   (EditorInterface :< cls, Object :< cls) => cls -> IO Bool
is_playing_scene cls
  = withVariantArray []
      (\ (arrPtr, len) ->
         godot_method_bind_call bindEditorInterface_is_playing_scene
           (upcast cls)
           arrPtr
           len
           >>= \ (err, res) -> throwIfErr err >> fromGodotVariant res)

instance NodeMethod EditorInterface "is_playing_scene" '[]
           (IO Bool)
         where
        nodeMethod = Godot.Tools.EditorInterface.is_playing_scene

{-# NOINLINE bindEditorInterface_is_plugin_enabled #-}

-- | Returns @true@ if the specified @plugin@ is enabled. The plugin name is the same as its directory name.
bindEditorInterface_is_plugin_enabled :: MethodBind
bindEditorInterface_is_plugin_enabled
  = unsafePerformIO $
      withCString "EditorInterface" $
        \ clsNamePtr ->
          withCString "is_plugin_enabled" $
            \ methodNamePtr ->
              godot_method_bind_get_method clsNamePtr methodNamePtr

-- | Returns @true@ if the specified @plugin@ is enabled. The plugin name is the same as its directory name.
is_plugin_enabled ::
                    (EditorInterface :< cls, Object :< cls) =>
                    cls -> GodotString -> IO Bool
is_plugin_enabled cls arg1
  = withVariantArray [toVariant arg1]
      (\ (arrPtr, len) ->
         godot_method_bind_call bindEditorInterface_is_plugin_enabled
           (upcast cls)
           arrPtr
           len
           >>= \ (err, res) -> throwIfErr err >> fromGodotVariant res)

instance NodeMethod EditorInterface "is_plugin_enabled"
           '[GodotString]
           (IO Bool)
         where
        nodeMethod = Godot.Tools.EditorInterface.is_plugin_enabled

{-# NOINLINE bindEditorInterface_make_mesh_previews #-}

-- | Returns mesh previews rendered at the given size as an @Array@ of @Texture@s.
bindEditorInterface_make_mesh_previews :: MethodBind
bindEditorInterface_make_mesh_previews
  = unsafePerformIO $
      withCString "EditorInterface" $
        \ clsNamePtr ->
          withCString "make_mesh_previews" $
            \ methodNamePtr ->
              godot_method_bind_get_method clsNamePtr methodNamePtr

-- | Returns mesh previews rendered at the given size as an @Array@ of @Texture@s.
make_mesh_previews ::
                     (EditorInterface :< cls, Object :< cls) =>
                     cls -> Array -> Int -> IO Array
make_mesh_previews cls arg1 arg2
  = withVariantArray [toVariant arg1, toVariant arg2]
      (\ (arrPtr, len) ->
         godot_method_bind_call bindEditorInterface_make_mesh_previews
           (upcast cls)
           arrPtr
           len
           >>= \ (err, res) -> throwIfErr err >> fromGodotVariant res)

instance NodeMethod EditorInterface "make_mesh_previews"
           '[Array, Int]
           (IO Array)
         where
        nodeMethod = Godot.Tools.EditorInterface.make_mesh_previews

{-# NOINLINE bindEditorInterface_open_scene_from_path #-}

-- | Opens the scene at the given path.
bindEditorInterface_open_scene_from_path :: MethodBind
bindEditorInterface_open_scene_from_path
  = unsafePerformIO $
      withCString "EditorInterface" $
        \ clsNamePtr ->
          withCString "open_scene_from_path" $
            \ methodNamePtr ->
              godot_method_bind_get_method clsNamePtr methodNamePtr

-- | Opens the scene at the given path.
open_scene_from_path ::
                       (EditorInterface :< cls, Object :< cls) =>
                       cls -> GodotString -> IO ()
open_scene_from_path cls arg1
  = withVariantArray [toVariant arg1]
      (\ (arrPtr, len) ->
         godot_method_bind_call bindEditorInterface_open_scene_from_path
           (upcast cls)
           arrPtr
           len
           >>= \ (err, res) -> throwIfErr err >> fromGodotVariant res)

instance NodeMethod EditorInterface "open_scene_from_path"
           '[GodotString]
           (IO ())
         where
        nodeMethod = Godot.Tools.EditorInterface.open_scene_from_path

{-# NOINLINE bindEditorInterface_play_current_scene #-}

-- | Plays the currently active scene.
bindEditorInterface_play_current_scene :: MethodBind
bindEditorInterface_play_current_scene
  = unsafePerformIO $
      withCString "EditorInterface" $
        \ clsNamePtr ->
          withCString "play_current_scene" $
            \ methodNamePtr ->
              godot_method_bind_get_method clsNamePtr methodNamePtr

-- | Plays the currently active scene.
play_current_scene ::
                     (EditorInterface :< cls, Object :< cls) => cls -> IO ()
play_current_scene cls
  = withVariantArray []
      (\ (arrPtr, len) ->
         godot_method_bind_call bindEditorInterface_play_current_scene
           (upcast cls)
           arrPtr
           len
           >>= \ (err, res) -> throwIfErr err >> fromGodotVariant res)

instance NodeMethod EditorInterface "play_current_scene" '[]
           (IO ())
         where
        nodeMethod = Godot.Tools.EditorInterface.play_current_scene

{-# NOINLINE bindEditorInterface_play_custom_scene #-}

-- | Plays the scene specified by its filepath.
bindEditorInterface_play_custom_scene :: MethodBind
bindEditorInterface_play_custom_scene
  = unsafePerformIO $
      withCString "EditorInterface" $
        \ clsNamePtr ->
          withCString "play_custom_scene" $
            \ methodNamePtr ->
              godot_method_bind_get_method clsNamePtr methodNamePtr

-- | Plays the scene specified by its filepath.
play_custom_scene ::
                    (EditorInterface :< cls, Object :< cls) =>
                    cls -> GodotString -> IO ()
play_custom_scene cls arg1
  = withVariantArray [toVariant arg1]
      (\ (arrPtr, len) ->
         godot_method_bind_call bindEditorInterface_play_custom_scene
           (upcast cls)
           arrPtr
           len
           >>= \ (err, res) -> throwIfErr err >> fromGodotVariant res)

instance NodeMethod EditorInterface "play_custom_scene"
           '[GodotString]
           (IO ())
         where
        nodeMethod = Godot.Tools.EditorInterface.play_custom_scene

{-# NOINLINE bindEditorInterface_play_main_scene #-}

-- | Plays the main scene.
bindEditorInterface_play_main_scene :: MethodBind
bindEditorInterface_play_main_scene
  = unsafePerformIO $
      withCString "EditorInterface" $
        \ clsNamePtr ->
          withCString "play_main_scene" $
            \ methodNamePtr ->
              godot_method_bind_get_method clsNamePtr methodNamePtr

-- | Plays the main scene.
play_main_scene ::
                  (EditorInterface :< cls, Object :< cls) => cls -> IO ()
play_main_scene cls
  = withVariantArray []
      (\ (arrPtr, len) ->
         godot_method_bind_call bindEditorInterface_play_main_scene
           (upcast cls)
           arrPtr
           len
           >>= \ (err, res) -> throwIfErr err >> fromGodotVariant res)

instance NodeMethod EditorInterface "play_main_scene" '[] (IO ())
         where
        nodeMethod = Godot.Tools.EditorInterface.play_main_scene

{-# NOINLINE bindEditorInterface_reload_scene_from_path #-}

-- | Reloads the scene at the given path.
bindEditorInterface_reload_scene_from_path :: MethodBind
bindEditorInterface_reload_scene_from_path
  = unsafePerformIO $
      withCString "EditorInterface" $
        \ clsNamePtr ->
          withCString "reload_scene_from_path" $
            \ methodNamePtr ->
              godot_method_bind_get_method clsNamePtr methodNamePtr

-- | Reloads the scene at the given path.
reload_scene_from_path ::
                         (EditorInterface :< cls, Object :< cls) =>
                         cls -> GodotString -> IO ()
reload_scene_from_path cls arg1
  = withVariantArray [toVariant arg1]
      (\ (arrPtr, len) ->
         godot_method_bind_call bindEditorInterface_reload_scene_from_path
           (upcast cls)
           arrPtr
           len
           >>= \ (err, res) -> throwIfErr err >> fromGodotVariant res)

instance NodeMethod EditorInterface "reload_scene_from_path"
           '[GodotString]
           (IO ())
         where
        nodeMethod = Godot.Tools.EditorInterface.reload_scene_from_path

{-# NOINLINE bindEditorInterface_save_scene #-}

-- | Saves the scene. Returns either @OK@ or @ERR_CANT_CREATE@ (see @@GlobalScope@ constants).
bindEditorInterface_save_scene :: MethodBind
bindEditorInterface_save_scene
  = unsafePerformIO $
      withCString "EditorInterface" $
        \ clsNamePtr ->
          withCString "save_scene" $
            \ methodNamePtr ->
              godot_method_bind_get_method clsNamePtr methodNamePtr

-- | Saves the scene. Returns either @OK@ or @ERR_CANT_CREATE@ (see @@GlobalScope@ constants).
save_scene ::
             (EditorInterface :< cls, Object :< cls) => cls -> IO Int
save_scene cls
  = withVariantArray []
      (\ (arrPtr, len) ->
         godot_method_bind_call bindEditorInterface_save_scene (upcast cls)
           arrPtr
           len
           >>= \ (err, res) -> throwIfErr err >> fromGodotVariant res)

instance NodeMethod EditorInterface "save_scene" '[] (IO Int) where
        nodeMethod = Godot.Tools.EditorInterface.save_scene

{-# NOINLINE bindEditorInterface_save_scene_as #-}

-- | Saves the scene as a file at @path@.
bindEditorInterface_save_scene_as :: MethodBind
bindEditorInterface_save_scene_as
  = unsafePerformIO $
      withCString "EditorInterface" $
        \ clsNamePtr ->
          withCString "save_scene_as" $
            \ methodNamePtr ->
              godot_method_bind_get_method clsNamePtr methodNamePtr

-- | Saves the scene as a file at @path@.
save_scene_as ::
                (EditorInterface :< cls, Object :< cls) =>
                cls -> GodotString -> Maybe Bool -> IO ()
save_scene_as cls arg1 arg2
  = withVariantArray
      [toVariant arg1, maybe (VariantBool True) toVariant arg2]
      (\ (arrPtr, len) ->
         godot_method_bind_call bindEditorInterface_save_scene_as
           (upcast cls)
           arrPtr
           len
           >>= \ (err, res) -> throwIfErr err >> fromGodotVariant res)

instance NodeMethod EditorInterface "save_scene_as"
           '[GodotString, Maybe Bool]
           (IO ())
         where
        nodeMethod = Godot.Tools.EditorInterface.save_scene_as

{-# NOINLINE bindEditorInterface_select_file #-}

-- | Selects the file, with the path provided by @file@, in the FileSystem dock.
bindEditorInterface_select_file :: MethodBind
bindEditorInterface_select_file
  = unsafePerformIO $
      withCString "EditorInterface" $
        \ clsNamePtr ->
          withCString "select_file" $
            \ methodNamePtr ->
              godot_method_bind_get_method clsNamePtr methodNamePtr

-- | Selects the file, with the path provided by @file@, in the FileSystem dock.
select_file ::
              (EditorInterface :< cls, Object :< cls) =>
              cls -> GodotString -> IO ()
select_file cls arg1
  = withVariantArray [toVariant arg1]
      (\ (arrPtr, len) ->
         godot_method_bind_call bindEditorInterface_select_file (upcast cls)
           arrPtr
           len
           >>= \ (err, res) -> throwIfErr err >> fromGodotVariant res)

instance NodeMethod EditorInterface "select_file" '[GodotString]
           (IO ())
         where
        nodeMethod = Godot.Tools.EditorInterface.select_file

{-# NOINLINE bindEditorInterface_set_distraction_free_mode #-}

-- | If @true@, enables distraction-free mode which hides side docks to increase the space available for the main view.
bindEditorInterface_set_distraction_free_mode :: MethodBind
bindEditorInterface_set_distraction_free_mode
  = unsafePerformIO $
      withCString "EditorInterface" $
        \ clsNamePtr ->
          withCString "set_distraction_free_mode" $
            \ methodNamePtr ->
              godot_method_bind_get_method clsNamePtr methodNamePtr

-- | If @true@, enables distraction-free mode which hides side docks to increase the space available for the main view.
set_distraction_free_mode ::
                            (EditorInterface :< cls, Object :< cls) => cls -> Bool -> IO ()
set_distraction_free_mode cls arg1
  = withVariantArray [toVariant arg1]
      (\ (arrPtr, len) ->
         godot_method_bind_call
           bindEditorInterface_set_distraction_free_mode
           (upcast cls)
           arrPtr
           len
           >>= \ (err, res) -> throwIfErr err >> fromGodotVariant res)

instance NodeMethod EditorInterface "set_distraction_free_mode"
           '[Bool]
           (IO ())
         where
        nodeMethod = Godot.Tools.EditorInterface.set_distraction_free_mode

{-# NOINLINE bindEditorInterface_set_main_screen_editor #-}

-- | Sets the editor's current main screen to the one specified in @name@. @name@ must match the text of the tab in question exactly (@2D@, @3D@, @Script@, @AssetLib@).
bindEditorInterface_set_main_screen_editor :: MethodBind
bindEditorInterface_set_main_screen_editor
  = unsafePerformIO $
      withCString "EditorInterface" $
        \ clsNamePtr ->
          withCString "set_main_screen_editor" $
            \ methodNamePtr ->
              godot_method_bind_get_method clsNamePtr methodNamePtr

-- | Sets the editor's current main screen to the one specified in @name@. @name@ must match the text of the tab in question exactly (@2D@, @3D@, @Script@, @AssetLib@).
set_main_screen_editor ::
                         (EditorInterface :< cls, Object :< cls) =>
                         cls -> GodotString -> IO ()
set_main_screen_editor cls arg1
  = withVariantArray [toVariant arg1]
      (\ (arrPtr, len) ->
         godot_method_bind_call bindEditorInterface_set_main_screen_editor
           (upcast cls)
           arrPtr
           len
           >>= \ (err, res) -> throwIfErr err >> fromGodotVariant res)

instance NodeMethod EditorInterface "set_main_screen_editor"
           '[GodotString]
           (IO ())
         where
        nodeMethod = Godot.Tools.EditorInterface.set_main_screen_editor

{-# NOINLINE bindEditorInterface_set_plugin_enabled #-}

-- | Sets the enabled status of a plugin. The plugin name is the same as its directory name.
bindEditorInterface_set_plugin_enabled :: MethodBind
bindEditorInterface_set_plugin_enabled
  = unsafePerformIO $
      withCString "EditorInterface" $
        \ clsNamePtr ->
          withCString "set_plugin_enabled" $
            \ methodNamePtr ->
              godot_method_bind_get_method clsNamePtr methodNamePtr

-- | Sets the enabled status of a plugin. The plugin name is the same as its directory name.
set_plugin_enabled ::
                     (EditorInterface :< cls, Object :< cls) =>
                     cls -> GodotString -> Bool -> IO ()
set_plugin_enabled cls arg1 arg2
  = withVariantArray [toVariant arg1, toVariant arg2]
      (\ (arrPtr, len) ->
         godot_method_bind_call bindEditorInterface_set_plugin_enabled
           (upcast cls)
           arrPtr
           len
           >>= \ (err, res) -> throwIfErr err >> fromGodotVariant res)

instance NodeMethod EditorInterface "set_plugin_enabled"
           '[GodotString, Bool]
           (IO ())
         where
        nodeMethod = Godot.Tools.EditorInterface.set_plugin_enabled

{-# NOINLINE bindEditorInterface_stop_playing_scene #-}

-- | Stops the scene that is currently playing.
bindEditorInterface_stop_playing_scene :: MethodBind
bindEditorInterface_stop_playing_scene
  = unsafePerformIO $
      withCString "EditorInterface" $
        \ clsNamePtr ->
          withCString "stop_playing_scene" $
            \ methodNamePtr ->
              godot_method_bind_get_method clsNamePtr methodNamePtr

-- | Stops the scene that is currently playing.
stop_playing_scene ::
                     (EditorInterface :< cls, Object :< cls) => cls -> IO ()
stop_playing_scene cls
  = withVariantArray []
      (\ (arrPtr, len) ->
         godot_method_bind_call bindEditorInterface_stop_playing_scene
           (upcast cls)
           arrPtr
           len
           >>= \ (err, res) -> throwIfErr err >> fromGodotVariant res)

instance NodeMethod EditorInterface "stop_playing_scene" '[]
           (IO ())
         where
        nodeMethod = Godot.Tools.EditorInterface.stop_playing_scene