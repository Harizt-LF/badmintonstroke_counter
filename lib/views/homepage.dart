import 'package:flutter/material.dart';
import 'package:badmintonstroke_counter/widgets/session_card.dart';

class HomePageView extends StatelessWidget {
  const HomePageView({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    int dataLength = 0;

    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFF299046),
          title: const Text('Halo, User !'),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 23, vertical: 20),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const Text(
              'Sesi Permainan',
              style: TextStyle(
                  fontFamily: 'assets/fonts/Poppins',
                  fontWeight: FontWeight.w700,
                  fontSize: 20),
            ),
            const SizedBox(height: 15),
            Flexible(
              flex: 5,
              child: Container(
                  width: width,
                  height: height,
                  child: dataLength < 1
                      ? Expanded(
                          child: Center(
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                    height: 180,
                                    width: 180,
                                    child: Image.asset(
                                        'assets/images/dataMiss.png')),
                                SizedBox(height: 10),
                                Text(
                                  'Data Kosong !',
                                  style: TextStyle(
                                      fontFamily: 'assets/fonts/Poppins',
                                      fontWeight: FontWeight.w700,
                                      fontSize: 20),
                                ),
                              ]),
                        ))
                      : ListView.separated(
                          itemCount: dataLength,
                          separatorBuilder: (BuildContext context, int index) =>
                              const Divider(
                                height: 10,
                                color: Colors.white,
                              ),
                          itemBuilder: (BuildContext context, index) {
                            return SessionCard(
                              width: width,
                              index: index,
                            );
                          })),
            ),
            SizedBox(height: 15),
            Flexible(
              fit: FlexFit.loose,
              child: Container(
                height: 50,
                width: width,
                color: Colors.amber,
                child: Row(
                  children: [
                    Text('Tambahkan Data'),
                  ],
                ),
              ),
            )
          ]),
        ));
  }
}
