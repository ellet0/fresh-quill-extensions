# Flutter Quill Extensions

A extensions for [flutter_quill](https://pub.dev/packages/flutter_quill)
to support embed widgets like image, formula, video and more.

Currently the support for **Web** is limitied.

 Check [Flutter Quill](https://github.com/singerdmx/flutter-quill) for details of use.


## Installation

Before start using this package, please make sure to install
[flutter_quill_extensions](https://github.com/singerdmx/flutter-quill) package first and follow it's usage instructions.

```yaml
dependencies:
  fresh_quill_extensions: ^<latest-version-here>
```

<p align="center">OR</p>

```yaml
dependencies:
  fresh_quill_extensions:
    git: https://github.com/freshtechtips/fresh-quill-extensions.git
```

## Platform spesefic configurations

>
> 1. We are using [`gal`](https://github.com/natsuk4ze/) plugin to save images.
> For this to work, you need to add the appropriate permissions
> to your `Info.plist` and `AndroidManifest.xml` files.
> See <https://github.com/natsuk4ze/gal#-get-started> to add the needed lines.
>
> 2. We also use [`image_picker`](https://pub.dev/packages/image_picker) plugin for picking images so please make sure follow the instructions
>
> 3. For loading the image from the internet we need internet permission
>    1. For Android, you need to add some permissions in `AndroidManifest.xml`, Please follow this [link](https://developer.android.com/training/basics/network-ops/connecting) for more info, the internet permission included by default only for debugging so you need to follow this link to add it in the release version too. you should allow loading images and videos only for the `https` protocol but if you want http too then you need to configure your android application to accept `http` in the release mode, follow this [link](https://stackoverflow.com/questions/45940861/android-8-cleartext-http-traffic-not-permitted) for more info.
>    2. for macOS you also need to include a key in your `Info.plist`, please follow this [link](https://stackoverflow.com/a/61201081/18519412) to add the required configurations
>
> The extensions package also use [image_picker](https://pub.dev/packages/image_picker) which also require some configurations, follow this [link](https://pub.dev/packages/image_picker#installation). It's needed for Android, iOS, macOS, we must inform you that you can't pick photo using camera in desktop so make sure to handle that if you plan on add support for desktop, this might changed in the future and for more info follow this [link](https://pub.dev/packages/image_picker#windows-macos-and-linux) <br>
> 

## Usage

Before starting using this package you must follow the setup

Set the `embedBuilders` and `embedToolbar` params in configurations of `QuillEditor` and `QuillToolbar` with the
values provided by this repository.

```dart
QuillToolbar(
  configurations: QuillToolbarConfigurations(
    embedButtons: FlutterQuillEmbeds.toolbarButtons(
      imageButtonOptions: QuillToolbarImageButtonOptions(
        onImagePickCallback: (file) async {
          return file.path;
        },
      ),
    ),
  ),
),
```

```dart
Expanded(
  child: QuillEditor.basic(
    configurations: QuillEditorConfigurations(
      readOnly: true,
      embedBuilders: FlutterQuillEmbeds.editorBuilders(
        imageEmbedConfigurations:
            const QuillEditorImageEmbedConfigurations(
          forceUseMobileOptionMenuForImageClick: true,
        ),
      ),
    ),
  ),
)
```