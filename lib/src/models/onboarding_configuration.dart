// ignore_for_file: avoid_positional_boolean_parameters

import 'package:flutter/material.dart';

class OnboardingConfiguration {
  const OnboardingConfiguration({
    this.onboardingFinished,
    this.onboardingOnNext,
  });

  /// Called when the user finishes the onboarding.
  final Function(Map<int, Map<String, dynamic>> results, BuildContext)?
      onboardingFinished;

  /// Called when the user goes to the next page in the onboarding.
  final Function(int pageNumber, Map<String, dynamic> results, BuildContext)?
      onboardingOnNext;
}
