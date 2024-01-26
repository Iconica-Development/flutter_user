// ignore_for_file: avoid_positional_boolean_parameters

import 'package:flutter/material.dart';
import 'package:flutter_auth/flutter_auth.dart';
import 'package:flutter_form_wizard/utils/form.dart';
import 'package:flutter_image_picker/flutter_image_picker.dart';
import 'package:flutter_stepper/stepper.dart';

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
    this.personalInfoTitle = 'Wie ben jij?',
    this.personalInfoDescription = 'Vertel iets over je zelf.',
    this.personalInfoTextfieldHint = 'Iets over je zelf...',
    this.photoTitle = 'Upload een foto',
    this.photoDescription = 'Upload een foto van je zelf.',
    this.accessPageTitle = 'Wat mogen andere van jou zien?',
    this.accessPageDescription = 'Selecteer wat andere van jou mogen zien.',
    this.completionTitle = 'onboarding afgerond!',
    this.completionDescription = 'Je bent nu klaar om te beginnen.',
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
