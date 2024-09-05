import "dart:typed_data";

import "package:flutter/material.dart";
import "package:flutter_input_library/flutter_input_library.dart";
import "package:flutter_user/src/widgets/form_image_picker.dart";

/// Onboarding Widget
class Onboarding extends StatefulWidget {
  /// Onboarding Constructor
  const Onboarding({
    required this.onboardingFinished,
    super.key,
  });

  /// When onboarding is finished this function is called
  final Function(Map<int, Map<String, dynamic>> results) onboardingFinished;

  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  Uint8List? selectedImage;
  bool showImageError = false;
  GlobalKey<FormFieldState<String>> firstNameKey =
      GlobalKey<FormFieldState<String>>();
  GlobalKey<FormFieldState<String>> bioKey =
      GlobalKey<FormFieldState<String>>();
  String? firstName = "";
  String? bio = "";
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(
          color: Colors.black,
          size: 16,
        ),
      ),
      body: Form(
        key: formKey,
        child: CustomScrollView(
          slivers: [
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  const SizedBox(height: 64),
                  Text(
                    "create your profile",
                    style: theme.textTheme.headlineLarge,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  ImagePickerWidget(
                    onImagePicked: (image) {
                      selectedImage = image;
                      showImageError = false;
                      setState(() {});
                    },
                  ),
                  const SizedBox(height: 4),
                  if (showImageError)
                    Text(
                      "Please select an image",
                      style: theme.textTheme.bodySmall!.copyWith(
                        color: Colors.red[900],
                      ),
                      textAlign: TextAlign.center,
                    ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 60),
                    child: FlutterFormInputPlainText(
                      key: firstNameKey,
                      textCapitalization: TextCapitalization.sentences,
                      style: theme.textTheme.bodyMedium,
                      decoration: InputDecoration(
                        hintText: "First name",
                        hintStyle: theme.textTheme.bodyMedium?.copyWith(
                          color: theme.textTheme.bodyMedium?.color
                              ?.withOpacity(0.5),
                        ),
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 12),
                        border: const OutlineInputBorder(),
                        focusedBorder: const OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter your first name";
                        }
                        return null;
                      },
                      onSaved: (value) {
                        firstName = value;
                      },
                    ),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 60),
                    child: SizedBox(
                      height: 140,
                      child: FlutterFormInputMultiLine(
                        key: bioKey,
                        style: theme.textTheme.bodyMedium,
                        textCapitalization: TextCapitalization.sentences,
                        decoration: InputDecoration(
                          hintText: "Bio",
                          hintStyle: theme.textTheme.bodyMedium?.copyWith(
                            color: theme.textTheme.bodyMedium?.color
                                ?.withOpacity(0.5),
                          ),
                          contentPadding: const EdgeInsets.all(12),
                          border: const OutlineInputBorder(),
                          focusedBorder: const OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please enter your bio";
                          }
                          return null;
                        },
                        onSaved: (value) {
                          bio = value;
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SliverFillRemaining(
              hasScrollBody: false,
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.only(left: 80, right: 80, top: 20),
                  child: SafeArea(
                    bottom: true,
                    child: Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 16),
                            child: FilledButton(
                              onPressed: () {
                                if (selectedImage == null) {
                                  showImageError = true;
                                  setState(() {});
                                }
                                if (formKey.currentState!.validate() &&
                                    selectedImage != null) {
                                  formKey.currentState!.save();

                                  widget.onboardingFinished({
                                    0: {
                                      "firstName": firstName,
                                      "bio": bio,
                                      "image": selectedImage,
                                    },
                                  });
                                }
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8),
                                child: Text(
                                  "Save",
                                  style: theme.textTheme.displayLarge,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
