import 'package:bsi_training/flutter_clean_architecture/flutter_clean_architecture_controller.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:flutter/material.dart';

class FlutterCleanArchitectureView extends View {
  @override
  State<StatefulWidget> createState() => FlutterCleanArchitectureState(
        FlutterCleanArchitectureController(),
      );
}

class FlutterCleanArchitectureState extends ViewState<
    FlutterCleanArchitectureView, FlutterCleanArchitectureController> {
  final FlutterCleanArchitectureController _controller;

  FlutterCleanArchitectureState(this._controller) : super(_controller);

  @override
  Widget get view => Scaffold(
        key: globalKey,
        appBar: AppBar(title: Text('Counter')),
        body: Container(
          width: double.maxFinite,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Counter:'),
              // Hanya bagian ini saja yang berubah
              ControlledWidgetBuilder<FlutterCleanArchitectureController>(
                builder: (context, controller) => Text(
                  controller.counter.toString(),
                ),
              )
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _controller.navigateToRegisterPage,
          tooltip: 'Increment',
          child: const Icon(Icons.add),
        ),
      );
}
