import "package:flutter/material.dart";
import "package:flutter_registration/flutter_registration.dart";

/// Default Registration Options
RegistrationOptions defaultRegistrationOptions({
  required BuildContext context,
  required VoidCallback afterRegistration,
  required int? Function(String error) onError,
  required RegistrationRepository registrationRepository,
  required Future<void> Function() beforeRegistration,
}) {
  var theme = Theme.of(context);
  return RegistrationOptions(
    registrationRepository: registrationRepository,
    registrationSteps: RegistrationOptions.getDefaultSteps(
      textStyle: theme.textTheme.bodyMedium,
      hintStyle: theme.textTheme.bodyMedium?.copyWith(
        color: theme.textTheme.bodyMedium?.color?.withOpacity(0.5),
      ),
    ),
    beforeRegistration: () async {
      await beforeRegistration();
    },
    afterRegistration: () {
      afterRegistration();
    },
    onError: (error) => onError(error),
  );
}
