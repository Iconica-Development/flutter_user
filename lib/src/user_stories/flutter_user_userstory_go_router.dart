import 'package:flutter/material.dart';
import 'package:flutter_user/flutter_user.dart';
import 'package:flutter_user/src/go_router.dart';
import 'package:flutter_user/src/services/example_registration_service.dart';
import 'package:flutter_user/src/utils/is_keyboard_closed.dart';
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

List<GoRoute> getAuthStoryRoutes(
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
                          backgroundColor:
                              configuration.loginErrorSnackbarBackgroundColor ??
                                  theme.colorScheme.onSurface,
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                result.loginError!.title,
                                style: configuration
                                        .loginErrorSnackbarTitleTextStyle ??
                                    theme.textTheme.titleSmall?.copyWith(
                                      color: theme.colorScheme.surface,
                                    ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                result.loginError!.message,
                                style: configuration
                                        .loginErrorSnackbarMessageTextStyle ??
                                    theme.textTheme.bodySmall?.copyWith(
                                      color: theme.colorScheme.surface,
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
                        configuration.onRegister
                            ?.call(email, password, context);
                        var currentFocus = FocusScope.of(ctx);
                        var focused = currentFocus.children
                            .where((element) => element.hasFocus);

                        for (var node in focused) {
                          node.unfocus();
                        }

                        var isReopened = await isKeyboardClosed(context);
                        if (!isReopened) {
                          return;
                        }
                        if (configuration.beforeRegistrationPage != null &&
                            context.mounted) {
                          await context
                              .push(AuthUserStoryRoutes.beforeRegistration);
                        } else {
                          if (context.mounted)
                            await context
                                .push(AuthUserStoryRoutes.registrationScreen);
                        }
                      }
                    : null,
                onForgotPassword: configuration.useForgotPassword
                    ? (email, ctx) async {
                        configuration.onForgotPassword?.call(
                          email,
                          context,
                        );
                        var currentFocus = FocusScope.of(ctx);
                        var focused = currentFocus.children
                            .where((element) => element.hasFocus);
                        for (var node in focused) {
                          node.unfocus();
                        }
                        var isReopened = await isKeyboardClosed(context);
                        if (!isReopened) {
                          return;
                        }
                        if (context.mounted)
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
                loginScreen,
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
                      registrationRepository:
                          configuration.registrationRepository ??
                              ExampleRegistrationRepository(),
                      registrationSteps: RegistrationOptions.getDefaultSteps(),
                      afterRegistration: () async => context.push(
                        configuration.useAfterRegistrationPage
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
                registrationScreen,
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
                    configuration.forgotPasswordDescription?.call(context),
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
                                  color: theme.colorScheme.onSurface,
                                ),
                              ),
                              Text(
                                result.requestPasswordError!.message,
                                style: theme.textTheme.bodySmall?.copyWith(
                                  color: theme.colorScheme.onSurface,
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
                forgotPasswordScreen,
          );
        },
      ),
      GoRoute(
        path: AuthUserStoryRoutes.onboarding,
        pageBuilder: (context, state) {
          var onboarding = configuration.onboardingScreen ??
              Onboarding(
                onboardingFinished: (result) async {
                  await configuration
                      .onboardingConfiguration?.onboardingFinished
                      ?.call(result, context);
                  if (context.mounted)
                    context.go(configuration.afterLoginRoute!);
                },
                onboardingOnNext: (pageNumber, results) async {
                  await configuration.onboardingConfiguration?.onboardingOnNext
                      ?.call(pageNumber, results, context);
                  if (context.mounted)
                    context.go(configuration.afterLoginRoute!);
                },
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
      GoRoute(
        path: AuthUserStoryRoutes.beforeRegistration,
        pageBuilder: (context, state) => buildScreenWithoutTransition(
          context: context,
          state: state,
          child: configuration.beforeRegistrationPage!.call(context),
        ),
      ),
      GoRoute(
        path: AuthUserStoryRoutes.afterRegistration,
        pageBuilder: (context, state) => buildScreenWithoutTransition(
          context: context,
          state: state,
          child: configuration.afterRegistrationPage?.call(context) ??
              Scaffold(
                body: SafeArea(
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 60),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Spacer(),
                          const Text(
                            'Your registration was successful',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.w800,
                              fontSize: 24,
                              color: Color(0xff71C6D1),
                            ),
                          ),
                          const Spacer(),
                          InkWell(
                            onTap: () async {
                              context.go(AuthUserStoryRoutes.loginScreen);
                            },
                            child: Container(
                              height: 44,
                              width: 254,
                              decoration: const BoxDecoration(
                                color: Color(0xff71C6D1),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                              ),
                              child: const Center(
                                child: Text(
                                  'Finish',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w800,
                                    fontSize: 20,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
        ),
      ),
    ];
