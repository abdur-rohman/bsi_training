import 'package:bsi_training/main.dart';
import 'package:flutter/material.dart';

class NavigatorPage extends StatelessWidget {
  final String backButtonText;

  NavigatorPage({Key? key, required this.backButtonText}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Next Page')),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(backButtonText),
        ),
      ),
    );
  }
}

class RegisterPage extends StatelessWidget {
  final RegisterArguments arguments;

  static const route = "/register";

  const RegisterPage({super.key, required this.arguments});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(arguments.text),
      ),
    );
  }
}
