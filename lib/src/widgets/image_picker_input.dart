import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_wizard/flutter_form.dart';
import 'package:flutter_image_picker/flutter_image_picker.dart';
import 'package:flutter_user/src/default_configs/image_picker_theme.dart';

class FlutterFormInputImage extends FlutterFormInputWidget<Uint8List> {
  const FlutterFormInputImage({
    required super.controller,
    required this.imagePickerConfig,
    super.key,
    super.label,
    this.firstName,
    this.lastName,
  });

  final String? firstName;
  final String? lastName;
  final ImagePickerConfig imagePickerConfig;

  @override
  Widget build(BuildContext context) {
    super.registerController(context);

    var _ = getTranslator(context);
    return ImageFormField(
      onSaved: controller.onSaved,
      validator: (value) => controller.onValidate(value, _),
      initialValue: controller.value,
      imagePickerConfig: imagePickerConfig,
    );
  }
}

class ImageFormField extends FormField<Uint8List> {
  ImageFormField({
    required FormFieldSetter<Uint8List> super.onSaved,
    required FormFieldValidator<Uint8List> super.validator,
    required this.imagePickerConfig,
    super.key,
    super.initialValue,
  }) : super(
          builder: (FormFieldState<Uint8List> state) => ImageWidget(
            initialImage: initialValue,
            state: state,
            imagePickerConfig: imagePickerConfig,
          ),
        );
  final ImagePickerConfig imagePickerConfig;
}

class ImageWidget extends StatefulWidget {
  const ImageWidget({
    required this.state,
    required this.imagePickerConfig,
    super.key,
    this.initialImage,
  });
  final Uint8List? initialImage;
  final FormFieldState<Uint8List> state;
  final ImagePickerConfig imagePickerConfig;

  @override
  State<ImageWidget> createState() => _ImageWidgetState();
}

class _ImageWidgetState extends State<ImageWidget> {
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var image = widget.initialImage;
    if (widget.initialImage != null && image == null ||
        widget.state.value != null) {
      if (widget.state.value != null) {
        image = widget.state.value;
      } else {
        image = widget.initialImage;
      }
    }

    Future<void> openImagePicker(ThemeData theme) async {
      var imageInBytes = await showModalBottomSheet<Uint8List?>(
        context: context,
        backgroundColor: theme.colorScheme.surface,
        builder: (BuildContext context) => ImagePicker(
          imagePickerConfig: widget.imagePickerConfig,
          imagePickerTheme: getImagePickerTheme(context),
        ),
      );
      if (imageInBytes != null && imageInBytes.isNotEmpty) {
        widget.state.didChange(imageInBytes);
        image = imageInBytes;
      }
    }

    if (image != null && image!.isNotEmpty) {
      return GestureDetector(
        onTap: () async {
          await openImagePicker(theme);
        },
        child: Container(
          width: 90,
          height: 90,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
              image: MemoryImage(image!),
              fit: BoxFit.cover,
            ),
          ),
        ),
      );
    } else {
      return GestureDetector(
        onTap: () async {
          await openImagePicker(theme);
        },
        child: Container(
          width: 90,
          height: 90,
          decoration: BoxDecoration(
            color: const Color(0xFF000000).withOpacity(0.20),
            shape: BoxShape.circle,
          ),
          child: const Center(
            child: Icon(
              Icons.photo_camera,
            ),
          ),
        ),
      );
    }
  }
}

class FlutterFormInputImageController
    implements FlutterFormInputController<Uint8List> {
  FlutterFormInputImageController({
    required this.id,
    this.mandatory = true,
    this.value,
    this.checkPageTitle,
    this.checkPageDescription,
    this.onChanged,
  });

  @override
  String? id;

  @override
  Uint8List? value;

  @override
  bool mandatory;

  @override
  String Function(Uint8List? value)? checkPageTitle;

  @override
  String Function(Uint8List? value)? checkPageDescription;

  @override
  void Function(Uint8List? value)? onChanged;

  @override
  void onSaved(Uint8List? value) {
    this.value = value;
  }

  @override
  String? onValidate(
    Uint8List? value,
    String Function(String, {List<String>? params}) translator,
  ) =>
      null;

  @override
  void Function(Uint8List? value)? onSubmit;
}
