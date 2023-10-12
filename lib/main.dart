import 'dart:io';
import 'package:badmintonstroke_counter/views/counter_screen.dart';
import 'package:badmintonstroke_counter/views/homepage.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

void main() {
  if (Platform.isAndroid) {
    WidgetsFlutterBinding.ensureInitialized();
    [
      Permission.location,
      Permission.storage,
      Permission.bluetooth,
      Permission.bluetoothConnect,
      Permission.bluetoothScan
    ].request().then((status) {
      runApp(const CounterScreen());
    });
  } else {
    runApp(const CounterScreen());
  }
}

class BadmintonApp extends StatelessWidget {
  const BadmintonApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Badmintcount',
      home: HomePageView(),
    );
  }
}
