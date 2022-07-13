import 'package:flutter/material.dart';
import 'package:signature/signature.dart';

class SignaturePage extends StatelessWidget {
  SignaturePage({Key? key}) : super(key: key);

  final SignatureController _controller = SignatureController(
    penStrokeWidth: 4,
    penColor: Colors.red,
    exportBackgroundColor: Colors.transparent,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () async {
                try {
                  var bytes = await _controller.toPngBytes();
                  Navigator.pop(context, bytes);
                } catch (e, stackTrace) {
                  print("Error: $e");
                  print("Stack Trace: $stackTrace");
                }
              },
              icon: Icon(
                Icons.check_circle_outline,
                color: Colors.green,
              ))
        ],
      ),
      body: Signature(controller: _controller),
    );
  }
}
