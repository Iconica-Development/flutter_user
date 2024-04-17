# flutter_user

Flutter_user is a package that provides screens for login, registration, forgotPassword and onboarding.

## Setup

To use this package, add flutter_user as a dependency in your pubspec.yaml file:

```
  flutter_user:
    git:
      url: https://github.com/Iconica-Development/flutter_user
      ref: <Version>
```

To use the module within your Flutter-application with predefined `Go_router` routes you should add the following:

Add go_router as dependency to your project.
Add the following configuration to your flutter_application:

```
AuthUserStoryConfiguration authUserStoryConfiguration = const AuthUserStoryConfiguration();
```

and set the values as you wish.

Next add the `AuthUserStoryConfiguration` to `getAuthStoryRoutes` Like so:

```
List<GoRoute> getUserRoutes() => getAuthStoryRoutes(
      authUserStoryConfiguration,
    );
```

Finally add the `getUserRoutes` to your `Go_router` routes like so:

```
final GoRouter _router = GoRouter(
  routes: <RouteBase>[
    ...getUserRoutes()
  ],
);
```

The routes that can be used to navigate are:

For routing to the `LoginScreen`:

```
  static const String loginScreen = '/loginScreen';
```

For routing to the `RegistrationScreen`:

```
  static const String registrationScreen = '/registrationScreen';
```

For routing to the `ForgotPasswordScreen`:

```
  static const String forgotPasswordScreen = '/forgotPasswordScreen';
```

For routing to the `Onboarding`:

```
  static const String onboarding = '/onboarding';
```

The `AuthUserStoryConfiguration` has its own parameters, as specified below:
| Parameter | Explanation |
|-----------|-------------|
| loginPageBuilder | The builder for the loginPage. |
| registrationPageBuilder | The builder for the registrationPage. |
| forgotPasswordBuilder | The builder for the forgotPasswordPage. |
| beforeRegistrationPage | The builder for the beforeRegistrationPage. |
| afterRegistrationPage | The builder for the afterRegistrationPage. |
| afterLoginPage | The builder for the afterLoginPage. |
| pageOverlayBuilder | This can be used to show something above the other pages. For instance to indicate that there is no internet. |
| loginServiceBuilder | The login service to use. |
| afterLoginRoute | The route to go to after the user logs in. |
| loginOptionsBuilder | Options for the login screen. |
| registrationOptionsBuilder | Options for the registration screen. |
| useRegistration | Whether to use the registration screen. |
| useOnboarding | Whether to use the onboarding screen. |
| showForgotPassword | Whether to show the forgot password button. |

The `OnboardingConfiguration` has its own parameters, as specified below:
| Parameter | Explanation |
|-----------|-------------|
| onboardingFinished              | Called when the user finishes the onboarding.             |
| onboardingOnNext                | Called when the user goes to the next page in the onboarding.|

## Issues

Please file any issues, bugs or feature request as an issue on our [GitHub](https://github.com/Iconica-Development/flutter_user) page. Commercial support is available if you need help with integration with your app or services. You can contact us at [support@iconica.nl](mailto:support@iconica.nl).

## Want to contribute
[text](about:blank#blocked)
If you would like to contribute to the plugin (e.g. by improving the documentation, solving a bug or adding a cool new feature), please carefully review our [contribution guide](./CONTRIBUTING.md) and send us your [pull request](https://github.com/Iconica-Development/flutter_user/pulls).

## Author

This flutter_user for Flutter is developed by [Iconica](https://iconica.nl). You can contact us at <support@iconica.nl>
