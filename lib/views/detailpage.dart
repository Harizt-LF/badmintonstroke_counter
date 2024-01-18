import 'package:badmintonstroke_counter/database/datacount_model.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class DetailPage extends StatelessWidget {
  final DatacountModel data;

  const DetailPage({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    var smashBenar = 23;
    var smashSalah = 3;
    var totalSmash = smashBenar + smashSalah;

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0.5,
          shadowColor: Colors.black87,
          title: Text(
            'Session Detail',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 21,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF299046),
            ),
          ),
          centerTitle: true,
        ),
        body: Container(
          width: width,
          child: Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  flex: 1,
                  child: Container(
                    decoration: BoxDecoration(
                        color: const Color(0xFF299046),
                        borderRadius: BorderRadius.circular(15)),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          right: 18.0, left: 18.0, top: 18),
                      child: Container(
                        height: 190,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              child: Image.asset(
                                'assets/images/detail.png',
                                fit: BoxFit.contain,
                              ),
                            ),
                            SizedBox(width: 20),
                            Expanded(
                              child: Container(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    const Text(
                                      'Data Pukulan',
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: 23,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                    Text(
                                      'Pada bagian ini anda bisa melihat statistik hasil rekaman data pukulan',
                                      textAlign: TextAlign.right,
                                      // overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        color: Colors.white,
                                        fontSize: 12,
                                      ),
                                    ),
                                    Expanded(child: SizedBox()),
                                    Text('${data.createdAt}'),
                                    SizedBox(
                                      height: 50,
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Expanded(
                  flex: 2,
                  child: Container(
                    width: width,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      padding: EdgeInsets.only(left: 1, right: 1, bottom: 20),
                      child: Column(
                        children: [
                          DetailCard(
                              title: 'Forehand Drive',
                              width: width,
                              benar: data.driveCount,
                              salah: smashSalah,
                              total: totalSmash),
                          SizedBox(height: 20),
                          DetailCard(
                              title: 'Serve',
                              width: width,
                              benar: data.serveCount,
                              salah: 4,
                              total: 9),
                          SizedBox(height: 20),
                          DetailCard(
                              title: 'Smash',
                              width: width,
                              benar: data.smashCount,
                              salah: 6,
                              total: 15)
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}

class DetailCard extends StatelessWidget {
  const DetailCard({
    super.key,
    required this.title,
    required this.width,
    required this.benar,
    required this.salah,
    required this.total,
  });

  final double width;
  final int? benar;
  final int salah;
  final int total;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: width,
        height: 200,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                  color: Colors.black12,
                  blurRadius: 6,
                  offset: Offset(0, 3),
                  blurStyle: BlurStyle.normal)
            ]),
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Container(
                  height: double.maxFinite,
                  child: Center(
                    child: PieChart(
                      PieChartData(
                        sectionsSpace: 0,
                        sections: [
                          PieChartSectionData(
                              title: '$benar',
                              showTitle: false,
                              titleStyle: TextStyle(
                                  fontFamily: 'Poppins',
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                              value: benar?.toDouble(),
                              color: const Color(0xFF299046)),
                          PieChartSectionData(
                              value: salah.toDouble(),
                              showTitle: false,
                              title: '$salah',
                              titleStyle: TextStyle(
                                  fontFamily: 'Poppins',
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                              color: Colors.redAccent)
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 30,
              ),
              Container(
                width: 120,
                height: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '$title',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        height: 1.2,
                        fontSize: 23,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF299046),
                      ),
                    ),
                    Text(
                      'Total :  $total',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF299046),
                      ),
                    ),
                    Expanded(child: SizedBox()),
                    Text(
                      'Benar :  $benar',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF299046),
                      ),
                    ),
                    Text(
                      'Salah : $salah',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.redAccent,
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
