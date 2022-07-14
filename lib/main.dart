import 'dart:typed_data';

import 'package:bsi_training/material_design.dart';
import 'package:bsi_training/signature.dart';
import 'package:bsi_training/stack.dart';
import 'package:bsi_training/state.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  String selectedOption = "";

  List<Widget> children = List.generate(
    1,
    (index) => Container(
      margin: EdgeInsets.only(bottom: 16),
      height: 156,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
    ),
  );

  Uint8List? _signatureBytes;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            const Text('You have pushed the button this many times:'),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
            SORadioButton(
              title: "Judul",
              subTitle: "Deskripsi",
              onChanged: (value) {
                if (value != null) {
                  selectedOption = value;
                  setState(() {});
                }
              },
              options: ["Ada", "Tidak ada"],
              selectedOption: selectedOption,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => StackWidget()),
                );
              },
              child: Text("Stack"),
            ),
            children.length > 1
                ? Expanded(child: CardSection(children: children))
                : CardSection(children: children),
            ElevatedButton(
              onPressed: () {
                Navigator.push<Uint8List>(
                  context,
                  MaterialPageRoute(builder: (_) => SignaturePage()),
                ).then((value) {
                  if (value != null) {
                    _signatureBytes = value;
                    setState(() {});
                  }
                });
              },
              child: Text("Singature"),
            ),
            if (_signatureBytes != null) Image.memory(_signatureBytes!),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => MaterialDesingPage()),
                );
              },
              child: Text("Material design"),
            ),
            ElevatedButton(
              onPressed: () async {
                var dio = Dio();

                try {
                  var response = await dio.post(
                    'https://phone-book-api.herokuapp.com/api/v1/signin',
                    data: {
                      "email": "l200140004@gmail.com",
                      "password": "l200140004"
                    },
                  );

                  String token = response.data['data']['token'] ?? '';
                  print('Token: $token');
                } catch (e, stackTrace) {
                  print("Error: $e");
                  print("Stack Trace: $stackTrace");
                }
              },
              child: Text("Login"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => LoginPage()),
                );
              },
              child: Text("Login"),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class CardSection extends StatelessWidget {
  final List<Widget> children;

  const CardSection({super.key, required this.children});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 24),
      padding: EdgeInsets.symmetric(vertical: 16, horizontal: 20),
      decoration: BoxDecoration(
        color: Color.fromRGBO(233, 233, 233, 1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Rabu, 3 Maret 2021'),
          SizedBox(height: 16),
          children.length > 1
              ? Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: children,
                    ),
                  ),
                )
              : children.first
        ],
      ),
    );
  }
}

class SORadioButton extends StatelessWidget {
  final String title, subTitle;
  final Function(String?) onChanged;
  final List<String> options;
  final String selectedOption;

  const SORadioButton({
    super.key,
    required this.title,
    required this.subTitle,
    required this.onChanged,
    required this.options,
    required this.selectedOption,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(title),
        Text(subTitle),
        Row(
          children: options
              .map(
                (value) => Expanded(
                  child: GestureDetector(
                    onTap: () {
                      onChanged(value);
                    },
                    child: Row(
                      children: [
                        Radio<String>(
                          value: value,
                          groupValue: selectedOption,
                          onChanged: onChanged,
                        ),
                        SizedBox(width: 4),
                        Text(value),
                      ],
                    ),
                  ),
                ),
              )
              .toList(),
        )
      ],
    );
  }
}
