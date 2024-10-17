# flutter_user Documentation

## Overview

flutter_user is a comprehensive Flutter package designed to simplify user authentication flows in your apps. It offers customizable screens and configurations for handling login, registration, password recovery (forgot password), and onboarding processes.

This package prioritizes flexibility and ease of integration, allowing developers to:

- Quickly incorporate user authentication with minimal setup.
- Tailor the user experience through extensive customization options.

## Table of Contents

1. Installation
2. Setup and Initialization
3. Main Components
   - FlutterUserNavigatorUserstory
   - User Repositories
4. Customization and Configuration
   - FlutterUserOptions
   - LoginOptions
   - ForgotPasswordOptions
   - RegistrationOptions
   - Translations
5. Callbacks and Error Handling
6. Example Usage
7. Advanced Customization
8. Troubleshooting
9. Contributing
10. Author

## Installation

To use flutter_user in your Flutter project, add it as a dependency in your `pubspec.yaml` file:

```yaml
dependencies:
  flutter_user:
    git:
      url: https://github.com/Iconica-Development/flutter_user
      ref: <Version>
      path: packages/flutter_user
```

Replace `<Version>` with the specific version or commit hash you want to use.

## Setup and Initialization

1. Ensure you have the necessary dependencies set up in your project, especially if you're integrating with a backend service like Firebase.
2. Import the `flutter_user` package in your Dart files:

```dart
import 'package:flutter_user/flutter_user.dart';
```

3. Initialize the `FlutterUserNavigatorUserstory` widget in your app's `MaterialApp` or `CupertinoApp`. This widget manages navigation between the authentication screens:

```dart
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Flutter User Example",
      home: FlutterUserNavigatorUserstory(
        afterLoginScreen: HomeScreen(),
        options: FlutterUserOptions(
          // Custom options go here
        ),
      ),
    );
  }
}
```

## Main Components

**1. FlutterUserNavigatorUserstory**

This is the core component of flutter_user. It manages navigation between various authentication screens like login, registration, forgot password, and onboarding.

**Key Properties:**

| Property          | Type                    | Description                                        | Default               |
| ----------------- | ----------------------- | -------------------------------------------------- | --------------------- |
| afterLoginScreen  | Widget                  | Screen to display after a successful login         | null (required)       |
| afterRegistration | Widget                  | Screen to display after successful registration    | null                  |
| userRepository    | UserRepositoryInterface | User repository handling authentication operations | LocalUserRepository() |
| options           | FlutterUserOptions      | Customization options for the user experience      | FlutterUserOptions()  |

**2. User Repositories**

flutter_user is designed to work with any backend by implementing the `UserRepositoryInterface`. This interface defines the necessary methods for user authentication operations.

**UserRepositoryInterface:**

Methods to implement:

- `Future<LoginResponse> loginWithEmailAndPassword({required String email, required String password});`
- `Future<RegistrationResponse> register({required Map<String, dynamic> values});`
- `Future<RequestPasswordResponse> requestChangePassword({required String email});`
- `Future<bool> logout();`
- `Future<bool> isLoggedIn();`
- `Future<dynamic> getLoggedInUser();`

**Default Implementation:**

- `LocalUserRepository`: A mock implementation useful for testing or offline scenarios.

**Example with Firebase:**

To use Firebase as your backend, implement the `UserRepositoryInterface` using `firebase_auth` and `cloud_firestore`:

```dart
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:user_repository_interface/user_repository_interface.dart';

class FirebaseUserRepository implements UserRepositoryInterface {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  @override
  Future<LoginResponse> loginWithEmailAndPassword({required String email, required String password}) {
    // Implement login logic using Firebase
  }

  // Implement other methods...
}
```

## Customization and Configuration

flutter_user provides extensive customization options to tailor the user interface and behavior to your application's needs.

### FlutterUserOptions

The `FlutterUserOptions` class centralizes customization for the user authentication flow.

**Properties:**

| Property              | Type                            | Description                                            | Default                   |
| --------------------- | ------------------------------- | ------------------------------------------------------ | ------------------------- |
| loginOptions          | `LoginOptions`                  | Customization options for the login screen             | `LoginOptions()`          |
| forgotPasswordOptions | `ForgotPasswordOptions`         | Customization options for the forgot password screen   | `ForgotPasswordOptions()` |
| registrationOptions   | `RegistrationOptions`           | Customization options for the registration screen      | `RegistrationOptions()`   |
| beforeLogin           | `Future<void> Function()`       | Callback before login attempt                          | `null`                    |
| afterLogin            | `Future<void> Function()`       | Callback after successful login                        | `null`                    |
| onRegister            | `Future<void> Function()`       | Callback after registration is completed               | `null`                    |
| useOnboarding         | `bool`                          | Whether to use the onboarding process                  | `false`                   |
| onOnboardingComplete  | `Future<void> Function()`       | Callback after onboarding is completed                 | `null`                    |
| onForgotPassword      | `Future<void> Function(String)` | Callback when the forgot password process is initiated | `null`                    |

### LoginOptions

Customize the login screen's appearance and behavior.

**Key Properties:**

- `initialEmail`: Pre-fill the email input field. (String)
- `initialPassword`: Pre-fill the password input field. (String)
- `emailDecoration`: Input decoration for the email field. (InputDecoration)
- `passwordDecoration`: Input decoration for the password field. (InputDecoration)
- `emailTextAlign`: Text alignment for the email field. (TextAlign)
- `passwordTextAlign`: Text alignment for the password field. (TextAlign)
- `loginButtonBuilder`: Custom builder for the login button. (Widget Function(BuildContext context, VoidCallback onPressed, bool disabled, VoidCallback onDisabledPress, FlutterUserOptions options))
- `forgotPasswordButtonBuilder`: Custom builder for the forgot password button. (Widget Function(BuildContext context, VoidCallback onPressed))
- `registrationButtonBuilder`: Custom builder for the registration button. (Widget Function(BuildContext context, VoidCallback onPressed))
- `image`: Widget to display an image or logo on the login screen. (Widget)
- `spacers`: `LoginSpacerOptions` to adjust spacing between elements. (LoginSpacerOptions)

### ForgotPasswordOptions

Customize the forgot password screen's appearance and behavior.

**Key Properties:**

- `forgotPasswordBackgroundColor`: Background color of the screen. (Color)
- `forgotPasswordCustomAppBar`: Custom app bar widget. (Widget)
- `forgotPasswordScreenPadding`: Padding for the screen content. (EdgeInsets)
- `forgotPasswordSpacerOptions`: Adjust spacing using `ForgotPasswordSpacerOptions`. (ForgotPasswordSpacerOptions)
- `translations`: Provide custom text via `ForgotPasswordTranslations`. (ForgotPasswordTranslations)
- `requestForgotPasswordButtonBuilder`: Custom builder for the reset password button. (Widget Function(BuildContext context, VoidCallback onPressed))

### RegistrationOptions

Customize the registration process.

**Key Properties:**

- `steps`: Define multi-step registration fields. (List<RegistrationStep>)
- `translations`: Provide custom text via `RegistrationTranslations`. (RegistrationTranslations)
- `customAppbarBuilder`: Custom app bar for the registration screen. (Widget Function(BuildContext context))
- `title`: Widget for the registration screen title. (Widget)
- `spacerOptions`: Adjust spacing using `RegistrationSpacerOptions`. (RegistrationSpacerOptions)
- `previousButtonBuilder`: Custom builder for the “Previous” button. (Widget Function(BuildContext context, VoidCallback onPressed))
- `nextButtonBuilder`: Custom builder for the “Next” button. (Widget Function(BuildContext context, VoidCallback onPressed))
- `loginButton`: Widget to navigate back to the login screen. (Widget)

### Translations

Localization support is provided through translation classes:

- `LoginTranslations`: Customize text for login screens.
- `ForgotPasswordTranslations`: Customize text for forgot password screens.
- `RegistrationTranslations`: Customize text for registration screens.

## Callbacks and Error Handling

### Callbacks

flutter_user provides various callbacks to gracefully handle user actions and errors.

| Callback                        | Description                                                 |
| ------------------------------- | ----------------------------------------------------------- |
| `beforeLogin`                   | Called before the login attempt is made.                    |
| `afterLogin`                    | Called after a successful login.                            |
| `onRegister`                    | Called after the registration process is completed.         |
| `onForgotPassword`              | Called when the user initiates the forgot password process. |
| `onRequestForgotPassword`       | Called after the forgot password request is completed.      |
| `onForgotPasswordSuccess`       | Called after a successful password reset request.           |
| `onForgotPasswordUnsuccessful`  | Called when the password reset request fails.               |
| `onRegistrationError`           | Called when registration fails.                             |
| `afterRegistration`             | Called after the registration process.                      |
| `afterRegistrationSuccess`      | Called after successful registration.                       |
| `afterRegistrationUnsuccessful` | Called when registration is unsuccessful.                   |

### Error Handling

- **Validation Errors:**

  - Utilize the built-in `LoginValidationService` or `RegistrationValidationService` for validation.
  - Alternatively, provide custom validators for specific needs.

- **Repository Errors:**
  - Implement proper error handling in your user repository classes.
  - Utilize the provided `UserError` model for consistent error reporting.

## Example Usage

This example demonstrates setting up `flutter_user` with custom options and integrating it into your app.

```dart
import 'package:flutter/material.dart';
import 'package:flutter_user/flutter_user.dart';
import 'package:user_repository_interface/user_repository_interface.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // Define your home screen after login
  Widget get homeScreen => const HomeScreen();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter User Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: FlutterUserNavigatorUserstory(
        afterLoginScreen: homeScreen,
        options: FlutterUserOptions(
          loginOptions: LoginOptions(
            initialEmail: 'user@example.com',
            emailDecoration: const InputDecoration(
              labelText: 'Email',
            ),
            passwordDecoration: const InputDecoration(
              labelText: 'Password',
            ),
            image: Image.asset('assets/logo.png'),
          ),
          registrationOptions: RegistrationOptions(
            steps: [
              // Add more steps if necessary
            ],
          ),
          afterLogin: () async {
            // Navigate to a different screen or perform other actions
          },
          useOnboarding: true,
        ),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Your home screen content
    );
  }
}
```

## Advanced Customization

### Custom Widgets and Builders

For more control over UI components, provide custom widgets and builders in the options classes.

**Example: Custom Login Button Builder**

```dart
loginOptions: LoginOptions(
  loginButtonBuilder: (context, onPressed, disabled, onDisabledPress, options) {
    return ElevatedButton(
      onPressed: disabled ? null : onPressed,
      child: Text('Sign In'),
    );
  },
)
```

## Troubleshooting

### Common Issues

- **Firebase Setup:** Ensure Firebase is correctly configured in your Flutter app. Refer to the official Firebase Flutter setup guide for instructions.
- **Dependency Conflicts:** Check for version conflicts between dependencies, especially between `firebase_auth` and `cloud_firestore`.
- **Validation Errors:** If custom validation isn't working as expected, verify that your custom validation service is correctly implemented and assigned in the `LoginOptions`.

### Tips

- **Logging:** Utilize Flutter's debugging tools and print statements to trace issues during development.
- **Error Messages:** Pay close attention to error messages returned by the user repository. These messages can help identify and resolve issues promptly.

## Contributing

We welcome contributions to improve `flutter_user`, whether it's enhancing documentation, fixing bugs, or adding new features. Please follow the Contribution Guide and submit your pull requests on GitHub.

## Author

flutter_user is developed and maintained by Iconica. For questions, support, or commercial inquiries, please contact them at support@iconica.nl.
