import 'package:flutter/material.dart';
import 'package:flutter_image_picker/flutter_image_picker.dart';

ImagePickerTheme getImagePickerTheme(
  BuildContext context,
) {
  var theme = Theme.of(context);

  return ImagePickerTheme(
    textColor: theme.textTheme.displaySmall!.color!,
    title: 'Wil je een bestand uploaden of een foto maken?',
    titleTextSize: 16,
    iconTextSize: 14,
    titleColor: theme.textTheme.displaySmall!.color!,
    titleBackgroundColor: theme.colorScheme.surface,
    titleAlignment: TextAlign.center,
    makePhotoIcon: const Padding(
      padding: EdgeInsets.all(8),
      child: Icon(
        Icons.camera_alt,
        size: 40,
      ),
    ),
    makePhotoText: 'Maak een foto'.toUpperCase(),
    selectImageIcon: const Padding(
      padding: EdgeInsets.all(8),
      child: Icon(
        Icons.insert_drive_file,
        size: 40,
      ),
    ),
    selectImageText: 'Selecteer een foto'.toUpperCase(),
    iconColor: theme.textTheme.displaySmall!.color!,
    closeButtonText: 'Sluiten'.toUpperCase(),
    closeButtonBackgroundColor: Colors.black,
    closeButtonTextColor: Colors.white,
  );
}
