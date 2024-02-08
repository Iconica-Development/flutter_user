import 'package:flutter/material.dart';
import 'package:flutter_user/flutter_user.dart';
import 'package:flutter_user/src/default_configs/image_picker_configuration.dart';
import 'package:flutter_user/src/default_configs/stepper_theme.dart';
import 'package:flutter_user/src/services/example_registration_service.dart';
import 'package:flutter_user/src/widgets/onboarding.dart';

Widget userNavigatorUserstory(
  AuthUserStoryConfiguration configuration,
  BuildContext context,
) =>
    _loginScreen(configuration, context);

Widget _loginScreen(
  AuthUserStoryConfiguration configuration,
  BuildContext context,
) {
  var loginScreen = Stack(
    children: [
      EmailPasswordLoginForm(
        onLogin: (email, password) async {
          configuration.onLogin?.call(email, password, context);
          var result = await configuration.loginService
              .loginWithEmailAndPassword(email, password);
          if (result && context.mounted) {
            var user = await configuration.loginService.getLoggedInUser();
            if (context.mounted)
              await Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => (user is User &&
                              user is OnboardedUserMixin &&
                              (user.onboarded ?? false)) &&
                          configuration.useOnboarding
                      ? _onboardingScreen(configuration, context)
                      : configuration.afterLoginPage!(context),
                ),
              );
          } else {
            if (context.mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    "Login ${result ? 'successful' : 'failed'}",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.error,
                    ),
                  ),
                ),
              );
            }
          }
        },
        onRegister: configuration.useRegistration
            ? (email, password) async {
                configuration.onRegister?.call(email, password, context);

                if (configuration.beforeRegistrationPage != null) {
                  await Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) =>
                          _beforeRegistrationScreen(configuration, context),
                    ),
                  );
                } else {
                  await Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) =>
                          _registrationScreen(configuration, context),
                    ),
                  );
                }
              }
            : null,
        onForgotPassword: configuration.showForgotPassword
            ? (email) async {
                configuration.onForgotPassword?.call(
                  email,
                  context,
                );
                await Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) =>
                        _forgotPasswordScreen(configuration, context),
                  ),
                );
              }
            : null,
        options: configuration.loginOptionsBuilder?.call(context) ??
            const LoginOptions(),
      ),
      configuration.pageOverlayBuilder?.call(context) ??
          const SizedBox.shrink(),
    ],
  );
  return configuration.loginPageBuilder?.call(
        context,
        loginScreen,
      ) ??
      Scaffold(
        body: loginScreen,
      );
}

Widget _registrationScreen(
  AuthUserStoryConfiguration configuration,
  BuildContext context,
) {
  var registrationScreen = Stack(
    children: [
      RegistrationScreen(
        registrationOptions:
            configuration.registrationOptionsBuilder?.call(context) ??
                RegistrationOptions(
                  registrationRepository: ExampleRegistrationRepository(),
                  registrationSteps: RegistrationOptions.getDefaultSteps(),
                  afterRegistration: () async =>
                      Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) =>
                          configuration.afterRegistrationPage != null
                              ? _afterRegistrationScreen(configuration, context)
                              : _loginScreen(configuration, context),
                    ),
                  ),
                ),
      ),
      configuration.pageOverlayBuilder?.call(context) ??
          const SizedBox.shrink(),
    ],
  );
  return configuration.registrationPageBuilder?.call(
        context,
        registrationScreen,
      ) ??
      Scaffold(
        body: registrationScreen,
      );
}

Widget _forgotPasswordScreen(
  AuthUserStoryConfiguration configuration,
  BuildContext context,
) {
  var forgotPasswordScreen = Stack(
    children: [
      ForgotPasswordForm(
        options: configuration.loginOptionsBuilder?.call(context) ??
            const LoginOptions(),
        description: configuration.forgotPasswordDescription?.call(context) ??
            const Center(child: Text('description')),
        onRequestForgotPassword: (email) async {
          configuration.onRequestForgotPassword?.call(
            email,
            context,
          );
          await configuration.loginService.requestChangePassword(email);
        },
        title: configuration.forgotPasswordTitle?.call(context),
      ),
      configuration.pageOverlayBuilder?.call(context) ??
          const SizedBox.shrink(),
    ],
  );
  return configuration.forgotPasswordBuilder?.call(
        context,
        forgotPasswordScreen,
      ) ??
      Scaffold(
        body: SafeArea(
          child: Center(
            child: forgotPasswordScreen,
          ),
        ),
      );
}

Widget _onboardingScreen(
  AuthUserStoryConfiguration configuration,
  BuildContext context,
) {
  var onboarding = configuration.onboardingScreen ??
      Onboarding(
        backButton: configuration.onboardingConfiguration?.backButton,
        nextButton: configuration.onboardingConfiguration?.nextButton,
        accessInputs: configuration.onboardingConfiguration?.accessInputs,
        personalInputs: configuration.onboardingConfiguration?.personalInputs,
        imagePickerConfig:
            configuration.onboardingConfiguration?.imagePickerConfig ??
                getImagePickerConfig(),
        stepperTheme: configuration.onboardingConfiguration?.stepperTheme ??
            getStepperTheme(context),
        configuration:
            configuration.onboardingConfiguration ?? OnboardingConfiguration(),
        onboardingFinished: (result) => configuration
            .onboardingConfiguration?.onboardingFinished
            ?.call(result, context),
        onboardingOnNext: (pageNumber, results) => configuration
            .onboardingConfiguration?.onboardingOnNext
            ?.call(pageNumber, results, context),
      );
  return Scaffold(
    body: onboarding,
  );
}

Widget _beforeRegistrationScreen(
  AuthUserStoryConfiguration configuration,
  BuildContext context,
) =>
    configuration.beforeRegistrationPage!.call(context);

Widget _afterRegistrationScreen(
  AuthUserStoryConfiguration configuration,
  BuildContext context,
) =>
    configuration.afterRegistrationPage!.call(context);
