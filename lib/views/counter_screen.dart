import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

class CounterScreen extends StatefulWidget {
  const CounterScreen(
      {super.key, required this.device, required this.SessionName});

  final BluetoothDevice device;
  final String SessionName;

  @override
  State<CounterScreen> createState() => _CounterScreenState();
}

class _CounterScreenState extends State<CounterScreen> {
  List<BluetoothService> _service = [];
  late StreamSubscription<List<int>> _lastValueSubscription;
  List<int> _value = [];
  int _counterDrive = 0;
  int _counterSmash = 0;
  int _counterService = 0;
  String Drive = 'DRIVE FOREHAND';
  String Smash = 'SMASH';
  String Service = 'SERVICE';
  var nilai = '';
  bool _isDiscoveringServices = false;
  bool _isConnecting = false;
  bool _isConnected = false;
  bool _isEmpty = true;
  bool _dataIsEmpty = true;
  bool _isResume = true;
  var _actualValue = '';

  @override
  void initState() {
    super.initState();
    allInOne();
  }

  @override
  void dispose() {
    _lastValueSubscription.cancel();
    widget.device.disconnect();
    print("Laman ini ditutup");
    super.dispose();
  }

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

  // Future read() async {
  //   final utf8Decoder = utf8.decoder;
  //   _value = await _service[2].characteristics[0].read();
  //   _actualValue = utf8Decoder.convert(_value);
  //   setState(() {
  //     _dataIsEmpty = false;
  //   });
  // }

  Future allInOne() async {
    final utf8Decoder = utf8.decoder;
    await widget.device.connect(timeout: Duration(seconds: 5));
    _service = await widget.device.discoverServices();
    setState(() {
      _isConnected = true;
      _isEmpty = false;
    });
    await _service[2].characteristics[0].setNotifyValue(true);
    final _lastValueSubscription =
        _service[2].characteristics[0].lastValueStream.listen((value) {
      _value = value;
      _actualValue = utf8Decoder.convert(_value);
      if (_actualValue.toString().contains(Drive)) {
        _counterDrive = _counterDrive + 1;
      } else if (_actualValue.toString().contains(Smash)) {
        _counterSmash = _counterSmash + 1;
      } else if (_actualValue.toString().contains(Service)) {
        _counterService = _counterService + 1;
      }
      setState(() {
        _counterDrive = _counterDrive;
        _counterSmash = _counterSmash;
        _counterService = _counterService;
        _dataIsEmpty = false;
      });
    });
  }

  Future stop() async {
    await _service[2].characteristics[0].setNotifyValue(false);
    setState(() {
      _isResume = false;
    });
  }

  Future resume() async {
    await _service[2].characteristics[0].setNotifyValue(true);
    setState(() {
      _isResume = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: Padding(
            padding: EdgeInsets.only(left: 20),
            child: CircleAvatar(
                backgroundColor: _isConnected ? Colors.blue : Colors.red),
          ),
          title: Text(widget.SessionName.toString()),
          centerTitle: true,
          backgroundColor: const Color(0xFF299046)),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 20),
                  MoveCounter(
                    counterSmash: _counterSmash,
                    moveName: 'SMASH',
                  ),
                  SizedBox(height: 20),
                  MoveCounter(
                    counterSmash: _counterDrive,
                    moveName: 'FOREHAND DRIVE',
                  ),
                  SizedBox(height: 20),
                  MoveCounter(
                    counterSmash: _counterService,
                    moveName: 'SERVE',
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      FloatingActionButton(
                          onPressed: () {
                            if (_isResume) {
                              stop();
                            } else {
                              resume();
                            }
                          },
                          child: _isResume
                              ? Icon(Icons.pause)
                              : Icon(Icons.play_arrow)),
                      FloatingActionButton(
                          onPressed: () {
                            if (_isResume == false) {
                              //popup dialog error
                            } else {
                              //fungsi untuk push data ke database
                            }
                          },
                          child: Icon(Icons.check))
                    ],
                  ),
                  Text('Gerakan sekarang : $_actualValue'),
                  // Text(widget.SessionName.toString()),
                  // Text(_isEmpty ? 'Gada data' : 'Ada data ${_service.length}'),
                  // Text(_isEmpty ? 'Maklo' : 'data ${_service[2].serviceUuid}'),
                  // Text(_isEmpty
                  //     ? ''
                  //     : 'banyak characteristic : ${_service[2].characteristics.length}'),
                  // // TextButton(onPressed: read, child: Text('Cari value')),
                  // Text(_dataIsEmpty == false ? 'data[${_actualValue}]' : 'No data'),
                  // Text(_dataIsEmpty == false
                  //     ? 'Banyak gerakan drive : ${_counterDrive}'
                  //     : '0'),
                  // Text(_dataIsEmpty == false
                  //     ? 'Banyak gerakan drive : ${_counterSmash}'
                  //     : '0'),
                  // Text(_dataIsEmpty == false
                  //     ? 'Banyak gerakan drive : ${_counterService}'
                  //     : '0'),
                  // FloatingActionButton(onPressed: stop),
                  // FloatingActionButton(onPressed: resume),
                ]),
          ),
        ),
      ),
    );
  }
}

class MoveCounter extends StatelessWidget {
  const MoveCounter({
    super.key,
    required int counterSmash,
    required String this.moveName,
  }) : _counterSmash = counterSmash;

  final int _counterSmash;
  final String moveName;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      color: Color(0xFF299046),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            moveName,
            style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.white),
          ),
          SizedBox(width: 30),
          Text(
            _counterSmash.toString(),
            style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.white),
          )
        ],
      ),
    );
  }
}
