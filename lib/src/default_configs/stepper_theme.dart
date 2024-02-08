import 'package:flutter/material.dart';
import 'package:flutter_stepper/stepper.dart';

StepperTheme getStepperTheme(
  BuildContext context,
) {
  var theme = Theme.of(context);
  return StepperTheme(
    emptyHeight: 50,
    emptyWidth: 0,
    lineDashGapLength: 0,
    stepIndicatorTheme: StepIndicatorTheme(
      activeBorder: Border.all(
        color: Colors.black,
      ),
      activeBackgroundColor: Colors.white,
      activeTextStyle: theme.textTheme.bodyMedium?.copyWith(
        color: Colors.black,
      ),
      inactiveBackgroundColor: Colors.black,
      inactiveBorder: Border.all(
        color: Colors.white,
      ),
      inactiveTextStyle: theme.textTheme.bodyMedium?.copyWith(
        color: theme.colorScheme.onPrimary,
      ),
      completedBackgroundColor: Colors.green,
    ),
    lineColor: theme.colorScheme.onPrimary,
  );
}
