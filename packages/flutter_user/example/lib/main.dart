import 'package:example/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_user/flutter_user.dart';

void main(List<String> args) {
  runApp(const MyApp());
}

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

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            await Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const FlutterUserNavigatorUserstory(
                    afterLoginScreen: Home(),
                  ),
                ));
          },
          child: const Text("Logout"),
        ),
      ),
    );
  }
}
