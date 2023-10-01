import 'package:flutter/material.dart';

class HomePageView extends StatelessWidget {
  const HomePageView({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            backgroundColor: const Color(0xFF299046),
            title: const Text('Halo, User !'),
          ),
          body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const Text(
              'Sesi Permainan',
              style: TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 10),
            Flexible(
              flex: 3,
              child: Container(
                  color: Colors.amber,
                  width: width,
                  height: height,
                  child: ListView.builder(
                      itemCount: 10,
                      itemBuilder: (BuildContext context, index) {
                        return Container(
                          width: width,
                          height: 100,
                          color: Colors.amber,
                          child: Text('Item list $index'),
                        );
                      })),
            ),
          ])),
    );
  }
}
