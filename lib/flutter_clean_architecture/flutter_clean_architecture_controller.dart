import 'package:bsi_training/main.dart';
import 'package:bsi_training/navigator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

class FlutterCleanArchitectureController extends Controller {
  int _counter = 0;
  int get counter => _counter;
  bool _isLoading = false;
  List<Object> _contacts = [];

  @override
  void initListeners() {}

  void incrementCounter() {
    _counter++;
    refreshUI();
  }

  void getMyContacts() {
    _isLoading = true;
    refreshUI();

    // Fetch API / Get My Contact from API
    _contacts = [];

    _isLoading = false;
    refreshUI();
  }

  void navigateToRegisterPage() {
    var context = getContext();
    Navigator.pushNamed(
      context,
      RegisterPage.route,
      arguments: RegisterArguments(text: '', number: 0, isActive: false),
    );
  }
}
