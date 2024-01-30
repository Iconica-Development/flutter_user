import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_user/flutter_user.dart';
import 'package:go_router/go_router.dart';

void main(List<String> args) {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _router(context),
    );
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          child: const Text('Go to Login'),
          onPressed: () {
            context.go(AuthUserStoryRoutes.loginScreen);
          },
        ),
      ),
    );
  }
}

GoRouter _router(BuildContext context) => GoRouter(
      routes: [
        GoRoute(
          path: '/',
          builder: (BuildContext context, GoRouterState state) {
            return const Home();
          },
        ),
        ...getStartStoryRoutes(configuration(context)),
      ],
      initialLocation: AuthUserStoryRoutes.onboarding,
    );

AuthUserStoryConfiguration configuration(BuildContext context) =>
    AuthUserStoryConfiguration(
      onLogin: (password, email, context) {
        debugPrint('onLogin: $password, $email');
        context.go(AuthUserStoryRoutes.onboarding);
      },
      onboardingConfiguration: OnboardingConfiguration(
        onboardingFinished: (results, context) {
          debugPrint('onboardingFinished: $results');
          context.go('/');
        },
      ),
      loginOptions: loginOptions,
      registrationOptions: (context) => getRegistrationOptions(context),
      useRegistration: true,
      onRequestForgotPassword: (p0) {},
      forgotPasswordTitle: const Center(child: Text('Forgot password')),
      forgotPasswordDescription:
          const Center(child: Text('Forgot password description')),
    );
final loginOptions = LoginOptions(
  emailDecoration: const InputDecoration(
    prefixIcon: Icon(Icons.email),
    border: OutlineInputBorder(),
  ),
  passwordDecoration: const InputDecoration(
    prefixIcon: Icon(Icons.password),
    border: OutlineInputBorder(),
  ),
  title: const Text('Login Demo'),
  image: const FlutterLogo(
    size: 200,
  ),
  requestForgotPasswordButtonBuilder: (
    context,
    onPressed,
    isDisabled,
    onDisabledPress,
    translations,
  ) {
    return Opacity(
      opacity: isDisabled ? 0.5 : 1.0,
      child: ElevatedButton(
        onPressed: isDisabled ? onDisabledPress : onPressed,
        child: const Text('Send request'),
      ),
    );
  },
);

getRegistrationOptions(BuildContext context) => RegistrationOptions(
      registrationRepository: ExampleRegistrationRepository(),
      registrationSteps: RegistrationOptions.getDefaultSteps(),
      afterRegistration: () {
        context.go(AuthUserStoryRoutes.onboarding);
      },
    );

class ExampleRegistrationRepository with RegistrationRepository {
  @override
  Future<String?> register(HashMap values) {
    debugPrint('register: $values');
    return Future.value(null);
  }
}
