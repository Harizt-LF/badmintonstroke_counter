import 'package:badmintonstroke_counter/views/counter_screen.dart';
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
  Set<DeviceIdentifier> seen = {};

  Future onScanPressed() async {
    await FlutterBluePlus.startScan(timeout: const Duration(seconds: 15));
    print('Tombol search ditekan');
  }

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

  Widget getDeviceName(ScanResult result) {
    String name = '';

    if (result.device.platformName.isNotEmpty) {
      name = result.device.platformName;
    } else {
      name = 'N/A';
    }
    return Text(name,
        style: TextStyle(
            fontFamily: 'Poppins', fontSize: 16, color: Colors.white));
  }

  Widget getDeviceMacId(ScanResult result) {
    return Text(result.device.remoteId.toString());
  }

  void onConnected(ScanResult result, String sessionTitle) {}

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
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
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
                              style: TextStyle(
                                  fontFamily: 'Poppins', fontSize: 12),
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
                const Text(
                  'Device tersedia',
                  style: TextStyle(
                      fontFamily: 'Poppins', fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                Container(
                  width: width,
                  height: 300,
                  child: _isScanning
                      ? Center(
                          child: CircularProgressIndicator(
                          color: const Color(0xFF299046),
                          backgroundColor: Colors.white,
                        ))
                      : ListView.separated(
                          itemBuilder: (context, index) {
                            final result = _scanResults[index];
                            return Container(
                              width: width,
                              decoration: BoxDecoration(
                                  color: Color(0xFF299046),
                                  borderRadius: BorderRadius.circular(10)),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 14.0, vertical: 14),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    getDeviceName(result),
                                    InkWell(
                                      onTap: () {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    CounterScreen(
                                                        device:
                                                            result.device)));
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(4)),
                                        child: Padding(
                                          padding: const EdgeInsets.all(5.0),
                                          child: Row(
                                            children: [
                                              Text(
                                                'Connect',
                                                style: TextStyle(
                                                    fontFamily: 'Poppins',
                                                    fontSize: 13,
                                                    fontWeight: FontWeight.bold,
                                                    color: Color(0xFF299046)),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
                          separatorBuilder: (context, index) {
                            return SizedBox(height: 10);
                          },
                          itemCount: _scanResults.length),
                )
              ],
            ),
          ),
        ),
        floatingActionButton: IconButton(
            onPressed: onScanPressed, icon: const Icon(Icons.search)),
      ),
    );
  }
}
