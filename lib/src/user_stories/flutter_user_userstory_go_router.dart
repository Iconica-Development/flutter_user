import 'package:flutter/material.dart';
import 'package:flutter_user/flutter_user.dart';
import 'package:flutter_user/src/default_configs/image_picker_configuration.dart';
import 'package:flutter_user/src/default_configs/stepper_theme.dart';
import 'package:flutter_user/src/go_router.dart';
import 'package:flutter_user/src/services/example_registration_service.dart';
import 'package:flutter_user/src/widgets/onboarding.dart';
import 'package:go_router/go_router.dart';

Future<String> getFirstRoute(
  AuthUserStoryConfiguration configuration,
  BuildContext context,
) async {
  var user = await configuration.onGetLoggedInUser?.call(context);
  if (user == null) {
    return AuthUserStoryRoutes.loginScreen;
  }
  if (configuration.useOnboarding && !user.onboarded) {
    return AuthUserStoryRoutes.onboarding;
  } else {
    return configuration.afterLoginRoute ?? '';
  }
}

List<GoRoute> getStartStoryRoutes(
  AuthUserStoryConfiguration configuration,
) =>
    <GoRoute>[
      GoRoute(
        path: AuthUserStoryRoutes.loginScreen,
        pageBuilder: (context, state) {
          var loginScreen = Stack(
            children: [
              EmailPasswordLoginForm(
                onLogin: (email, password) async {
                  if (configuration.onLogin != null) {
                    configuration.onLogin?.call(email, password, context);
                    return;
                  }
                  var service =
                      configuration.loginServiceBuilder?.call(context) ??
                          LocalLoginService();
                  var theme = Theme.of(context);
                  var result = await service.loginWithEmailAndPassword(
                    email,
                    password,
                    context,
                  );
                  if (result.loginSuccessful && context.mounted) {
                    var user =
                        await configuration.onGetLoggedInUser?.call(context);

                    if (context.mounted)
                      return context.go(
                        user != null &&
                                !user.onboarded &&
                                configuration.useOnboarding
                            ? AuthUserStoryRoutes.onboarding
                            : configuration.afterLoginRoute!,
                      );
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
                    ? (email, password) async {
                        configuration.onRegister
                            ?.call(email, password, context);

                        if (configuration.beforeRegistrationPage != null) {
                          await context
                              .push(AuthUserStoryRoutes.beforeRegistration);
                        } else {
                          await context
                              .push(AuthUserStoryRoutes.registrationScreen);
                        }
                      }
                    : null,
                onForgotPassword: configuration.showForgotPassword
                    ? (email) async {
                        configuration.onForgotPassword?.call(
                          email,
                          context,
                        );

                        await context
                            .push(AuthUserStoryRoutes.forgotPasswordScreen);
                      }
                    : null,
                options: configuration.loginOptionsBuilder?.call(context) ??
                    const LoginOptions(),
              ),
              configuration.pageOverlayBuilder?.call(context) ??
                  const SizedBox.shrink(),
            ],
          );
          return buildScreenWithoutTransition(
            context: context,
            state: state,
            child: configuration.loginPageBuilder?.call(
                  context,
                  loginScreen,
                ) ??
                Scaffold(
                  body: loginScreen,
                ),
          );
        },
      ),
      GoRoute(
        path: AuthUserStoryRoutes.registrationScreen,
        pageBuilder: (context, state) {
          var registrationScreen = Stack(
            children: [
              RegistrationScreen(
                registrationOptions: configuration.registrationOptionsBuilder
                        ?.call(context) ??
                    RegistrationOptions(
                      registrationRepository: ExampleRegistrationRepository(),
                      registrationSteps: RegistrationOptions.getDefaultSteps(),
                      afterRegistration: () => context.go(
                        configuration.afterRegistrationPage != null
                            ? AuthUserStoryRoutes.afterRegistration
                            : AuthUserStoryRoutes.loginScreen,
                      ),
                    ),
              ),
              configuration.pageOverlayBuilder?.call(context) ??
                  const SizedBox.shrink(),
            ],
          );
          return buildScreenWithoutTransition(
            context: context,
            state: state,
            child: configuration.registrationPageBuilder?.call(
                  context,
                  registrationScreen,
                ) ??
                Scaffold(
                  body: registrationScreen,
                ),
          );
        },
      ),
      GoRoute(
        path: AuthUserStoryRoutes.forgotPasswordScreen,
        pageBuilder: (context, state) {
          var theme = Theme.of(context);
          var service = configuration.loginServiceBuilder?.call(context) ??
              LocalLoginService();
          var forgotPasswordScreen = Stack(
            children: [
              ForgotPasswordForm(
                options: configuration.loginOptionsBuilder?.call(context) ??
                    const LoginOptions(),
                description:
                    configuration.forgotPasswordDescription?.call(context) ??
                        const Center(child: Text('description')),
                onRequestForgotPassword: (email) async {
                  if (configuration.onRequestForgotPassword != null) {
                    await configuration.onRequestForgotPassword
                        ?.call(email, context);
                    return;
                  }
                  var result =
                      await service.requestChangePassword(email, context);
                  if (result.requestSuccesfull && context.mounted) {
                    context.go(AuthUserStoryRoutes.loginScreen);
                  } else {
                    if (context.mounted &&
                        result.requestPasswordError != null) {
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
          return buildScreenWithoutTransition(
            context: context,
            state: state,
            child: configuration.forgotPasswordBuilder?.call(
                  context,
                  forgotPasswordScreen,
                ) ??
                Scaffold(
                  body: SafeArea(
                    child: Center(
                      child: forgotPasswordScreen,
                    ),
                  ),
                ),
          );
        },
      ),
      GoRoute(
        path: AuthUserStoryRoutes.onboarding,
        pageBuilder: (context, state) {
          var onboarding = configuration.onboardingScreen ??
              Onboarding(
                backButton: configuration.onboardingConfiguration?.backButton,
                nextButton: configuration.onboardingConfiguration?.nextButton,
                accessInputs:
                    configuration.onboardingConfiguration?.accessInputs,
                personalInputs:
                    configuration.onboardingConfiguration?.personalInputs,
                imagePickerConfig:
                    configuration.onboardingConfiguration?.imagePickerConfig ??
                        getImagePickerConfig(),
                stepperTheme:
                    configuration.onboardingConfiguration?.stepperTheme ??
                        getStepperTheme(context),
                configuration: configuration.onboardingConfiguration ??
                    OnboardingConfiguration(),
                onboardingFinished: (result) => configuration
                    .onboardingConfiguration?.onboardingFinished
                    ?.call(result, context),
                onboardingOnNext: (pageNumber, results) => configuration
                    .onboardingConfiguration?.onboardingOnNext
                    ?.call(pageNumber, results, context),
              );
          return buildScreenWithoutTransition(
            context: context,
            state: state,
            child: Scaffold(
              body: onboarding,
            ),
          );
        },
      ),
      if (configuration.beforeRegistrationPage != null) ...[
        GoRoute(
          path: AuthUserStoryRoutes.beforeRegistration,
          pageBuilder: (context, state) => buildScreenWithoutTransition(
            context: context,
            state: state,
            child: configuration.beforeRegistrationPage!.call(context),
          ),
        ),
      ],
      if (configuration.afterRegistrationPage != null) ...[
        GoRoute(
          path: AuthUserStoryRoutes.afterRegistration,
          pageBuilder: (context, state) => buildScreenWithoutTransition(
            context: context,
            state: state,
            child: configuration.afterRegistrationPage!.call(context),
          ),
        ),
      ],
    ];
