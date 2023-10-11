import 'dart:io';
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
      runApp(const BadmintonApp());
    });
  } else {
    runApp(const BadmintonApp());
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
