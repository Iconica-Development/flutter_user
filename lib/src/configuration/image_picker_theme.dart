import "package:flutter/material.dart";
import "package:flutter_image_picker/flutter_image_picker.dart";

/// Default Image Picker Theme
ImagePickerTheme getImagePickerTheme(
  BuildContext context,
) {
  var theme = Theme.of(context);

  return ImagePickerTheme(
    iconTextStyle: theme.textTheme.bodySmall!.copyWith(
      fontWeight: FontWeight.w500,
    ),
    makePhotoIcon: const Padding(
      padding: EdgeInsets.all(8),
      child: Icon(
        Icons.camera_alt,
        size: 40,
      ),
    ),
    makePhotoText: "TAKE PICTURE",
    selectImageIcon: const Padding(
      padding: EdgeInsets.all(8),
      child: Icon(
        Icons.insert_drive_file,
        size: 40,
      ),
    ),
    selectImageText: "UPLOAD FILE",
    iconColor: theme.textTheme.displaySmall!.color!,
    closeButtonBuilder: (onTap) => TextButton(
      onPressed: () {
        onTap.call();
      },
      child: Text(
        "Cancel",
        style: theme.textTheme.bodyMedium?.copyWith(
          fontSize: 18,
          decoration: TextDecoration.underline,
        ),
      ),
    ),
  );
}
