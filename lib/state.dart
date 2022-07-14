import 'package:flutter/material.dart';

/* urutan lifecycle state (yg sering dipakai)
  - createstate -> membuat state baru pada halaman
  - initState -> selesai membuat state
  - build -> rendering
  - dispose -> state sudah dibuang dari halaman
 */

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var _isLogged = true;

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration(milliseconds: 5), () {
      if (_isLogged) {
        Navigator.push(context, MaterialPageRoute(builder: (_) => HomePage()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Text('ini adalah halaman login'),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Text('ini adalah halaman home'),
    );
  }
}
