import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'dart:async';

class ConnectBle extends StatefulWidget {
  const ConnectBle({super.key});

  @override
  State<ConnectBle> createState() => _ConnectBleState();
}

class _ConnectBleState extends State<ConnectBle> {
  final textController = TextEditingController();

  List<BluetoothDevice> _connectedDevices = [];
  List<ScanResult> _scanResults = [];
  bool _isScanning = false;
  late StreamSubscription<List<ScanResult>> _scanResultsSubscription;
  late StreamSubscription<bool> _isScanningSubscription;

  @override
  void initState() {
    super.initState();

    FlutterBluePlus.connectedSystemDevices.then((devices) {
      _connectedDevices = devices;
      setState(() {});
    });

    _scanResultsSubscription = FlutterBluePlus.scanResults.listen((results) {
      _scanResults = results;
      setState(() {});
    });

    _isScanningSubscription = FlutterBluePlus.isScanning.listen((state) {
      _isScanning = state;
      setState(() {});
    });
  }

  @override
  void dispose() {
    _scanResultsSubscription.cancel();
    _isScanningSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => Navigator.of(context).pop(),
            ),
            title: const Text(
              'Connect To Badmincount Device',
              style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 15,
                  fontWeight: FontWeight.bold),
            ),
            backgroundColor: const Color(0xFF299046)),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: width,
                child: Row(
                  children: [
                    const Flexible(
                      flex: 3,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Hubungkan dengan Badmincount Device',
                            style: TextStyle(
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.bold,
                                fontSize: 18),
                          ),
                          SizedBox(height: 10),
                          Text(
                            'Isi nama sesi kemudian hubungkan dengan badmincount device yang tersedia',
                            style:
                                TextStyle(fontFamily: 'Poppins', fontSize: 11),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: SizedBox(
                          height: 150,
                          child: Image.asset('assets/images/connect.png',
                              fit: BoxFit.fitHeight)),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            width: 1.8, color: Color(0xFF299046)),
                        borderRadius: BorderRadius.circular(12)),
                    label: const Text('Nama Sesi',
                        style: TextStyle(fontFamily: 'Poppins')),
                    hintStyle: const TextStyle(fontFamily: 'Poppins'),
                    hintText: 'Input nama sesi'),
                controller: textController,
                maxLines: 1,
              ),
              const SizedBox(height: 20),
              Text('Device tersedia',
                  style: TextStyle(
                      fontFamily: 'Poppins', fontWeight: FontWeight.bold)),
            ],
          ),
        ),
      ),
    );
  }
}
