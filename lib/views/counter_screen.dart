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
  bool _isConnected = false;
  bool _isEmpty = true;
  String targetDevice = 'beb5483e-36e1-4688-b7f5-ea07361b26a8';

  Future discoverServices() async {
    _service = await widget.device.discoverServices();
    setState(() {
      _isEmpty = false;
    });
  }

  Future onConnect() async {
    await widget.device.connect(timeout: Duration(seconds: 5));
    setState(() {
      _isConnected = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: _isConnected ? Text('Terhubung') : Text('Tidak Terhubung'),
      ),
      body: Center(
        child: Column(children: [
          FloatingActionButton(
              onPressed: onConnect, child: Icon(Icons.bluetooth_connected)),
          TextButton(
            onPressed: () {
              discoverServices();
            },
            child: Text(
              widget.device.platformName.toString(),
            ),
          ),
          Text(_isEmpty ? 'Gada data' : 'Ada data ${_service.length}'),
          Text(_isEmpty ? 'Maklo' : 'data ${_service[2].serviceUuid}'),
          // ListView.builder(
          //   itemCount: _service.length,
          //   itemBuilder: (BuildContext context, index) {
          //     return Text('Ini datanya bang : ${_service[index].serviceUuid}');
          //   },
          // )
        ]),
      ),
    );
  }
}
