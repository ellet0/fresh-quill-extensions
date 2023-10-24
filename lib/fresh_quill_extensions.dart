library fresh_quill_extensions;

import 'package:flutter_quill/flutter_quill.dart';

import 'presentation/embeds/editor/image.dart';
import 'presentation/embeds/editor/image_web.dart';
import 'presentation/embeds/editor/video.dart';
import 'presentation/embeds/toolbar/camera_button.dart';
import 'presentation/embeds/toolbar/formula_button.dart';
import 'presentation/embeds/toolbar/image_button.dart';
import 'presentation/embeds/toolbar/media_button.dart';
import 'presentation/embeds/toolbar/video_button.dart';
import 'presentation/models/config/editor/image.dart';
import 'presentation/models/config/editor/video.dart';
import 'presentation/models/config/toolbar/buttons/camera.dart';
import 'presentation/models/config/toolbar/buttons/formula.dart';
import 'presentation/models/config/toolbar/buttons/image.dart';
import 'presentation/models/config/toolbar/buttons/media_button.dart';
import 'presentation/models/config/toolbar/buttons/video.dart';

export 'presentation/embeds/embed_types.dart';
export 'presentation/embeds/toolbar/camera_button.dart';
export 'presentation/embeds/toolbar/formula_button.dart';
export 'presentation/embeds/toolbar/image_button.dart';
export 'presentation/embeds/toolbar/media_button.dart';
export 'presentation/embeds/toolbar/utils/image_video_utils.dart';
export 'presentation/embeds/toolbar/video_button.dart';
export 'presentation/embeds/utils.dart';

class FlutterQuillEmbeds {
  /// Returns a list of embed builders for QuillEditor.
  ///
  /// This method provides a collection of embed builders to enhance the
  /// functionality
  /// of a QuillEditor. It offers customization options for
  /// handling various types of
  /// embedded content, such as images, videos, and formulas.
  ///
  /// **Note:** This method is not intended for web usage.
  /// For web-specific embeds,
  /// use [editorsWebBuilders].
  ///
  ///
  /// The method returns a list of [EmbedBuilder] objects that can be used with
  ///  QuillEditor
  /// to enable embedded content features like images, videos, and formulas.
  ///
  /// Example usage:
  /// ```dart
  /// final embedBuilders = QuillEmbedBuilders.builders(
  ///   onVideoInit: (videoContainerKey) {
  ///     // Custom video initialization logic
  ///   },
  ///   // Customize other callback functions as needed
  /// );
  ///
  /// final quillEditor = QuillEditor(
  ///   // Other editor configurations
  ///   embedBuilders: embedBuilders,
  /// );
  /// ```
  ///
  /// if you don't want image embed in your quill editor then please pass null
  /// to [imageEmbedConfigurations]. same apply to [videoEmbedConfigurations]
  static List<EmbedBuilder> editorBuilders({
    QuillEditorImageEmbedConfigurations? imageEmbedConfigurations =
        const QuillEditorImageEmbedConfigurations(),
    QuillEditorVideoEmbedConfigurations? videoEmbedConfigurations =
        const QuillEditorVideoEmbedConfigurations(),
  }) {
    return [
      if (imageEmbedConfigurations != null)
        QuillImageEmbedBuilder(
          configurations: QuillEditorImageEmbedConfigurations(
            imageErrorWidgetBuilder:
                imageEmbedConfigurations.imageErrorWidgetBuilder,
            imageProviderBuilder: imageEmbedConfigurations.imageProviderBuilder,
            forceUseMobileOptionMenuForImageClick:
                imageEmbedConfigurations.forceUseMobileOptionMenuForImageClick,
            onImageRemovedCallback:
                imageEmbedConfigurations.onImageRemovedCallback ??
                    QuillEditorImageEmbedConfigurations
                        .defaultOnImageRemovedCallback,
            shouldRemoveImageCallback:
                imageEmbedConfigurations.shouldRemoveImageCallback,
          ),
        ),
      if (videoEmbedConfigurations != null)
        QuillEditorVideoEmbedBuilder(
          configurations: videoEmbedConfigurations,
        ),
      const QuillEditorFormulaEmbedBuilder(),
    ];
  }

  /// Returns a list of embed builders specifically designed for web support.
  ///
  /// [ImageEmbedBuilderWeb] is the embed builder for handling
  ///  images on the web.
  ///
  static List<EmbedBuilder> editorsWebBuilders({
    QuillWebImageEmbedConfigurations? imageEmbedConfigurations =
        const QuillWebImageEmbedConfigurations(),
  }) =>
      [
        if (imageEmbedConfigurations != null) const ImageEmbedBuilderWeb(),
      ];

  /// Returns a list of embed button builders to customize the toolbar buttons.
  ///
  /// If you don't want to show one of the buttons for soem reason,
  /// pass null to the options of it
  ///
  /// Example of customizing media pick settings for the image button:
  /// ```dart
  /// mediaPickSettingSelector: (context) async {
  ///   final mediaPickSetting = await showModalBottomSheet<MediaPickSetting>(
  ///     showDragHandle: true,
  ///     context: context,
  ///     constraints: const BoxConstraints(maxWidth: 640),
  ///     builder: (context) => const SelectImageSourceDialog(),
  ///   );
  ///   if (mediaPickSetting == null) {
  ///     return null;
  ///   }
  ///   return mediaPickSetting;
  /// }
  /// ```
  ///
  ///
  /// The returned list contains embed button builders for the Quill toolbar.
  static List<EmbedButtonBuilder> toolbarButtons({
    QuillToolbarImageButtonOptions? imageButtonOptions =
        const QuillToolbarImageButtonOptions(),
    QuillToolbarVideoButtonOptions? videoButtonOptions =
        const QuillToolbarVideoButtonOptions(),
    QuillToolbarFormulaButtonOptions? formulaButtonOptions =
        const QuillToolbarFormulaButtonOptions(),
    QuillToolbarCameraButtonOptions? cameraButtonOptions,
    QuillToolbarMediaButtonOptions? mediaButtonOptions,
  }) =>
      [
        if (imageButtonOptions != null)
          (controller, toolbarIconSize, iconTheme, dialogTheme) =>
              QuillToolbarImageButton(
                controller: imageButtonOptions.controller ?? controller,
                options: imageButtonOptions,
              ),
        if (videoButtonOptions != null)
          (controller, toolbarIconSize, iconTheme, dialogTheme) =>
              QuillToolbarVideoButton(
                controller: videoButtonOptions.controller ?? controller,
                options: videoButtonOptions,
              ),
        if (cameraButtonOptions != null)
          (controller, toolbarIconSize, iconTheme, dialogTheme) =>
              QuillToolbarCameraButton(
                controller: cameraButtonOptions.controller ?? controller,
                options: cameraButtonOptions,
              ),
        if (mediaButtonOptions != null)
          (controller, toolbarIconSize, iconTheme, dialogTheme) =>
              QuillToolbarMediaButton(
                controller: mediaButtonOptions.controller ?? controller,
                options: mediaButtonOptions,
              ),
        if (formulaButtonOptions != null)
          (controller, toolbarIconSize, iconTheme, dialogTheme) =>
              QuillToolbarFormulaButton(
                controller: formulaButtonOptions.controller ?? controller,
                options: formulaButtonOptions,
              ),
      ];
}
