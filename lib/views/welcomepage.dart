import 'package:flutter/material.dart';

class Badminton extends StatelessWidget {
  const Badminton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Badminton Counter',
      home: Scaffold(
        body: SafeArea(
          child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
              child: Container(
                width: screenSize.width,
                child: Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Flexible(
                        child: SizedBox(
                            child:
                                Image.asset('assets/images/hero_welcome.png')),
                      ),
                      Expanded(
                        child: SizedBox(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              const Flexible(
                                flex: 3,
                                child: Text(
                                  'Selamat\nDatang',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w800,
                                    fontSize: 50,
                                  ),
                                ),
                              ),
                              const Flexible(
                                flex: 2,
                                child: Text(
                                  "Rekam dan lacak setiap\ngerakan permanan\nbulutangkis anda",
                                  style: TextStyle(fontSize: 20),
                                ),
                              ),
                              Flexible(
                                flex: 1,
                                child: Directionality(
                                  textDirection: TextDirection.rtl,
                                  child: ElevatedButton.icon(
                                    onPressed: () {},
                                    icon: const Icon(Icons.arrow_back_ios),
                                    label: const Text(
                                      'Masuk',
                                      style: TextStyle(fontSize: 16),
                                    ),
                                    style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      backgroundColor: const Color.fromARGB(
                                          255, 37, 136, 65),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )),
        ),
      ),
    );
  }
}
