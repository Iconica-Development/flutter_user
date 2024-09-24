# flutter_user

Flutter_user is a package that provides screens for login, registration, forgotPassword and onboarding.

## Setup

To use this package, add flutter_user as a dependency in your pubspec.yaml file:

```
  flutter_user:
    git:
      url: https://github.com/Iconica-Development/flutter_user
      ref: <Version>
      path: packages/flutter_user
```

## Usage

To use this package, import the library and add the `FlutterUserNavigatorUserstory` widget to your app like so:

```dart
import 'package:flutter_user/flutter_user.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "flutter_user Example",
      theme: theme,
      home: const FlutterUserNavigatorUserstory(
        afterLoginScreen: Home(),
      ),
    );
  }
}
```

The userstory has a few properties that you can set to customize the user experience:

| Property | Description | Default |
| --- | --- | --- |
| `afterLoginScreen` | The screen that is shown after a successful login | `null` |
| `afterRegistration` | The screen that is shown after a successful registration | `null` |
| `userRepository` | The repository that is used to store the user data | `LocalUserRepository` |
| `options` | The options that are used to customize the user experience | `FlutterUserOptions` |
| `forgotPasswordTranslations` | The translations that are used for the forgot password screen | `ForgotPasswordTranslations` |
| `registrationOptions` | The options that are used to customize the registration experience | `RegistrationOptions` |

The `UserRepository` is an abstract class that you can implement to handle user requests. The `LocalUserRepository` is a simple implementation that handles the requests locally.

## FlutterUserOptions

| Property | Description | Default |
| --- | --- | --- |
| `loginOptions` | The options that are used to customize the login experience | `LoginOptions` |
| `loginTranslations` | The translations that are used for the login screen | `LoginTranslations` |
| `forgotPasswordTranslations` | The translations that are used for the forgot password screen | `ForgotPasswordTranslations` |
| `registrationOptions` | The options that are used to customize the registration experience | `RegistrationOptions` |
| `beforeLogin` | A callback that is called before the login attempt is made | `null` |
| `afterLogin` | A callback that is called after a successful login | `null` |
| `onBoardedUser` | expects a `OnboardedUser` mixin to be returned when you want to have onboarding | `null` |
| `useOnboarding` | A boolean that is used to determine if onboarding is used | `false` |
| `onOnboardingComplete` | A callback that is called after the onboarding is completed | `null` |
| `onRegister` | A callback that is called after the registration is completed | `null` |
| `onForgotPassword` | A callback that is called after the forgot password is completed | `null` |
| `onRequestForgotPassword` | A callback that is called after the forgot password request is completed | `null` |
| `onForgotPasswordSuccess` | A callback that is called after the forgot password is successful | `null` |
| `onForgotPasswordUnsuccessful` | A callback that is called after the forgot password is unsuccessful | `null` |
| `onRegistrationError` | A callback that is called after the registration is unsuccessful | `null` |
| `afterRegistration` | A callback that is called after the registration is completed | `null` |
| `afterRegistrationSuccess` | A callback that is called after the registration is successful | `null` |
| `afterRegistrationUnsuccessful` | A callback that is called after the registration is unsuccessful | `null` |


## Issues

Please file any issues, bugs or feature request as an issue on our [GitHub](https://github.com/Iconica-Development/flutter_user) page. Commercial support is available if you need help with integration with your app or services. You can contact us at [support@iconica.nl](mailto:support@iconica.nl).

## Want to contribute
[text](about:blank#blocked)
If you would like to contribute to the plugin (e.g. by improving the documentation, solving a bug or adding a cool new feature), please carefully review our [contribution guide](./CONTRIBUTING.md) and send us your [pull request](https://github.com/Iconica-Development/flutter_user/pulls).

## Author

This flutter_user for Flutter is developed by [Iconica](https://iconica.nl). You can contact us at <support@iconica.nl>
