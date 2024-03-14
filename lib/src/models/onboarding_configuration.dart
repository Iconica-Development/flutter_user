// ignore_for_file: avoid_positional_boolean_parameters

import 'package:flutter/material.dart';
import 'package:flutter_image_picker/flutter_image_picker.dart';
import 'package:flutter_stepper/stepper.dart';
import 'package:flutter_user/flutter_user.dart';

class OnboardingConfiguration {
  OnboardingConfiguration({
    this.onboardingOptions,
    this.onboardingController,
    this.onboardingFinished,
    this.onboardingOnNext,
    this.onboardingConfiguration,
    this.stepperTheme,
    this.imagePickerConfig,
    this.personalInputs,
    this.accessInputs,
    this.nextButton,
    this.backButton,
    this.personalInfoTitle = 'Who are you?',
    this.personalInfoDescription = 'Tell us something about yourself',
    this.personalInfoTextfieldHint = 'Something about yourself...',
    this.photoTitle = 'Upload a photo',
    this.photoDescription = 'Upload a photo of yourself',
    this.accessPageTitle = 'What may others see of you?',
    this.accessPageDescription = 'Select what others may see of you.',
    this.completionTitle = 'Onboarding completed!',
    this.completionDescription = 'You are now ready to begin.',
  });
  final String personalInfoTitle;
  final String personalInfoDescription;
  final String personalInfoTextfieldHint;
  final String photoTitle;
  final String photoDescription;
  final String accessPageTitle;
  final String accessPageDescription;
  final String completionTitle;
  final String completionDescription;

  final FlutterFormOptions? onboardingOptions;

  /// Controller for the onboarding screen.
  final FlutterFormController? onboardingController;

  /// Called when the user finishes the onboarding.
  final Function(Map<int, Map<String, dynamic>> results, BuildContext)?
      onboardingFinished;

  /// Called when the user goes to the next page in the onboarding.
  final Function(int pageNumber, Map<String, dynamic> results, BuildContext)?
      onboardingOnNext;

  /// Configuration for the onboarding screen.
  final OnboardingConfiguration? onboardingConfiguration;

  /// Theme for the onboarding screen.
  final StepperTheme? stepperTheme;

  /// Configuration for the image picker.
  final ImagePickerConfig? imagePickerConfig;

  /// Extra inputs for the personal info page.
  final List<Widget>? personalInputs;

  /// Extra inputs for the access page.
  final List<Widget>? accessInputs;

  final Widget Function(int, FlutterFormController, bool)? nextButton;
  final Widget Function(
    int,
    bool,
    int,
    FlutterFormController,
  )? backButton;
}
