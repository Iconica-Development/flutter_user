import 'package:flutter/material.dart';
import 'package:flutter_user/flutter_user.dart';
import 'package:flutter_user/src/default_configs/image_picker_configuration.dart';
import 'package:flutter_user/src/default_configs/stepper_theme.dart';
import 'package:flutter_user/src/services/example_registration_service.dart';
import 'package:flutter_user/src/utils/is_keyboard_closed.dart';
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
          if (configuration.onLogin != null) {
            configuration.onLogin?.call(email, password, context);
            return;
          }
          var service = configuration.loginServiceBuilder?.call(context) ??
              LocalLoginService();
          var theme = Theme.of(context);
          var result = await service.loginWithEmailAndPassword(
            email,
            password,
            context,
          );
          if (result.loginSuccessful && context.mounted) {
            var user = await configuration.onGetLoggedInUser?.call(context);

            if (context.mounted) {
              await Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => user != null &&
                          !user.onboarded &&
                          configuration.useOnboarding
                      ? _onboardingScreen(configuration, context)
                      : configuration.afterLoginPage!.call(context),
                ),
              );
            }
          } else {
            if (context.mounted && result.loginError != null) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        result.loginError!.title,
                        style: theme.textTheme.titleSmall?.copyWith(
                          color: theme.colorScheme.onBackground,
                        ),
                      ),
                      Text(
                        result.loginError!.message,
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.onBackground,
                          height: 1.3,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              );
            }
          }
        },
        onRegister: configuration.useRegistration
            ? (email, password, ctx) async {
                configuration.onRegister?.call(email, password, context);
                var currentFocus = FocusScope.of(ctx);
                var focused =
                    currentFocus.children.where((element) => element.hasFocus);

                for (var node in focused) {
                  node.unfocus();
                }

                var isReopened = await isKeyboardClosed(context);
                if (!isReopened) {
                  return;
                }
                if (configuration.beforeRegistrationPage != null &&
                    context.mounted) {
                  await Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) =>
                          _beforeRegistrationScreen(configuration, context),
                    ),
                  );
                } else {
                  if (context.mounted)
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
            ? (email, ctx) async {
                configuration.onForgotPassword?.call(
                  email,
                  context,
                );
                var currentFocus = FocusScope.of(ctx);
                var focused =
                    currentFocus.children.where((element) => element.hasFocus);

                for (var node in focused) {
                  node.unfocus();
                }

                var isReopened = await isKeyboardClosed(context);
                if (!isReopened) {
                  return;
                }
                if (context.mounted)
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
  var theme = Theme.of(context);
  var service =
      configuration.loginServiceBuilder?.call(context) ?? LocalLoginService();
  var forgotPasswordScreen = Stack(
    children: [
      ForgotPasswordForm(
        options: configuration.loginOptionsBuilder?.call(context) ??
            const LoginOptions(),
        description: configuration.forgotPasswordDescription?.call(context) ??
            const Center(child: Text('description')),
        onRequestForgotPassword: (email) async {
          if (configuration.onRequestForgotPassword != null) {
            await configuration.onRequestForgotPassword?.call(email, context);
            return;
          }
          var result = await service.requestChangePassword(email, context);
          if (result.requestSuccesfull && context.mounted) {
            await Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => _loginScreen(configuration, context),
              ),
            );
          } else {
            if (context.mounted && result.requestPasswordError != null) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        result.requestPasswordError!.title,
                        style: theme.textTheme.titleSmall?.copyWith(
                          color: theme.colorScheme.onBackground,
                        ),
                      ),
                      Text(
                        result.requestPasswordError!.message,
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.onBackground,
                          height: 1.3,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              );
            }
          }
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
        canPopOnboarding: configuration.canPopOnboarding,
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
