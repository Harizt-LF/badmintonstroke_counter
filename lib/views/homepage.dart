import 'package:flutter/material.dart';
import 'dart:math' as math;

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
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 23),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const Text(
                'Sesi Permainan',
                style: TextStyle(fontSize: 20),
              ),
              const SizedBox(height: 10),
              Flexible(
                flex: 3,
                child: Container(
                    width: width,
                    height: height,
                    child: ListView.separated(
                        itemCount: 10,
                        separatorBuilder: (BuildContext context, int index) =>
                            const Divider(height: 10),
                        itemBuilder: (BuildContext context, index) {
                          return Container(
                            width: width,
                            height: 100,
                            child: Column(
                              children: [
                                Flexible(
                                  flex: 1,
                                  child: Container(
                                    alignment: Alignment.center,
                                    width: width,
                                    color: const Color(0xFFFF299046),
                                    child: Text(
                                      'Sesi $index',
                                      style: const TextStyle(
                                          color: Colors.white, fontSize: 20),
                                    ),
                                  ),
                                ),
                                Flexible(
                                    flex: 1,
                                    child: Container(
                                      color: Colors.white,
                                      child: const Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              children: [
                                                Text('01'),
                                                Text('Gerakan')
                                              ],
                                            ),
                                            Column(
                                              children: [
                                                Text('01'),
                                                Text('Gerakan')
                                              ],
                                            ),
                                            Column(
                                              children: [
                                                Text('01'),
                                                Text('Gerakan')
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ))
                              ],
                            ),
                          );
                        })),
              ),
            ]),
          )),
    );
  }
}