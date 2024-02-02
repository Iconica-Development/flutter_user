import 'package:flutter/material.dart';
import 'package:flutter_user/flutter_user.dart';
import 'package:flutter_user/src/default_configs.dart/image_picker_configuration.dart';
import 'package:flutter_user/src/default_configs.dart/stepper_theme.dart';
import 'package:flutter_user/src/go_router.dart';
import 'package:flutter_user/src/services/example_registration_service.dart';
import 'package:flutter_user/src/widgets/onboarding.dart';
import 'package:go_router/go_router.dart';

List<GoRoute> getStartStoryRoutes(
  AuthUserStoryConfiguration configuration,
) =>
    <GoRoute>[
      GoRoute(
        path: AuthUserStoryRoutes.loginScreen,
        pageBuilder: (context, state) {
          var loginScreen = EmailPasswordLoginForm(
            onLogin: (email, password) async {
              configuration.onLogin.call(email, password, context);
            },
            onRegister: configuration.useRegistration
                ? (email, password) async {
                    if (configuration.onRegister != null) {
                      return configuration.onRegister?.call(email, password);
                    }
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
                    if (configuration.onForgotPassword != null) {
                      return configuration.onForgotPassword?.call(email);
                    }
                    await context
                        .push(AuthUserStoryRoutes.forgotPasswordScreen);
                  }
                : null,
            options: configuration.loginOptions,
          );
          return buildScreenWithoutTransition(
            context: context,
            state: state,
            child: configuration.loginPageBuilder?.call(context, loginScreen) ??
                Scaffold(
                  body: loginScreen,
                ),
          );
        },
      ),
      GoRoute(
        path: AuthUserStoryRoutes.registrationScreen,
        pageBuilder: (context, state) {
          var registrationScreen = RegistrationScreen(
            registrationOptions:
                configuration.registrationOptions?.call(context) ??
                    RegistrationOptions(
                      registrationRepository: ExampleRegistrationRepository(),
                      registrationSteps: RegistrationOptions.getDefaultSteps(),
                      afterRegistration: () => context.go(
                        configuration.afterRegistrationPage != null
                            ? AuthUserStoryRoutes.afterRegistration
                            : AuthUserStoryRoutes.loginScreen,
                      ),
                    ),
          );
          return buildScreenWithoutTransition(
            context: context,
            state: state,
            child: Scaffold(
              body: registrationScreen,
            ),
          );
        },
      ),
      GoRoute(
        path: AuthUserStoryRoutes.forgotPasswordScreen,
        pageBuilder: (context, state) {
          var forgotPasswordScreen = ForgotPasswordForm(
            options: configuration.loginOptions,
            description: configuration.forgotPasswordDescription,
            onRequestForgotPassword:
                configuration.onRequestForgotPassword ?? (email) {},
            title: configuration.forgotPasswordTitle,
          );
          return buildScreenWithoutTransition(
            context: context,
            state: state,
            child: Scaffold(
              appBar: AppBar(),
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
