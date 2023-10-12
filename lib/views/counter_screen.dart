import 'dart:async';
import 'dart:convert';

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
  late StreamSubscription<List<int>> _lastValueSubscription;
  List<int> _value = [];
  var nilai = '';
  bool _isDiscoveringServices = false;
  bool _isConnecting = false;
  bool _isConnected = false;
  bool _isEmpty = true;
  bool _dataIsEmpty = true;
  var _actualValue = '';
  String targetDevice = 'beb5483e-36e1-4688-b7f5-ea07361b26a8';

  // @override
  // void initState() {
  //   super.initState();
  //   _lastValueSubscription =
  //       _service[2].characteristics[0].lastValueStream.listen((value) {
  //     _value = value;
  //     setState(() {});
  //   });
  // }

  // @override
  // void dispose() {
  //   _lastValueSubscription.cancel();
  //   super.dispose();
  // }

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

  Future read() async {
    final utf8Decoder = utf8.decoder;
    _value = await _service[2].characteristics[0].read();
    _actualValue = utf8Decoder.convert(_value);
    setState(() {
      _dataIsEmpty = false;
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
          Text(_isEmpty
              ? ''
              : 'banyak characteristic : ${_service[2].characteristics.length}'),
          TextButton(onPressed: read, child: Text('Cari value')),
          Text(_dataIsEmpty == false ? 'data ${_actualValue}' : 'No data')
          //TextButton(onPressed: read, child: Text('Read Data : ${_value.}')),
          // Text(_dataIsEmpty ? 'Data kosong ' : 'data : ${nilai.toString()}')
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
