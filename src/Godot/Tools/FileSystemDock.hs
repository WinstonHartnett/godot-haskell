{-# LANGUAGE DerivingStrategies, GeneralizedNewtypeDeriving,
  TypeFamilies, TypeOperators, FlexibleContexts, DataKinds,
  MultiParamTypeClasses #-}
module Godot.Tools.FileSystemDock
       (Godot.Tools.FileSystemDock.sig_display_mode_changed,
        Godot.Tools.FileSystemDock.sig_file_removed,
        Godot.Tools.FileSystemDock.sig_files_moved,
        Godot.Tools.FileSystemDock.sig_folder_moved,
        Godot.Tools.FileSystemDock.sig_folder_removed,
        Godot.Tools.FileSystemDock.sig_inherit,
        Godot.Tools.FileSystemDock.sig_instance,
        Godot.Tools.FileSystemDock._bw_history,
        Godot.Tools.FileSystemDock._duplicate_operation_confirm,
        Godot.Tools.FileSystemDock._feature_profile_changed,
        Godot.Tools.FileSystemDock._file_list_activate_file,
        Godot.Tools.FileSystemDock._file_list_gui_input,
        Godot.Tools.FileSystemDock._file_list_rmb_option,
        Godot.Tools.FileSystemDock._file_list_rmb_pressed,
        Godot.Tools.FileSystemDock._file_list_rmb_select,
        Godot.Tools.FileSystemDock._file_list_thumbnail_done,
        Godot.Tools.FileSystemDock._file_multi_selected,
        Godot.Tools.FileSystemDock._file_removed,
        Godot.Tools.FileSystemDock._folder_removed,
        Godot.Tools.FileSystemDock._fs_changed,
        Godot.Tools.FileSystemDock._fw_history,
        Godot.Tools.FileSystemDock._make_dir_confirm,
        Godot.Tools.FileSystemDock._make_scene_confirm,
        Godot.Tools.FileSystemDock._move_operation_confirm,
        Godot.Tools.FileSystemDock._move_with_overwrite,
        Godot.Tools.FileSystemDock._navigate_to_path,
        Godot.Tools.FileSystemDock._preview_invalidated,
        Godot.Tools.FileSystemDock._rename_operation_confirm,
        Godot.Tools.FileSystemDock._rescan,
        Godot.Tools.FileSystemDock._resource_created,
        Godot.Tools.FileSystemDock._search_changed,
        Godot.Tools.FileSystemDock._select_file,
        Godot.Tools.FileSystemDock._toggle_file_display,
        Godot.Tools.FileSystemDock._toggle_split_mode,
        Godot.Tools.FileSystemDock._tree_activate_file,
        Godot.Tools.FileSystemDock._tree_empty_selected,
        Godot.Tools.FileSystemDock._tree_gui_input,
        Godot.Tools.FileSystemDock._tree_multi_selected,
        Godot.Tools.FileSystemDock._tree_rmb_empty,
        Godot.Tools.FileSystemDock._tree_rmb_option,
        Godot.Tools.FileSystemDock._tree_rmb_select,
        Godot.Tools.FileSystemDock._tree_thumbnail_done,
        Godot.Tools.FileSystemDock._update_import_dock,
        Godot.Tools.FileSystemDock._update_tree,
        Godot.Tools.FileSystemDock.can_drop_data_fw,
        Godot.Tools.FileSystemDock.drop_data_fw,
        Godot.Tools.FileSystemDock.get_drag_data_fw,
        Godot.Tools.FileSystemDock.navigate_to_path)
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
import Godot.Core.VBoxContainer()

sig_display_mode_changed ::
                         Godot.Internal.Dispatch.Signal FileSystemDock
sig_display_mode_changed
  = Godot.Internal.Dispatch.Signal "display_mode_changed"

instance NodeSignal FileSystemDock "display_mode_changed" '[]

sig_file_removed :: Godot.Internal.Dispatch.Signal FileSystemDock
sig_file_removed = Godot.Internal.Dispatch.Signal "file_removed"

instance NodeSignal FileSystemDock "file_removed" '[GodotString]

sig_files_moved :: Godot.Internal.Dispatch.Signal FileSystemDock
sig_files_moved = Godot.Internal.Dispatch.Signal "files_moved"

instance NodeSignal FileSystemDock "files_moved"
           '[GodotString, GodotString]

sig_folder_moved :: Godot.Internal.Dispatch.Signal FileSystemDock
sig_folder_moved = Godot.Internal.Dispatch.Signal "folder_moved"

instance NodeSignal FileSystemDock "folder_moved"
           '[GodotString, GodotString]

sig_folder_removed :: Godot.Internal.Dispatch.Signal FileSystemDock
sig_folder_removed
  = Godot.Internal.Dispatch.Signal "folder_removed"

instance NodeSignal FileSystemDock "folder_removed" '[GodotString]

sig_inherit :: Godot.Internal.Dispatch.Signal FileSystemDock
sig_inherit = Godot.Internal.Dispatch.Signal "inherit"

instance NodeSignal FileSystemDock "inherit" '[GodotString]

sig_instance :: Godot.Internal.Dispatch.Signal FileSystemDock
sig_instance = Godot.Internal.Dispatch.Signal "instance"

instance NodeSignal FileSystemDock "instance" '[PoolStringArray]

{-# NOINLINE bindFileSystemDock__bw_history #-}

bindFileSystemDock__bw_history :: MethodBind
bindFileSystemDock__bw_history
  = unsafePerformIO $
      withCString "FileSystemDock" $
        \ clsNamePtr ->
          withCString "_bw_history" $
            \ methodNamePtr ->
              godot_method_bind_get_method clsNamePtr methodNamePtr

_bw_history ::
              (FileSystemDock :< cls, Object :< cls) => cls -> IO ()
_bw_history cls
  = withVariantArray []
      (\ (arrPtr, len) ->
         godot_method_bind_call bindFileSystemDock__bw_history (upcast cls)
           arrPtr
           len
           >>= \ (err, res) -> throwIfErr err >> fromGodotVariant res)

instance NodeMethod FileSystemDock "_bw_history" '[] (IO ()) where
        nodeMethod = Godot.Tools.FileSystemDock._bw_history

{-# NOINLINE bindFileSystemDock__duplicate_operation_confirm #-}

bindFileSystemDock__duplicate_operation_confirm :: MethodBind
bindFileSystemDock__duplicate_operation_confirm
  = unsafePerformIO $
      withCString "FileSystemDock" $
        \ clsNamePtr ->
          withCString "_duplicate_operation_confirm" $
            \ methodNamePtr ->
              godot_method_bind_get_method clsNamePtr methodNamePtr

_duplicate_operation_confirm ::
                               (FileSystemDock :< cls, Object :< cls) => cls -> IO ()
_duplicate_operation_confirm cls
  = withVariantArray []
      (\ (arrPtr, len) ->
         godot_method_bind_call
           bindFileSystemDock__duplicate_operation_confirm
           (upcast cls)
           arrPtr
           len
           >>= \ (err, res) -> throwIfErr err >> fromGodotVariant res)

instance NodeMethod FileSystemDock "_duplicate_operation_confirm"
           '[]
           (IO ())
         where
        nodeMethod
          = Godot.Tools.FileSystemDock._duplicate_operation_confirm

{-# NOINLINE bindFileSystemDock__feature_profile_changed #-}

bindFileSystemDock__feature_profile_changed :: MethodBind
bindFileSystemDock__feature_profile_changed
  = unsafePerformIO $
      withCString "FileSystemDock" $
        \ clsNamePtr ->
          withCString "_feature_profile_changed" $
            \ methodNamePtr ->
              godot_method_bind_get_method clsNamePtr methodNamePtr

_feature_profile_changed ::
                           (FileSystemDock :< cls, Object :< cls) => cls -> IO ()
_feature_profile_changed cls
  = withVariantArray []
      (\ (arrPtr, len) ->
         godot_method_bind_call bindFileSystemDock__feature_profile_changed
           (upcast cls)
           arrPtr
           len
           >>= \ (err, res) -> throwIfErr err >> fromGodotVariant res)

instance NodeMethod FileSystemDock "_feature_profile_changed" '[]
           (IO ())
         where
        nodeMethod = Godot.Tools.FileSystemDock._feature_profile_changed

{-# NOINLINE bindFileSystemDock__file_list_activate_file #-}

bindFileSystemDock__file_list_activate_file :: MethodBind
bindFileSystemDock__file_list_activate_file
  = unsafePerformIO $
      withCString "FileSystemDock" $
        \ clsNamePtr ->
          withCString "_file_list_activate_file" $
            \ methodNamePtr ->
              godot_method_bind_get_method clsNamePtr methodNamePtr

_file_list_activate_file ::
                           (FileSystemDock :< cls, Object :< cls) => cls -> Int -> IO ()
_file_list_activate_file cls arg1
  = withVariantArray [toVariant arg1]
      (\ (arrPtr, len) ->
         godot_method_bind_call bindFileSystemDock__file_list_activate_file
           (upcast cls)
           arrPtr
           len
           >>= \ (err, res) -> throwIfErr err >> fromGodotVariant res)

instance NodeMethod FileSystemDock "_file_list_activate_file"
           '[Int]
           (IO ())
         where
        nodeMethod = Godot.Tools.FileSystemDock._file_list_activate_file

{-# NOINLINE bindFileSystemDock__file_list_gui_input #-}

bindFileSystemDock__file_list_gui_input :: MethodBind
bindFileSystemDock__file_list_gui_input
  = unsafePerformIO $
      withCString "FileSystemDock" $
        \ clsNamePtr ->
          withCString "_file_list_gui_input" $
            \ methodNamePtr ->
              godot_method_bind_get_method clsNamePtr methodNamePtr

_file_list_gui_input ::
                       (FileSystemDock :< cls, Object :< cls) =>
                       cls -> InputEvent -> IO ()
_file_list_gui_input cls arg1
  = withVariantArray [toVariant arg1]
      (\ (arrPtr, len) ->
         godot_method_bind_call bindFileSystemDock__file_list_gui_input
           (upcast cls)
           arrPtr
           len
           >>= \ (err, res) -> throwIfErr err >> fromGodotVariant res)

instance NodeMethod FileSystemDock "_file_list_gui_input"
           '[InputEvent]
           (IO ())
         where
        nodeMethod = Godot.Tools.FileSystemDock._file_list_gui_input

{-# NOINLINE bindFileSystemDock__file_list_rmb_option #-}

bindFileSystemDock__file_list_rmb_option :: MethodBind
bindFileSystemDock__file_list_rmb_option
  = unsafePerformIO $
      withCString "FileSystemDock" $
        \ clsNamePtr ->
          withCString "_file_list_rmb_option" $
            \ methodNamePtr ->
              godot_method_bind_get_method clsNamePtr methodNamePtr

_file_list_rmb_option ::
                        (FileSystemDock :< cls, Object :< cls) => cls -> Int -> IO ()
_file_list_rmb_option cls arg1
  = withVariantArray [toVariant arg1]
      (\ (arrPtr, len) ->
         godot_method_bind_call bindFileSystemDock__file_list_rmb_option
           (upcast cls)
           arrPtr
           len
           >>= \ (err, res) -> throwIfErr err >> fromGodotVariant res)

instance NodeMethod FileSystemDock "_file_list_rmb_option" '[Int]
           (IO ())
         where
        nodeMethod = Godot.Tools.FileSystemDock._file_list_rmb_option

{-# NOINLINE bindFileSystemDock__file_list_rmb_pressed #-}

bindFileSystemDock__file_list_rmb_pressed :: MethodBind
bindFileSystemDock__file_list_rmb_pressed
  = unsafePerformIO $
      withCString "FileSystemDock" $
        \ clsNamePtr ->
          withCString "_file_list_rmb_pressed" $
            \ methodNamePtr ->
              godot_method_bind_get_method clsNamePtr methodNamePtr

_file_list_rmb_pressed ::
                         (FileSystemDock :< cls, Object :< cls) => cls -> Vector2 -> IO ()
_file_list_rmb_pressed cls arg1
  = withVariantArray [toVariant arg1]
      (\ (arrPtr, len) ->
         godot_method_bind_call bindFileSystemDock__file_list_rmb_pressed
           (upcast cls)
           arrPtr
           len
           >>= \ (err, res) -> throwIfErr err >> fromGodotVariant res)

instance NodeMethod FileSystemDock "_file_list_rmb_pressed"
           '[Vector2]
           (IO ())
         where
        nodeMethod = Godot.Tools.FileSystemDock._file_list_rmb_pressed

{-# NOINLINE bindFileSystemDock__file_list_rmb_select #-}

bindFileSystemDock__file_list_rmb_select :: MethodBind
bindFileSystemDock__file_list_rmb_select
  = unsafePerformIO $
      withCString "FileSystemDock" $
        \ clsNamePtr ->
          withCString "_file_list_rmb_select" $
            \ methodNamePtr ->
              godot_method_bind_get_method clsNamePtr methodNamePtr

_file_list_rmb_select ::
                        (FileSystemDock :< cls, Object :< cls) =>
                        cls -> Int -> Vector2 -> IO ()
_file_list_rmb_select cls arg1 arg2
  = withVariantArray [toVariant arg1, toVariant arg2]
      (\ (arrPtr, len) ->
         godot_method_bind_call bindFileSystemDock__file_list_rmb_select
           (upcast cls)
           arrPtr
           len
           >>= \ (err, res) -> throwIfErr err >> fromGodotVariant res)

instance NodeMethod FileSystemDock "_file_list_rmb_select"
           '[Int, Vector2]
           (IO ())
         where
        nodeMethod = Godot.Tools.FileSystemDock._file_list_rmb_select

{-# NOINLINE bindFileSystemDock__file_list_thumbnail_done #-}

bindFileSystemDock__file_list_thumbnail_done :: MethodBind
bindFileSystemDock__file_list_thumbnail_done
  = unsafePerformIO $
      withCString "FileSystemDock" $
        \ clsNamePtr ->
          withCString "_file_list_thumbnail_done" $
            \ methodNamePtr ->
              godot_method_bind_get_method clsNamePtr methodNamePtr

_file_list_thumbnail_done ::
                            (FileSystemDock :< cls, Object :< cls) =>
                            cls -> GodotString -> Texture -> Texture -> GodotVariant -> IO ()
_file_list_thumbnail_done cls arg1 arg2 arg3 arg4
  = withVariantArray
      [toVariant arg1, toVariant arg2, toVariant arg3, toVariant arg4]
      (\ (arrPtr, len) ->
         godot_method_bind_call bindFileSystemDock__file_list_thumbnail_done
           (upcast cls)
           arrPtr
           len
           >>= \ (err, res) -> throwIfErr err >> fromGodotVariant res)

instance NodeMethod FileSystemDock "_file_list_thumbnail_done"
           '[GodotString, Texture, Texture, GodotVariant]
           (IO ())
         where
        nodeMethod = Godot.Tools.FileSystemDock._file_list_thumbnail_done

{-# NOINLINE bindFileSystemDock__file_multi_selected #-}

bindFileSystemDock__file_multi_selected :: MethodBind
bindFileSystemDock__file_multi_selected
  = unsafePerformIO $
      withCString "FileSystemDock" $
        \ clsNamePtr ->
          withCString "_file_multi_selected" $
            \ methodNamePtr ->
              godot_method_bind_get_method clsNamePtr methodNamePtr

_file_multi_selected ::
                       (FileSystemDock :< cls, Object :< cls) =>
                       cls -> Int -> Bool -> IO ()
_file_multi_selected cls arg1 arg2
  = withVariantArray [toVariant arg1, toVariant arg2]
      (\ (arrPtr, len) ->
         godot_method_bind_call bindFileSystemDock__file_multi_selected
           (upcast cls)
           arrPtr
           len
           >>= \ (err, res) -> throwIfErr err >> fromGodotVariant res)

instance NodeMethod FileSystemDock "_file_multi_selected"
           '[Int, Bool]
           (IO ())
         where
        nodeMethod = Godot.Tools.FileSystemDock._file_multi_selected

{-# NOINLINE bindFileSystemDock__file_removed #-}

bindFileSystemDock__file_removed :: MethodBind
bindFileSystemDock__file_removed
  = unsafePerformIO $
      withCString "FileSystemDock" $
        \ clsNamePtr ->
          withCString "_file_removed" $
            \ methodNamePtr ->
              godot_method_bind_get_method clsNamePtr methodNamePtr

_file_removed ::
                (FileSystemDock :< cls, Object :< cls) =>
                cls -> GodotString -> IO ()
_file_removed cls arg1
  = withVariantArray [toVariant arg1]
      (\ (arrPtr, len) ->
         godot_method_bind_call bindFileSystemDock__file_removed
           (upcast cls)
           arrPtr
           len
           >>= \ (err, res) -> throwIfErr err >> fromGodotVariant res)

instance NodeMethod FileSystemDock "_file_removed" '[GodotString]
           (IO ())
         where
        nodeMethod = Godot.Tools.FileSystemDock._file_removed

{-# NOINLINE bindFileSystemDock__folder_removed #-}

bindFileSystemDock__folder_removed :: MethodBind
bindFileSystemDock__folder_removed
  = unsafePerformIO $
      withCString "FileSystemDock" $
        \ clsNamePtr ->
          withCString "_folder_removed" $
            \ methodNamePtr ->
              godot_method_bind_get_method clsNamePtr methodNamePtr

_folder_removed ::
                  (FileSystemDock :< cls, Object :< cls) =>
                  cls -> GodotString -> IO ()
_folder_removed cls arg1
  = withVariantArray [toVariant arg1]
      (\ (arrPtr, len) ->
         godot_method_bind_call bindFileSystemDock__folder_removed
           (upcast cls)
           arrPtr
           len
           >>= \ (err, res) -> throwIfErr err >> fromGodotVariant res)

instance NodeMethod FileSystemDock "_folder_removed" '[GodotString]
           (IO ())
         where
        nodeMethod = Godot.Tools.FileSystemDock._folder_removed

{-# NOINLINE bindFileSystemDock__fs_changed #-}

bindFileSystemDock__fs_changed :: MethodBind
bindFileSystemDock__fs_changed
  = unsafePerformIO $
      withCString "FileSystemDock" $
        \ clsNamePtr ->
          withCString "_fs_changed" $
            \ methodNamePtr ->
              godot_method_bind_get_method clsNamePtr methodNamePtr

_fs_changed ::
              (FileSystemDock :< cls, Object :< cls) => cls -> IO ()
_fs_changed cls
  = withVariantArray []
      (\ (arrPtr, len) ->
         godot_method_bind_call bindFileSystemDock__fs_changed (upcast cls)
           arrPtr
           len
           >>= \ (err, res) -> throwIfErr err >> fromGodotVariant res)

instance NodeMethod FileSystemDock "_fs_changed" '[] (IO ()) where
        nodeMethod = Godot.Tools.FileSystemDock._fs_changed

{-# NOINLINE bindFileSystemDock__fw_history #-}

bindFileSystemDock__fw_history :: MethodBind
bindFileSystemDock__fw_history
  = unsafePerformIO $
      withCString "FileSystemDock" $
        \ clsNamePtr ->
          withCString "_fw_history" $
            \ methodNamePtr ->
              godot_method_bind_get_method clsNamePtr methodNamePtr

_fw_history ::
              (FileSystemDock :< cls, Object :< cls) => cls -> IO ()
_fw_history cls
  = withVariantArray []
      (\ (arrPtr, len) ->
         godot_method_bind_call bindFileSystemDock__fw_history (upcast cls)
           arrPtr
           len
           >>= \ (err, res) -> throwIfErr err >> fromGodotVariant res)

instance NodeMethod FileSystemDock "_fw_history" '[] (IO ()) where
        nodeMethod = Godot.Tools.FileSystemDock._fw_history

{-# NOINLINE bindFileSystemDock__make_dir_confirm #-}

bindFileSystemDock__make_dir_confirm :: MethodBind
bindFileSystemDock__make_dir_confirm
  = unsafePerformIO $
      withCString "FileSystemDock" $
        \ clsNamePtr ->
          withCString "_make_dir_confirm" $
            \ methodNamePtr ->
              godot_method_bind_get_method clsNamePtr methodNamePtr

_make_dir_confirm ::
                    (FileSystemDock :< cls, Object :< cls) => cls -> IO ()
_make_dir_confirm cls
  = withVariantArray []
      (\ (arrPtr, len) ->
         godot_method_bind_call bindFileSystemDock__make_dir_confirm
           (upcast cls)
           arrPtr
           len
           >>= \ (err, res) -> throwIfErr err >> fromGodotVariant res)

instance NodeMethod FileSystemDock "_make_dir_confirm" '[] (IO ())
         where
        nodeMethod = Godot.Tools.FileSystemDock._make_dir_confirm

{-# NOINLINE bindFileSystemDock__make_scene_confirm #-}

bindFileSystemDock__make_scene_confirm :: MethodBind
bindFileSystemDock__make_scene_confirm
  = unsafePerformIO $
      withCString "FileSystemDock" $
        \ clsNamePtr ->
          withCString "_make_scene_confirm" $
            \ methodNamePtr ->
              godot_method_bind_get_method clsNamePtr methodNamePtr

_make_scene_confirm ::
                      (FileSystemDock :< cls, Object :< cls) => cls -> IO ()
_make_scene_confirm cls
  = withVariantArray []
      (\ (arrPtr, len) ->
         godot_method_bind_call bindFileSystemDock__make_scene_confirm
           (upcast cls)
           arrPtr
           len
           >>= \ (err, res) -> throwIfErr err >> fromGodotVariant res)

instance NodeMethod FileSystemDock "_make_scene_confirm" '[]
           (IO ())
         where
        nodeMethod = Godot.Tools.FileSystemDock._make_scene_confirm

{-# NOINLINE bindFileSystemDock__move_operation_confirm #-}

bindFileSystemDock__move_operation_confirm :: MethodBind
bindFileSystemDock__move_operation_confirm
  = unsafePerformIO $
      withCString "FileSystemDock" $
        \ clsNamePtr ->
          withCString "_move_operation_confirm" $
            \ methodNamePtr ->
              godot_method_bind_get_method clsNamePtr methodNamePtr

_move_operation_confirm ::
                          (FileSystemDock :< cls, Object :< cls) =>
                          cls -> GodotString -> Maybe Bool -> IO ()
_move_operation_confirm cls arg1 arg2
  = withVariantArray
      [toVariant arg1, maybe (VariantBool False) toVariant arg2]
      (\ (arrPtr, len) ->
         godot_method_bind_call bindFileSystemDock__move_operation_confirm
           (upcast cls)
           arrPtr
           len
           >>= \ (err, res) -> throwIfErr err >> fromGodotVariant res)

instance NodeMethod FileSystemDock "_move_operation_confirm"
           '[GodotString, Maybe Bool]
           (IO ())
         where
        nodeMethod = Godot.Tools.FileSystemDock._move_operation_confirm

{-# NOINLINE bindFileSystemDock__move_with_overwrite #-}

bindFileSystemDock__move_with_overwrite :: MethodBind
bindFileSystemDock__move_with_overwrite
  = unsafePerformIO $
      withCString "FileSystemDock" $
        \ clsNamePtr ->
          withCString "_move_with_overwrite" $
            \ methodNamePtr ->
              godot_method_bind_get_method clsNamePtr methodNamePtr

_move_with_overwrite ::
                       (FileSystemDock :< cls, Object :< cls) => cls -> IO ()
_move_with_overwrite cls
  = withVariantArray []
      (\ (arrPtr, len) ->
         godot_method_bind_call bindFileSystemDock__move_with_overwrite
           (upcast cls)
           arrPtr
           len
           >>= \ (err, res) -> throwIfErr err >> fromGodotVariant res)

instance NodeMethod FileSystemDock "_move_with_overwrite" '[]
           (IO ())
         where
        nodeMethod = Godot.Tools.FileSystemDock._move_with_overwrite

{-# NOINLINE bindFileSystemDock__navigate_to_path #-}

bindFileSystemDock__navigate_to_path :: MethodBind
bindFileSystemDock__navigate_to_path
  = unsafePerformIO $
      withCString "FileSystemDock" $
        \ clsNamePtr ->
          withCString "_navigate_to_path" $
            \ methodNamePtr ->
              godot_method_bind_get_method clsNamePtr methodNamePtr

_navigate_to_path ::
                    (FileSystemDock :< cls, Object :< cls) =>
                    cls -> GodotString -> Maybe Bool -> IO ()
_navigate_to_path cls arg1 arg2
  = withVariantArray
      [toVariant arg1, maybe (VariantBool False) toVariant arg2]
      (\ (arrPtr, len) ->
         godot_method_bind_call bindFileSystemDock__navigate_to_path
           (upcast cls)
           arrPtr
           len
           >>= \ (err, res) -> throwIfErr err >> fromGodotVariant res)

instance NodeMethod FileSystemDock "_navigate_to_path"
           '[GodotString, Maybe Bool]
           (IO ())
         where
        nodeMethod = Godot.Tools.FileSystemDock._navigate_to_path

{-# NOINLINE bindFileSystemDock__preview_invalidated #-}

bindFileSystemDock__preview_invalidated :: MethodBind
bindFileSystemDock__preview_invalidated
  = unsafePerformIO $
      withCString "FileSystemDock" $
        \ clsNamePtr ->
          withCString "_preview_invalidated" $
            \ methodNamePtr ->
              godot_method_bind_get_method clsNamePtr methodNamePtr

_preview_invalidated ::
                       (FileSystemDock :< cls, Object :< cls) =>
                       cls -> GodotString -> IO ()
_preview_invalidated cls arg1
  = withVariantArray [toVariant arg1]
      (\ (arrPtr, len) ->
         godot_method_bind_call bindFileSystemDock__preview_invalidated
           (upcast cls)
           arrPtr
           len
           >>= \ (err, res) -> throwIfErr err >> fromGodotVariant res)

instance NodeMethod FileSystemDock "_preview_invalidated"
           '[GodotString]
           (IO ())
         where
        nodeMethod = Godot.Tools.FileSystemDock._preview_invalidated

{-# NOINLINE bindFileSystemDock__rename_operation_confirm #-}

bindFileSystemDock__rename_operation_confirm :: MethodBind
bindFileSystemDock__rename_operation_confirm
  = unsafePerformIO $
      withCString "FileSystemDock" $
        \ clsNamePtr ->
          withCString "_rename_operation_confirm" $
            \ methodNamePtr ->
              godot_method_bind_get_method clsNamePtr methodNamePtr

_rename_operation_confirm ::
                            (FileSystemDock :< cls, Object :< cls) => cls -> IO ()
_rename_operation_confirm cls
  = withVariantArray []
      (\ (arrPtr, len) ->
         godot_method_bind_call bindFileSystemDock__rename_operation_confirm
           (upcast cls)
           arrPtr
           len
           >>= \ (err, res) -> throwIfErr err >> fromGodotVariant res)

instance NodeMethod FileSystemDock "_rename_operation_confirm" '[]
           (IO ())
         where
        nodeMethod = Godot.Tools.FileSystemDock._rename_operation_confirm

{-# NOINLINE bindFileSystemDock__rescan #-}

bindFileSystemDock__rescan :: MethodBind
bindFileSystemDock__rescan
  = unsafePerformIO $
      withCString "FileSystemDock" $
        \ clsNamePtr ->
          withCString "_rescan" $
            \ methodNamePtr ->
              godot_method_bind_get_method clsNamePtr methodNamePtr

_rescan :: (FileSystemDock :< cls, Object :< cls) => cls -> IO ()
_rescan cls
  = withVariantArray []
      (\ (arrPtr, len) ->
         godot_method_bind_call bindFileSystemDock__rescan (upcast cls)
           arrPtr
           len
           >>= \ (err, res) -> throwIfErr err >> fromGodotVariant res)

instance NodeMethod FileSystemDock "_rescan" '[] (IO ()) where
        nodeMethod = Godot.Tools.FileSystemDock._rescan

{-# NOINLINE bindFileSystemDock__resource_created #-}

bindFileSystemDock__resource_created :: MethodBind
bindFileSystemDock__resource_created
  = unsafePerformIO $
      withCString "FileSystemDock" $
        \ clsNamePtr ->
          withCString "_resource_created" $
            \ methodNamePtr ->
              godot_method_bind_get_method clsNamePtr methodNamePtr

_resource_created ::
                    (FileSystemDock :< cls, Object :< cls) => cls -> IO ()
_resource_created cls
  = withVariantArray []
      (\ (arrPtr, len) ->
         godot_method_bind_call bindFileSystemDock__resource_created
           (upcast cls)
           arrPtr
           len
           >>= \ (err, res) -> throwIfErr err >> fromGodotVariant res)

instance NodeMethod FileSystemDock "_resource_created" '[] (IO ())
         where
        nodeMethod = Godot.Tools.FileSystemDock._resource_created

{-# NOINLINE bindFileSystemDock__search_changed #-}

bindFileSystemDock__search_changed :: MethodBind
bindFileSystemDock__search_changed
  = unsafePerformIO $
      withCString "FileSystemDock" $
        \ clsNamePtr ->
          withCString "_search_changed" $
            \ methodNamePtr ->
              godot_method_bind_get_method clsNamePtr methodNamePtr

_search_changed ::
                  (FileSystemDock :< cls, Object :< cls) =>
                  cls -> GodotString -> Control -> IO ()
_search_changed cls arg1 arg2
  = withVariantArray [toVariant arg1, toVariant arg2]
      (\ (arrPtr, len) ->
         godot_method_bind_call bindFileSystemDock__search_changed
           (upcast cls)
           arrPtr
           len
           >>= \ (err, res) -> throwIfErr err >> fromGodotVariant res)

instance NodeMethod FileSystemDock "_search_changed"
           '[GodotString, Control]
           (IO ())
         where
        nodeMethod = Godot.Tools.FileSystemDock._search_changed

{-# NOINLINE bindFileSystemDock__select_file #-}

bindFileSystemDock__select_file :: MethodBind
bindFileSystemDock__select_file
  = unsafePerformIO $
      withCString "FileSystemDock" $
        \ clsNamePtr ->
          withCString "_select_file" $
            \ methodNamePtr ->
              godot_method_bind_get_method clsNamePtr methodNamePtr

_select_file ::
               (FileSystemDock :< cls, Object :< cls) =>
               cls -> GodotString -> Bool -> IO ()
_select_file cls arg1 arg2
  = withVariantArray [toVariant arg1, toVariant arg2]
      (\ (arrPtr, len) ->
         godot_method_bind_call bindFileSystemDock__select_file (upcast cls)
           arrPtr
           len
           >>= \ (err, res) -> throwIfErr err >> fromGodotVariant res)

instance NodeMethod FileSystemDock "_select_file"
           '[GodotString, Bool]
           (IO ())
         where
        nodeMethod = Godot.Tools.FileSystemDock._select_file

{-# NOINLINE bindFileSystemDock__toggle_file_display #-}

bindFileSystemDock__toggle_file_display :: MethodBind
bindFileSystemDock__toggle_file_display
  = unsafePerformIO $
      withCString "FileSystemDock" $
        \ clsNamePtr ->
          withCString "_toggle_file_display" $
            \ methodNamePtr ->
              godot_method_bind_get_method clsNamePtr methodNamePtr

_toggle_file_display ::
                       (FileSystemDock :< cls, Object :< cls) => cls -> IO ()
_toggle_file_display cls
  = withVariantArray []
      (\ (arrPtr, len) ->
         godot_method_bind_call bindFileSystemDock__toggle_file_display
           (upcast cls)
           arrPtr
           len
           >>= \ (err, res) -> throwIfErr err >> fromGodotVariant res)

instance NodeMethod FileSystemDock "_toggle_file_display" '[]
           (IO ())
         where
        nodeMethod = Godot.Tools.FileSystemDock._toggle_file_display

{-# NOINLINE bindFileSystemDock__toggle_split_mode #-}

bindFileSystemDock__toggle_split_mode :: MethodBind
bindFileSystemDock__toggle_split_mode
  = unsafePerformIO $
      withCString "FileSystemDock" $
        \ clsNamePtr ->
          withCString "_toggle_split_mode" $
            \ methodNamePtr ->
              godot_method_bind_get_method clsNamePtr methodNamePtr

_toggle_split_mode ::
                     (FileSystemDock :< cls, Object :< cls) => cls -> Bool -> IO ()
_toggle_split_mode cls arg1
  = withVariantArray [toVariant arg1]
      (\ (arrPtr, len) ->
         godot_method_bind_call bindFileSystemDock__toggle_split_mode
           (upcast cls)
           arrPtr
           len
           >>= \ (err, res) -> throwIfErr err >> fromGodotVariant res)

instance NodeMethod FileSystemDock "_toggle_split_mode" '[Bool]
           (IO ())
         where
        nodeMethod = Godot.Tools.FileSystemDock._toggle_split_mode

{-# NOINLINE bindFileSystemDock__tree_activate_file #-}

bindFileSystemDock__tree_activate_file :: MethodBind
bindFileSystemDock__tree_activate_file
  = unsafePerformIO $
      withCString "FileSystemDock" $
        \ clsNamePtr ->
          withCString "_tree_activate_file" $
            \ methodNamePtr ->
              godot_method_bind_get_method clsNamePtr methodNamePtr

_tree_activate_file ::
                      (FileSystemDock :< cls, Object :< cls) => cls -> IO ()
_tree_activate_file cls
  = withVariantArray []
      (\ (arrPtr, len) ->
         godot_method_bind_call bindFileSystemDock__tree_activate_file
           (upcast cls)
           arrPtr
           len
           >>= \ (err, res) -> throwIfErr err >> fromGodotVariant res)

instance NodeMethod FileSystemDock "_tree_activate_file" '[]
           (IO ())
         where
        nodeMethod = Godot.Tools.FileSystemDock._tree_activate_file

{-# NOINLINE bindFileSystemDock__tree_empty_selected #-}

bindFileSystemDock__tree_empty_selected :: MethodBind
bindFileSystemDock__tree_empty_selected
  = unsafePerformIO $
      withCString "FileSystemDock" $
        \ clsNamePtr ->
          withCString "_tree_empty_selected" $
            \ methodNamePtr ->
              godot_method_bind_get_method clsNamePtr methodNamePtr

_tree_empty_selected ::
                       (FileSystemDock :< cls, Object :< cls) => cls -> IO ()
_tree_empty_selected cls
  = withVariantArray []
      (\ (arrPtr, len) ->
         godot_method_bind_call bindFileSystemDock__tree_empty_selected
           (upcast cls)
           arrPtr
           len
           >>= \ (err, res) -> throwIfErr err >> fromGodotVariant res)

instance NodeMethod FileSystemDock "_tree_empty_selected" '[]
           (IO ())
         where
        nodeMethod = Godot.Tools.FileSystemDock._tree_empty_selected

{-# NOINLINE bindFileSystemDock__tree_gui_input #-}

bindFileSystemDock__tree_gui_input :: MethodBind
bindFileSystemDock__tree_gui_input
  = unsafePerformIO $
      withCString "FileSystemDock" $
        \ clsNamePtr ->
          withCString "_tree_gui_input" $
            \ methodNamePtr ->
              godot_method_bind_get_method clsNamePtr methodNamePtr

_tree_gui_input ::
                  (FileSystemDock :< cls, Object :< cls) =>
                  cls -> InputEvent -> IO ()
_tree_gui_input cls arg1
  = withVariantArray [toVariant arg1]
      (\ (arrPtr, len) ->
         godot_method_bind_call bindFileSystemDock__tree_gui_input
           (upcast cls)
           arrPtr
           len
           >>= \ (err, res) -> throwIfErr err >> fromGodotVariant res)

instance NodeMethod FileSystemDock "_tree_gui_input" '[InputEvent]
           (IO ())
         where
        nodeMethod = Godot.Tools.FileSystemDock._tree_gui_input

{-# NOINLINE bindFileSystemDock__tree_multi_selected #-}

bindFileSystemDock__tree_multi_selected :: MethodBind
bindFileSystemDock__tree_multi_selected
  = unsafePerformIO $
      withCString "FileSystemDock" $
        \ clsNamePtr ->
          withCString "_tree_multi_selected" $
            \ methodNamePtr ->
              godot_method_bind_get_method clsNamePtr methodNamePtr

_tree_multi_selected ::
                       (FileSystemDock :< cls, Object :< cls) =>
                       cls -> Object -> Int -> Bool -> IO ()
_tree_multi_selected cls arg1 arg2 arg3
  = withVariantArray [toVariant arg1, toVariant arg2, toVariant arg3]
      (\ (arrPtr, len) ->
         godot_method_bind_call bindFileSystemDock__tree_multi_selected
           (upcast cls)
           arrPtr
           len
           >>= \ (err, res) -> throwIfErr err >> fromGodotVariant res)

instance NodeMethod FileSystemDock "_tree_multi_selected"
           '[Object, Int, Bool]
           (IO ())
         where
        nodeMethod = Godot.Tools.FileSystemDock._tree_multi_selected

{-# NOINLINE bindFileSystemDock__tree_rmb_empty #-}

bindFileSystemDock__tree_rmb_empty :: MethodBind
bindFileSystemDock__tree_rmb_empty
  = unsafePerformIO $
      withCString "FileSystemDock" $
        \ clsNamePtr ->
          withCString "_tree_rmb_empty" $
            \ methodNamePtr ->
              godot_method_bind_get_method clsNamePtr methodNamePtr

_tree_rmb_empty ::
                  (FileSystemDock :< cls, Object :< cls) => cls -> Vector2 -> IO ()
_tree_rmb_empty cls arg1
  = withVariantArray [toVariant arg1]
      (\ (arrPtr, len) ->
         godot_method_bind_call bindFileSystemDock__tree_rmb_empty
           (upcast cls)
           arrPtr
           len
           >>= \ (err, res) -> throwIfErr err >> fromGodotVariant res)

instance NodeMethod FileSystemDock "_tree_rmb_empty" '[Vector2]
           (IO ())
         where
        nodeMethod = Godot.Tools.FileSystemDock._tree_rmb_empty

{-# NOINLINE bindFileSystemDock__tree_rmb_option #-}

bindFileSystemDock__tree_rmb_option :: MethodBind
bindFileSystemDock__tree_rmb_option
  = unsafePerformIO $
      withCString "FileSystemDock" $
        \ clsNamePtr ->
          withCString "_tree_rmb_option" $
            \ methodNamePtr ->
              godot_method_bind_get_method clsNamePtr methodNamePtr

_tree_rmb_option ::
                   (FileSystemDock :< cls, Object :< cls) => cls -> Int -> IO ()
_tree_rmb_option cls arg1
  = withVariantArray [toVariant arg1]
      (\ (arrPtr, len) ->
         godot_method_bind_call bindFileSystemDock__tree_rmb_option
           (upcast cls)
           arrPtr
           len
           >>= \ (err, res) -> throwIfErr err >> fromGodotVariant res)

instance NodeMethod FileSystemDock "_tree_rmb_option" '[Int]
           (IO ())
         where
        nodeMethod = Godot.Tools.FileSystemDock._tree_rmb_option

{-# NOINLINE bindFileSystemDock__tree_rmb_select #-}

bindFileSystemDock__tree_rmb_select :: MethodBind
bindFileSystemDock__tree_rmb_select
  = unsafePerformIO $
      withCString "FileSystemDock" $
        \ clsNamePtr ->
          withCString "_tree_rmb_select" $
            \ methodNamePtr ->
              godot_method_bind_get_method clsNamePtr methodNamePtr

_tree_rmb_select ::
                   (FileSystemDock :< cls, Object :< cls) => cls -> Vector2 -> IO ()
_tree_rmb_select cls arg1
  = withVariantArray [toVariant arg1]
      (\ (arrPtr, len) ->
         godot_method_bind_call bindFileSystemDock__tree_rmb_select
           (upcast cls)
           arrPtr
           len
           >>= \ (err, res) -> throwIfErr err >> fromGodotVariant res)

instance NodeMethod FileSystemDock "_tree_rmb_select" '[Vector2]
           (IO ())
         where
        nodeMethod = Godot.Tools.FileSystemDock._tree_rmb_select

{-# NOINLINE bindFileSystemDock__tree_thumbnail_done #-}

bindFileSystemDock__tree_thumbnail_done :: MethodBind
bindFileSystemDock__tree_thumbnail_done
  = unsafePerformIO $
      withCString "FileSystemDock" $
        \ clsNamePtr ->
          withCString "_tree_thumbnail_done" $
            \ methodNamePtr ->
              godot_method_bind_get_method clsNamePtr methodNamePtr

_tree_thumbnail_done ::
                       (FileSystemDock :< cls, Object :< cls) =>
                       cls -> GodotString -> Texture -> Texture -> GodotVariant -> IO ()
_tree_thumbnail_done cls arg1 arg2 arg3 arg4
  = withVariantArray
      [toVariant arg1, toVariant arg2, toVariant arg3, toVariant arg4]
      (\ (arrPtr, len) ->
         godot_method_bind_call bindFileSystemDock__tree_thumbnail_done
           (upcast cls)
           arrPtr
           len
           >>= \ (err, res) -> throwIfErr err >> fromGodotVariant res)

instance NodeMethod FileSystemDock "_tree_thumbnail_done"
           '[GodotString, Texture, Texture, GodotVariant]
           (IO ())
         where
        nodeMethod = Godot.Tools.FileSystemDock._tree_thumbnail_done

{-# NOINLINE bindFileSystemDock__update_import_dock #-}

bindFileSystemDock__update_import_dock :: MethodBind
bindFileSystemDock__update_import_dock
  = unsafePerformIO $
      withCString "FileSystemDock" $
        \ clsNamePtr ->
          withCString "_update_import_dock" $
            \ methodNamePtr ->
              godot_method_bind_get_method clsNamePtr methodNamePtr

_update_import_dock ::
                      (FileSystemDock :< cls, Object :< cls) => cls -> IO ()
_update_import_dock cls
  = withVariantArray []
      (\ (arrPtr, len) ->
         godot_method_bind_call bindFileSystemDock__update_import_dock
           (upcast cls)
           arrPtr
           len
           >>= \ (err, res) -> throwIfErr err >> fromGodotVariant res)

instance NodeMethod FileSystemDock "_update_import_dock" '[]
           (IO ())
         where
        nodeMethod = Godot.Tools.FileSystemDock._update_import_dock

{-# NOINLINE bindFileSystemDock__update_tree #-}

bindFileSystemDock__update_tree :: MethodBind
bindFileSystemDock__update_tree
  = unsafePerformIO $
      withCString "FileSystemDock" $
        \ clsNamePtr ->
          withCString "_update_tree" $
            \ methodNamePtr ->
              godot_method_bind_get_method clsNamePtr methodNamePtr

_update_tree ::
               (FileSystemDock :< cls, Object :< cls) =>
               cls -> PoolStringArray -> Bool -> Bool -> Bool -> IO ()
_update_tree cls arg1 arg2 arg3 arg4
  = withVariantArray
      [toVariant arg1, toVariant arg2, toVariant arg3, toVariant arg4]
      (\ (arrPtr, len) ->
         godot_method_bind_call bindFileSystemDock__update_tree (upcast cls)
           arrPtr
           len
           >>= \ (err, res) -> throwIfErr err >> fromGodotVariant res)

instance NodeMethod FileSystemDock "_update_tree"
           '[PoolStringArray, Bool, Bool, Bool]
           (IO ())
         where
        nodeMethod = Godot.Tools.FileSystemDock._update_tree

{-# NOINLINE bindFileSystemDock_can_drop_data_fw #-}

bindFileSystemDock_can_drop_data_fw :: MethodBind
bindFileSystemDock_can_drop_data_fw
  = unsafePerformIO $
      withCString "FileSystemDock" $
        \ clsNamePtr ->
          withCString "can_drop_data_fw" $
            \ methodNamePtr ->
              godot_method_bind_get_method clsNamePtr methodNamePtr

can_drop_data_fw ::
                   (FileSystemDock :< cls, Object :< cls) =>
                   cls -> Vector2 -> GodotVariant -> Control -> IO Bool
can_drop_data_fw cls arg1 arg2 arg3
  = withVariantArray [toVariant arg1, toVariant arg2, toVariant arg3]
      (\ (arrPtr, len) ->
         godot_method_bind_call bindFileSystemDock_can_drop_data_fw
           (upcast cls)
           arrPtr
           len
           >>= \ (err, res) -> throwIfErr err >> fromGodotVariant res)

instance NodeMethod FileSystemDock "can_drop_data_fw"
           '[Vector2, GodotVariant, Control]
           (IO Bool)
         where
        nodeMethod = Godot.Tools.FileSystemDock.can_drop_data_fw

{-# NOINLINE bindFileSystemDock_drop_data_fw #-}

bindFileSystemDock_drop_data_fw :: MethodBind
bindFileSystemDock_drop_data_fw
  = unsafePerformIO $
      withCString "FileSystemDock" $
        \ clsNamePtr ->
          withCString "drop_data_fw" $
            \ methodNamePtr ->
              godot_method_bind_get_method clsNamePtr methodNamePtr

drop_data_fw ::
               (FileSystemDock :< cls, Object :< cls) =>
               cls -> Vector2 -> GodotVariant -> Control -> IO ()
drop_data_fw cls arg1 arg2 arg3
  = withVariantArray [toVariant arg1, toVariant arg2, toVariant arg3]
      (\ (arrPtr, len) ->
         godot_method_bind_call bindFileSystemDock_drop_data_fw (upcast cls)
           arrPtr
           len
           >>= \ (err, res) -> throwIfErr err >> fromGodotVariant res)

instance NodeMethod FileSystemDock "drop_data_fw"
           '[Vector2, GodotVariant, Control]
           (IO ())
         where
        nodeMethod = Godot.Tools.FileSystemDock.drop_data_fw

{-# NOINLINE bindFileSystemDock_get_drag_data_fw #-}

bindFileSystemDock_get_drag_data_fw :: MethodBind
bindFileSystemDock_get_drag_data_fw
  = unsafePerformIO $
      withCString "FileSystemDock" $
        \ clsNamePtr ->
          withCString "get_drag_data_fw" $
            \ methodNamePtr ->
              godot_method_bind_get_method clsNamePtr methodNamePtr

get_drag_data_fw ::
                   (FileSystemDock :< cls, Object :< cls) =>
                   cls -> Vector2 -> Control -> IO GodotVariant
get_drag_data_fw cls arg1 arg2
  = withVariantArray [toVariant arg1, toVariant arg2]
      (\ (arrPtr, len) ->
         godot_method_bind_call bindFileSystemDock_get_drag_data_fw
           (upcast cls)
           arrPtr
           len
           >>= \ (err, res) -> throwIfErr err >> fromGodotVariant res)

instance NodeMethod FileSystemDock "get_drag_data_fw"
           '[Vector2, Control]
           (IO GodotVariant)
         where
        nodeMethod = Godot.Tools.FileSystemDock.get_drag_data_fw

{-# NOINLINE bindFileSystemDock_navigate_to_path #-}

bindFileSystemDock_navigate_to_path :: MethodBind
bindFileSystemDock_navigate_to_path
  = unsafePerformIO $
      withCString "FileSystemDock" $
        \ clsNamePtr ->
          withCString "navigate_to_path" $
            \ methodNamePtr ->
              godot_method_bind_get_method clsNamePtr methodNamePtr

navigate_to_path ::
                   (FileSystemDock :< cls, Object :< cls) =>
                   cls -> GodotString -> IO ()
navigate_to_path cls arg1
  = withVariantArray [toVariant arg1]
      (\ (arrPtr, len) ->
         godot_method_bind_call bindFileSystemDock_navigate_to_path
           (upcast cls)
           arrPtr
           len
           >>= \ (err, res) -> throwIfErr err >> fromGodotVariant res)

instance NodeMethod FileSystemDock "navigate_to_path"
           '[GodotString]
           (IO ())
         where
        nodeMethod = Godot.Tools.FileSystemDock.navigate_to_path