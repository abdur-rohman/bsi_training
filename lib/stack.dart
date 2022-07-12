import 'package:flutter/material.dart';

class StackWidget extends StatelessWidget {
  const StackWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Stack"),
      ),
      body: Stack(
        children: [
          Container(color: Colors.red[400]),
          Container(
            color: Colors.white,
            margin: const EdgeInsets.all(16),
          ),
          Container(
            color: Colors.green[400],
            margin: const EdgeInsets.all(32),
          ),
          Positioned(
            top: 0,
            right: 0,
            child: Container(
              height: 48,
              width: 48,
              color: Colors.black,
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            child: Container(
              height: 48,
              width: 48,
              color: Colors.yellow[400],
            ),
          ),
          const Positioned(
            top: 0,
            left: 0,
            child: BSIButton(),
          ),
        ],
      ),
    );
  }
}

class BSIButton extends StatelessWidget {
  const BSIButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 32),
      decoration: BoxDecoration(
        color: Colors.blueGrey,
        borderRadius: BorderRadius.circular(8),
      ),
      child: const Center(
        child: Text(
          'Button Button Button Button Button',
          style: TextStyle(
            overflow: TextOverflow.ellipsis,
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
