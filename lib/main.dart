import 'package:badmintonstroke_counter/views/homepage.dart';
import 'package:flutter/material.dart';
import 'package:badmintonstroke_counter/views/welcomepage.dart';

void main() {
  runApp(BadmintonApp());
}

class BadmintonApp extends StatelessWidget {
  const BadmintonApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Badmintcount',
      home: HomePageView(),
    );
  }
}
