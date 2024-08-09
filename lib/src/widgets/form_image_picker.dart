import "dart:typed_data";

import "package:flutter/foundation.dart";
import "package:flutter/material.dart";
import "package:flutter_image_picker/flutter_image_picker.dart";
import "package:flutter_user/src/configuration/image_picker_theme.dart";

/// Image Picker Widget
class ImagePickerWidget extends StatefulWidget {
  /// Image Picker Widget Constructor
  const ImagePickerWidget({
    required this.onImagePicked,
    super.key,
  });

  /// When an image is picked this function is called
  final Function(Uint8List?) onImagePicked;

  @override
  State<ImagePickerWidget> createState() => _ImagePickerWidgetState();
}

class _ImagePickerWidgetState extends State<ImagePickerWidget> {
  Uint8List? image;
  @override
  Widget build(BuildContext context) => Center(
        child: InkWell(
          onTap: () async {
            var selectedImage = await _pickImage(context);
            if (selectedImage != null) {
              widget.onImagePicked(selectedImage);
              setState(() {
                image = selectedImage;
              });
            }
          },
          child: Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              color: const Color(0xFFD9D9D9),
              shape: BoxShape.circle,
              image: image != null
                  ? DecorationImage(
                      image: Image.memory(image!).image,
                      fit: BoxFit.cover,
                    )
                  : null,
            ),
            child: image == null
                ? const Center(
                    child: Icon(
                      Icons.image_outlined,
                      size: 34,
                    ),
                  )
                : null,
          ),
        ),
      );

  Future<Uint8List?> _pickImage(BuildContext context) async {
    var imageInBytes = await showModalBottomSheet<Uint8List?>(
      context: context,
      backgroundColor: Colors.white,
      builder: (BuildContext context) => Padding(
        padding: const EdgeInsets.all(20),
        child: ImagePicker(
          theme: getImagePickerTheme(context),
        ),
      ),
    );

    return imageInBytes;
  }
}
