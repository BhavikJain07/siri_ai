import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text("Welcome to No Code AI Model Maker")),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          context.go("/home");
        },
        label: Text("Get Started"),
      ),
    );
  }
}
