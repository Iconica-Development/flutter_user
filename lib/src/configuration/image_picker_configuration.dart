import "package:flutter_image_picker/flutter_image_picker.dart";

/// Configuration for the image picker.
ImagePickerConfig getImagePickerConfig() => const ImagePickerConfig(
      imageQuality: 75,
      maxHeight: 750,
      maxWidth: 750,
    );
