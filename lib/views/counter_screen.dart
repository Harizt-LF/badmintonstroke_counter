import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

class CounterScreen extends StatefulWidget {
  const CounterScreen({super.key, required this.device});

  final BluetoothDevice device;

  @override
  State<CounterScreen> createState() => _CounterScreenState();
}

class _CounterScreenState extends State<CounterScreen> {
  List<BluetoothService> _service = [];
  bool _isDiscoveringServices = false;
  bool _isConnecting = false;
  String targetDevice = 'beb5483e-36e1-4688-b7f5-ea07361b26a8';

  Future discoverServices() async {
    _service = await widget.device.discoverServices();
    print(_service);
  }

  @override
  Widget build(BuildContext context) {
    discoverServices();
    return Scaffold(
        body: Center(child: Text(widget.device.platformName.toString())));
  }
}
