import 'package:flutter/material.dart';

void main() {
  runApp(Badminton());
}

class Badminton extends StatelessWidget {
  const Badminton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Hello, World!',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Hello! '),
        ),
        body: Center(
          child: Text(
            'Hello, World!',
            style: TextStyle(fontSize: 24),
          ),
        ),
      ),
    );
  }
}