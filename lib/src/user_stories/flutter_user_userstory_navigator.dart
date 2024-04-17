import 'package:flutter/material.dart';
import 'package:flutter_user/flutter_user.dart';
import 'package:flutter_user/src/services/example_registration_service.dart';
import 'package:flutter_user/src/utils/is_keyboard_closed.dart';
import 'package:flutter_user/src/widgets/onboarding.dart';

Widget authNavigatorUserstory(
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
                  backgroundColor:
                      configuration.loginErrorSnackbarBackgroundColor ??
                          theme.colorScheme.onBackground,
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        result.loginError!.title,
                        style: configuration.loginErrorSnackbarTitleTextStyle ??
                            theme.textTheme.titleSmall?.copyWith(
                              color: theme.colorScheme.background,
                            ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        result.loginError!.message,
                        style:
                            configuration.loginErrorSnackbarMessageTextStyle ??
                                theme.textTheme.bodySmall?.copyWith(
                                  color: theme.colorScheme.background,
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
                    await Navigator.of(context).push(
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
                  await Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) =>
                          _forgotPasswordScreen(configuration, context),
                    ),
                  );
              }
            : null,
        options: configuration.loginOptionsBuilder?.call(context) ??
            LoginOptions.defaults(),
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
        backgroundColor: const Color(0xffFAF9F6),
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
                RegistrationOptions.defaults(
                  context,
                  configuration.registrationRepository ??
                      ExampleRegistrationRepository(),
                  () async => Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) =>
                          configuration.useAfterRegistrationPage
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
        appBar: AppBar(
          backgroundColor: const Color(0xffFAF9F6),
        ),
        backgroundColor: const Color(0xffFAF9F6),
        body: SafeArea(
          child: registrationScreen,
        ),
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
            LoginOptions.defaults(),
        description: configuration.forgotPasswordDescription?.call(context) ??
            const Text(
              'No worries. Enter your email address below so we can'
              ' send you a link to reset your password.',
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16),
            ),
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
        title: configuration.forgotPasswordTitle?.call(context) ??
            const Text(
              'Forgot Password',
              style: TextStyle(
                color: Color(0xff71C6D1),
                fontWeight: FontWeight.w800,
                fontSize: 24,
              ),
            ),
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
        appBar: AppBar(),
        body: SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 60),
              child: forgotPasswordScreen,
            ),
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
    configuration.afterRegistrationPage?.call(context) ??
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
                    await Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) =>
                            _loginScreen(configuration, context),
                      ),
                    );
                  },
                  child: Container(
                    height: 44,
                    width: 254,
                    decoration: const BoxDecoration(
                      color: Color(0xff71C6D1),
                      borderRadius: BorderRadius.all(Radius.circular(20)),
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
              ],
            ),
          ),
        ),
      ),
    );
