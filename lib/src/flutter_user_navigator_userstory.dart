import "dart:async";

import "package:flutter/material.dart";
import "package:flutter_login/flutter_login.dart";
import "package:flutter_login_service/flutter_login_service.dart";
import "package:flutter_user/flutter_user.dart";
import "package:flutter_user/src/screens/forgot_password_success.dart";
import "package:flutter_user/src/screens/forgot_password_unsuccessfull";
import "package:flutter_user/src/screens/onboarding.dart";
import "package:flutter_user/src/screens/registration_success.dart";
import "package:flutter_user/src/screens/registration_unsuccessfull.dart";
import "package:flutter_user/src/services/local_registration_service.dart";
import "package:flutter_user/src/widgets/error_scaffold_messenger.dart";

/// Flutter User Navigator Userstory
class FlutterUserNavigatorUserstory extends StatefulWidget {
  /// Flutter User Navigator Userstory constructor
  const FlutterUserNavigatorUserstory({
    required this.context,
    required this.afterLoginPageScreen,
    this.loginServiceInterface,
    this.loginOptions,
    this.userOptions,
    this.registrationOptions,
    this.translations,
    this.registrationRepository,
    super.key,
  });

  /// Build context
  final BuildContext context;

  /// Login options
  final LoginOptions? loginOptions;

  /// Registration options
  final RegistrationOptions? registrationOptions;

  /// Login service interface
  final LoginServiceInterface? loginServiceInterface;

  /// Userstory options
  final FlutterUserOptions? userOptions;

  /// Flutter user translations
  final FlutterUserTranslations? translations;

  /// Registration repository
  final RegistrationRepository? registrationRepository;

  /// The page to navigate to after login
  final Widget afterLoginPageScreen;
  @override
  State<FlutterUserNavigatorUserstory> createState() =>
      _FlutterUserNavigatorUserstoryState();
}

class _FlutterUserNavigatorUserstoryState
    extends State<FlutterUserNavigatorUserstory> {
  late FlutterUserOptions userOptions;
  late LoginServiceInterface loginServiceInterface;
  late LoginOptions loginOptions;
  late RegistrationOptions registrationOptions;
  late FlutterUserTranslations translations;
  late RegistrationRepository registrationRepository;

  @override
  void initState() {
    userOptions = widget.userOptions ?? const FlutterUserOptions();
    loginOptions = widget.loginOptions ?? defaultLoginOptions(widget.context);
    loginServiceInterface = widget.loginServiceInterface ?? LocalLoginService();
    translations = widget.translations ?? const FlutterUserTranslations();
    registrationRepository =
        widget.registrationRepository ?? LocalRegistrationService();
    registrationOptions = widget.registrationOptions ??
        defaultRegistrationOptions(
          registrationRepository: registrationRepository,
          context: widget.context,
          beforeRegistration: () async {
            if (userOptions.beforeRegistration != null) {
              await userOptions.beforeRegistration!();
            } else {
              unawaited(showLoadingPopup(context));
            }
          },
          afterRegistration: () async {
            await userOptions.afterRegistration!();
            if (context.mounted) {
              // ignore: use_build_context_synchronously
              Navigator.of(context).pop();

              await replace(
                // ignore: use_build_context_synchronously
                context,
                RegistrationSuccesScreen(
                  translations: translations,
                  userOptions: userOptions,
                  loginOptions: loginOptions,
                  loginServiceInterface: loginServiceInterface,
                  registrationOptions: registrationOptions,
                  afterLoginPageScreen: widget.afterLoginPageScreen,
                ),
              );
            }
          },
          onError: (error) {
            if (userOptions.onRegistrationError != null) {
              return userOptions.onRegistrationError!(error);
            } else {
              if (context.mounted) {
                Navigator.of(context).pop();
                unawaited(
                  push(
                    context,
                    RegistrationUnsuccessfullScreen(
                      userOptions: userOptions,
                      translations: translations,
                      error: error,
                    ),
                  ),
                );
              }
              return 0;
            }
          },
        );

    super.initState();
  }

  @override
  Widget build(BuildContext context) => LoginScreen(
        translations: translations,
        loginOptions: loginOptions,
        userOptions: userOptions,
        loginServiceInterface: loginServiceInterface,
        registrationOptions: registrationOptions,
        afterLoginPageScreen: widget.afterLoginPageScreen,
      );
}

/// Login screen
class LoginScreen extends StatelessWidget {
  /// Login screen constructor
  const LoginScreen({
    required this.translations,
    required this.loginOptions,
    required this.userOptions,
    required this.loginServiceInterface,
    required this.registrationOptions,
    required this.afterLoginPageScreen,
    super.key,
  });

  /// Translations
  final FlutterUserTranslations translations;

  /// Login options
  final LoginOptions loginOptions;

  /// User options
  final FlutterUserOptions userOptions;

  /// Login service interface
  final LoginServiceInterface loginServiceInterface;

  /// Registration options
  final RegistrationOptions registrationOptions;

  /// The page to navigate to after login
  final Widget afterLoginPageScreen;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return EmailPasswordLoginForm(
      title:
          Text(translations.loginTitle, style: theme.textTheme.headlineLarge),
      options: loginOptions,
      onLogin: (email, password) async {
        await userOptions.beforeLogin?.call(email, password);

        // ignore: use_build_context_synchronously
        unawaited(showLoadingPopup(context));

        var loginResponse =
            await loginServiceInterface.loginWithEmailAndPassword(
          email,
          password,
          // ignore: use_build_context_synchronously
          context,
        );

        if (!loginResponse.loginSuccessful) {
          // ignore: use_build_context_synchronously
          Navigator.of(context).pop();
          await errorScaffoldMessenger(
            // ignore: use_build_context_synchronously
            context,
            loginResponse,
          );
          return;
        }
        await userOptions.afterLogin?.call();

        if (loginResponse.loginSuccessful) {
          var onboardingUser = await userOptions.onBoardedUser?.call();
          // ignore: use_build_context_synchronously
          Navigator.of(context).pop();
          await push(
            // ignore: use_build_context_synchronously
            context,
            userOptions.useOnboarding && onboardingUser?.onboarded == false
                ? OnboardingScreen(
                    userOptions: userOptions,
                    afterLoginPageScreen: afterLoginPageScreen,
                  )
                : afterLoginPageScreen,
          );
        }
      },
      onRegister: (email, password, context) async {
        if (userOptions.onRegister != null) {
          await userOptions.onRegister!(email, password, context);
        } else {
          await push(
            context,
            UserRegistrationScreen(
              registrationOptions: registrationOptions,
            ),
          );
        }
      },
      onForgotPassword: (email, ctx) async {
        if (userOptions.onForgotPassword != null) {
          await userOptions.onForgotPassword?.call(email, ctx);
        } else {
          await push(
            context,
            ForgotPasswordScreen(
              translations: translations,
              loginOptions: loginOptions,
              userOptions: userOptions,
              loginServiceInterface: loginServiceInterface,
              registrationOptions: registrationOptions,
              afterLoginPageScreen: afterLoginPageScreen,
            ),
          );
        }
      },
    );
  }
}

/// Forgot password screen
class ForgotPasswordScreen extends StatelessWidget {
  /// Forgot password screen constructor
  const ForgotPasswordScreen({
    required this.translations,
    required this.loginOptions,
    required this.userOptions,
    required this.loginServiceInterface,
    required this.registrationOptions,
    required this.afterLoginPageScreen,
    super.key,
  });

  /// Translations
  final FlutterUserTranslations translations;

  /// Login options
  final LoginOptions loginOptions;

  /// User options
  final FlutterUserOptions userOptions;

  /// Login service interface
  final LoginServiceInterface loginServiceInterface;

  /// Registration options
  final RegistrationOptions registrationOptions;

  /// The page to navigate to after login
  final Widget afterLoginPageScreen;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return ForgotPasswordForm(
      options: loginOptions,
      title: Text(
        translations.forgotPasswordTitle,
        style: theme.textTheme.headlineLarge,
      ),
      description: Padding(
        padding: const EdgeInsets.only(top: 8, bottom: 32),
        child: Text(
          translations.forgotPasswordDescription,
          textAlign: TextAlign.center,
        ),
      ),
      onRequestForgotPassword: (email) async {
        if (userOptions.onRequestForgotPassword != null) {
          await userOptions.onRequestForgotPassword?.call(email);
        } else {
          unawaited(showLoadingPopup(context));
          var requestPasswordChangeResponse =
              await loginServiceInterface.requestChangePassword(email, context);

          if (requestPasswordChangeResponse.requestSuccesfull) {
            // ignore: use_build_context_synchronously
            Navigator.of(context).pop();
            await replace(
              // ignore: use_build_context_synchronously
              context,
              ForgotPasswordSuccessScreen(
                translations: translations,
                loginOptions: loginOptions,
                userOptions: userOptions,
                loginServiceInterface: loginServiceInterface,
                registrationOptions: registrationOptions,
                afterLoginPageScreen: afterLoginPageScreen,
              ),
            );
          }

          if (!requestPasswordChangeResponse.requestSuccesfull) {
            // ignore: use_build_context_synchronously
            Navigator.of(context).pop();
            await push(
              // ignore: use_build_context_synchronously
              context,
              ForgotPasswordUnsuccessfullScreen(
                translations: translations,
                userOptions: userOptions,
              ),
            );
          }
        }
      },
    );
  }
}

/// Forgot password success screen
class ForgotPasswordSuccessScreen extends StatelessWidget {
  /// Forgot password success screen constructor
  const ForgotPasswordSuccessScreen({
    required this.translations,
    required this.loginOptions,
    required this.userOptions,
    required this.loginServiceInterface,
    required this.registrationOptions,
    required this.afterLoginPageScreen,
    super.key,
  });

  /// Translations
  final FlutterUserTranslations translations;

  /// Login options
  final LoginOptions loginOptions;

  /// User options
  final FlutterUserOptions userOptions;

  /// Login service interface
  final LoginServiceInterface loginServiceInterface;

  /// Registration options
  final RegistrationOptions registrationOptions;

  /// The page to navigate to after login
  final Widget afterLoginPageScreen;

  @override
  Widget build(BuildContext context) => ForgotPasswordSuccess(
        translations: translations,
        onPressed: () async {
          if (userOptions.onForgotPasswordSuccess != null) {
            await userOptions.onForgotPasswordSuccess!();
          } else {
            await replace(
              context,
              LoginScreen(
                translations: translations,
                loginOptions: loginOptions,
                userOptions: userOptions,
                loginServiceInterface: loginServiceInterface,
                registrationOptions: registrationOptions,
                afterLoginPageScreen: afterLoginPageScreen,
              ),
            );
          }
        },
      );
}

/// Forgot password unsuccessfull screen
class ForgotPasswordUnsuccessfullScreen extends StatelessWidget {
  /// Forgot password unsuccessfull screen constructor
  const ForgotPasswordUnsuccessfullScreen({
    required this.translations,
    required this.userOptions,
    super.key,
  });

  /// Translations
  final FlutterUserTranslations translations;

  /// User options
  final FlutterUserOptions userOptions;

  @override
  Widget build(BuildContext context) => ForgotPasswordUnsuccessfull(
        translations: translations,
        onPressed: () async {
          if (userOptions.onForgotPasswordUnsuccessfull != null) {
            await userOptions.onForgotPasswordUnsuccessfull!();
          } else {
            Navigator.of(context).pop();
          }
        },
      );
}

/// User registration screen
class UserRegistrationScreen extends StatelessWidget {
  /// User registration screen constructor
  const UserRegistrationScreen({required this.registrationOptions, super.key});

  /// Registration options
  final RegistrationOptions registrationOptions;

  @override
  Widget build(BuildContext context) => RegistrationScreen(
        registrationOptions: registrationOptions,
      );
}

/// Registration success screen
class RegistrationSuccesScreen extends StatelessWidget {
  /// Registration success screen constructor
  const RegistrationSuccesScreen({
    required this.translations,
    required this.userOptions,
    required this.loginOptions,
    required this.loginServiceInterface,
    required this.registrationOptions,
    required this.afterLoginPageScreen,
    super.key,
  });

  /// Translations
  final FlutterUserTranslations translations;

  /// Login options
  final LoginOptions loginOptions;

  /// User options
  final FlutterUserOptions userOptions;

  /// Login service interface
  final LoginServiceInterface loginServiceInterface;

  /// Registration options
  final RegistrationOptions registrationOptions;

  /// The page to navigate to after login
  final Widget afterLoginPageScreen;

  @override
  Widget build(BuildContext context) => RegistrationSuccess(
        translations: translations,
        onPressed: () async {
          if (userOptions.onRegistrationSuccess != null) {
            await userOptions.onRegistrationSuccess?.call();
          } else {
            await replace(
              context,
              LoginScreen(
                translations: translations,
                loginOptions: loginOptions,
                userOptions: userOptions,
                loginServiceInterface: loginServiceInterface,
                registrationOptions: registrationOptions,
                afterLoginPageScreen: afterLoginPageScreen,
              ),
            );
          }
        },
      );
}

/// Registration unsuccessfull screen
class RegistrationUnsuccessfullScreen extends StatelessWidget {
  /// Registration unsuccessfull screen constructor
  const RegistrationUnsuccessfullScreen({
    required this.userOptions,
    required this.translations,
    required this.error,
    super.key,
  });

  /// User options
  final FlutterUserOptions userOptions;

  /// Translations
  final FlutterUserTranslations translations;

  /// Error
  final String error;

  @override
  Widget build(BuildContext context) => RegistrationUnsuccessfull(
        translations: translations,
        error: error,
        onPressed: () async {
          if (userOptions.onRegistrationUnsuccessfull != null) {
            await userOptions.onRegistrationUnsuccessfull?.call();
          } else {
            Navigator.of(context).pop();
          }
        },
      );
}

/// Onboarding screen
class OnboardingScreen extends StatelessWidget {
  /// Onboarding screen constructor
  const OnboardingScreen({
    required this.userOptions,
    required this.afterLoginPageScreen,
    super.key,
  });

  /// User options
  final FlutterUserOptions userOptions;

  /// The page to navigate to after login
  final Widget afterLoginPageScreen;

  @override
  Widget build(BuildContext context) => Onboarding(
        onboardingFinished: (results) async {
          if (userOptions.onboardingFinished != null) {
            await userOptions.onboardingFinished?.call(results);
          } else {
            unawaited(showLoadingPopup(context));
            await userOptions.beforeOnboardingFinished?.call(results);
            if (context.mounted) {
              Navigator.of(context).pop();
              await replace(context, afterLoginPageScreen);
            }
          }
        },
      );
}

/// Pushes a new screen onto the stack.
Future<void> push(BuildContext context, Widget screen) async {
  await Navigator.of(context).push(
    MaterialPageRoute(
      builder: (context) => screen,
    ),
  );
}

/// Replaces the current screen with a new screen.
Future<void> replace(BuildContext context, Widget screen) async {
  await Navigator.of(context).pushReplacement(
    MaterialPageRoute(
      builder: (context) => screen,
    ),
  );
}
