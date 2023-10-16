import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:badmintonstroke_counter/database/database.dart';

class CounterScreen extends StatefulWidget {
  const CounterScreen(
      {super.key, required this.device, required this.sessionName});

  final BluetoothDevice device;
  final String sessionName;

  @override
  State<CounterScreen> createState() => _CounterScreenState();
}

class _CounterScreenState extends State<CounterScreen> {
  DatabaseInstance databaseInstance = DatabaseInstance();

  List<BluetoothService> _service = [];
  late StreamSubscription<List<int>> _lastValueSubscription;
  List<int> _value = [];
  int _counterDrive = 0;
  int _counterSmash = 0;
  int _counterService = 0;
  String drive = 'DRIVE FOREHAND';
  String smash = 'SMASH';
  String service = 'SERVICE';
  var nilai = '';
  // bool _isDiscoveringServices = false;
  // bool _isConnecting = false;
  bool _isConnected = false;
  bool _isEmpty = true;
  bool _dataIsEmpty = true;
  bool _isResume = true;
  var _actualValue = '';

  @override
  void initState() {
    super.initState();
    allInOne();
    databaseInstance.database();
  }

  @override
  void dispose() {
    _lastValueSubscription.cancel();
    widget.device.disconnect();
    super.dispose();
  }

  // Future discoverServices() async {
  //   _service = await widget.device.discoverServices();
  //   setState(() {
  //     _isEmpty = false;
  //   });
  // }

  // Future onConnect() async {
  //   await widget.device.connect(timeout: const Duration(seconds: 5));
  //   setState(() {
  //     _isConnected = true;
  //   });
  // }

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
    await widget.device.connect(timeout: const Duration(seconds: 5));
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
      if (_actualValue.toString().contains(drive)) {
        _counterDrive = _counterDrive + 1;
      } else if (_actualValue.toString().contains(smash)) {
        _counterSmash = _counterSmash + 1;
      } else if (_actualValue.toString().contains(service)) {
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

  Future saveData() async {
    await databaseInstance.insert({
      'session_name': widget.sessionName,
      'serve_count': _counterService,
      'smash_count': _counterSmash,
      'drive_count': _counterDrive,
      'created_at': DateTime.now()
    });
    await widget.device.disconnect();
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: Padding(
            padding: const EdgeInsets.only(left: 20),
            child: CircleAvatar(
                backgroundColor: _isConnected ? Colors.blue : Colors.red),
          ),
          title: Text(widget.sessionName.toString()),
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
                  const SizedBox(height: 20),
                  MoveCounter(
                    counterSmash: _counterSmash,
                    moveName: 'SMASH',
                  ),
                  const SizedBox(height: 20),
                  MoveCounter(
                    counterSmash: _counterDrive,
                    moveName: 'FOREHAND DRIVE',
                  ),
                  const SizedBox(height: 20),
                  MoveCounter(
                    counterSmash: _counterService,
                    moveName: 'SERVE',
                  ),
                  const SizedBox(height: 20),
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
                          backgroundColor:
                              _isResume ? Colors.red : const Color(0xFF299046),
                          child: _isResume
                              ? const Icon(Icons.pause)
                              : const Icon(Icons.play_arrow)),
                      FloatingActionButton(
                        onPressed: saveData,
                        backgroundColor: _isResume
                            ? Color(0xFF299046).withOpacity(0.3)
                            : Color(0xFF299046),
                        child: const Icon(Icons.check),
                      )
                    ],
                  ),
                  Text('Gerakan sekarang : $_actualValue'),
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
      color: const Color(0xFF299046),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            moveName,
            style: const TextStyle(
                fontFamily: 'Poppins',
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.white),
          ),
          const SizedBox(width: 30),
          Text(
            _counterSmash.toString(),
            style: const TextStyle(
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
