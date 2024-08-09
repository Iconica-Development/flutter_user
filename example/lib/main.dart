// import 'dart:collection';
// import 'dart:typed_data';

// import 'package:flutter/material.dart';
// import 'package:flutter_user/flutter_user.dart';
// import 'package:go_router/go_router.dart';

// void main(List<String> args) {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) => MaterialApp.router(
//         routerConfig: _router(context),
//       );
// }

// class Home extends StatelessWidget {
//   const Home({super.key});

//   @override
//   Widget build(BuildContext context) => Scaffold(
//         appBar: AppBar(
//           title: const Text('Home'),
//         ),
//         body: Center(
//           child: ElevatedButton(
//             onPressed: () {
//               context.go('/login');
//             },
//             child: const Text('Login'),
//           ),
//         ),
//       );
// }

// class AfterLogin extends StatelessWidget {
//   const AfterLogin({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const Scaffold(
//       body: Center(
//         child: Text('After login'),
//       ),
//     );
//   }
// }

// GoRouter _router(BuildContext context) => GoRouter(
//       routes: [
//         GoRoute(
//           path: '/',
//           builder: (BuildContext context, GoRouterState state) {
//             return const Home();
//           },
//         ),
//         ...getAuthStoryRoutes(configuration(context)),
//         GoRoute(
//             path: '/afterlogin',
//             builder: (context, state) {
//               return const AfterLogin();
//             }),
//       ],
//     );

// class ExampleLoginService implements LoginServiceInterface {
//   AuthUser user = AuthUser();
//   @override
//   Future getLoggedInUser() {
//     return Future.value(AuthUser(
//       onboarded: false,
//     ));
//   }

//   @override
//   Future<LoginResponse<dynamic>> loginWithEmailAndPassword(
//       String email, String password, BuildContext context,
//       {Function(dynamic resolver)? onMFA}) async {
//     return const LoginResponse<dynamic>(
//         loginSuccessful: true, userObject: null);
//   }

//   @override
//   Future<bool> logout(BuildContext context) {
//     return Future.value(true);
//   }

//   @override
//   Future<RequestPasswordResponse> requestChangePassword(
//       String email, BuildContext context) {
//     return Future.value(const RequestPasswordResponse(
//       requestSuccesfull: true,
//     ));
//   }
// }

// AuthUserStoryConfiguration configuration(BuildContext context) =>
//     AuthUserStoryConfiguration(
//       afterLoginRoute: '/afterlogin',
//       afterLoginPage: (context) =>
//           const Scaffold(body: Center(child: Text('After login'))),
//       useOnboarding: true,
//       loginServiceBuilder: (context) => ExampleLoginService(),
//       onLogin: (password, email, context) {
//         debugPrint('on<L<GoRou> ()>: $password, $email');
//       },
//       onboardingConfiguration: OnboardingConfiguration(
//         onboardingFinished: (results, context) {
//           context.go('/login');
//         },
//       ),
//       loginOptionsBuilder: (_) => loginOptions,
//       useRegistration: true,
//       onRequestForgotPassword: (p0, context) {},
//       forgotPasswordTitle: (context) =>
//           const Center(child: Text('Forgot password')),
//       forgotPasswordDescription: (context) =>
//           const Center(child: Text('Forgot password description')),
//     );
// final loginOptions = LoginOptions(
//   emailDecoration: const InputDecoration(
//     prefixIcon: Icon(Icons.email),
//     border: OutlineInputBorder(),
//   ),
//   passwordDecoration: const InputDecoration(
//     prefixIcon: Icon(Icons.password),
//     border: OutlineInputBorder(),
//   ),
//   title: const Text('Login Demo'),
//   image: const FlutterLogo(
//     size: 200,
//   ),
//   requestForgotPasswordButtonBuilder: (
//     context,
//     onPressed,
//     isDisabled,
//     onDisabledPress,
//     translations,
//   ) {
//     return Opacity(
//       opacity: isDisabled ? 0.5 : 1.0,
//       child: ElevatedButton(
//         onPressed: isDisabled ? onDisabledPress : onPressed,
//         child: const Text('Send request'),
//       ),
//     );
//   },
// );

// class ExampleRegistrationRepository with RegistrationRepository {
//   @override
//   Future<String?> register(HashMap values) {
//     debugPrint('register: $values');
//     return Future.value(null);
//   }
// }

// class AuthUser implements User, OnboardedUserMixin {
//   AuthUser({
//     this.firstName,
//     this.image,
//     this.imageUrl,
//     this.lastName,
//     this.profileData,
//     this.onboarded = false,
//   });

//   factory AuthUser.fromMap(Map<String, dynamic> data) => AuthUser(
//         firstName: data['first_name'],
//         lastName: data['last_name'],
//         image: data['image'],
//         imageUrl: data['image_url'],
//         profileData: data['profile_data'],
//         onboarded: data['onboarded'],
//       );
//   @override
//   String? firstName;

//   @override
//   Uint8List? image;

//   @override
//   String? imageUrl;

//   @override
//   String? lastName;

//   @override
//   ProfileData? profileData;

//   @override
//   String get displayName => '${firstName ?? ''} ${lastName ?? ''}';

//   @override
//   String get initials =>
//       '${(firstName?.isNotEmpty ?? false) ? firstName![0] : ''}'
//       '${(lastName?.isNotEmpty ?? false) ? lastName![0] : ''}';

//   @override
//   Map<String, dynamic> toMap() => {
//         'first_name': firstName,
//         'last_name': lastName,
//         'image': image,
//         'image_url': image,
//         'profile_data': profileData?.toMap(),
//         'onboarded': onboarded,
//       };

//   @override
//   bool onboarded;
// }
