import 'package:badmintonstroke_counter/database/datacount_model.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class DetailPage extends StatelessWidget {
  // final DatacountModel data;

  const DetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    var smashBenar = 10;
    var serveBenar = 6;
    var driveBenar = 15;
    var smashSalah = 3;
    var serveSalah = 2;
    var driveSalah = 4;
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
                          right: 18.0, left: 18.0, top: 18, bottom: 18),
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
                                // color: Colors.amber,
                                height: double.maxFinite,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Expanded(
                                      flex: 2,
                                      child: const Text(
                                        'Data Pukulan',
                                        textAlign: TextAlign.end,
                                        style: TextStyle(
                                          fontFamily: 'Poppins',
                                          fontSize: 19,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    Expanded(flex: 2, child: SizedBox()),
                                    Expanded(
                                      flex: 8,
                                      child: RadarChart(RadarChartData(
                                          radarShape: RadarShape.circle,
                                          titleTextStyle: TextStyle(
                                            fontFamily: 'Poppins',
                                            fontSize: 8,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                          getTitle: (index, angle) {
                                            switch (index) {
                                              case 0:
                                                return RadarChartTitle(
                                                  text: 'SMASH',
                                                  angle: angle,
                                                );
                                              case 2:
                                                return RadarChartTitle(
                                                  text: 'DRIVE',
                                                  angle: angle,
                                                );
                                              case 1:
                                                return RadarChartTitle(
                                                    text: 'SERVE',
                                                    angle: angle);
                                              default:
                                                return const RadarChartTitle(
                                                    text: '');
                                            }
                                          },
                                          // radarBackgroundColor: Colors.white,
                                          tickCount: 1,
                                          tickBorderData:
                                              BorderSide(color: Colors.black12),
                                          ticksTextStyle: TextStyle(
                                              color: Colors.transparent),
                                          radarBorderData:
                                              BorderSide(color: Colors.white24),
                                          dataSets: [
                                            RadarDataSet(
                                                // borderColor: Color(0xFF299046),
                                                borderWidth: 1,
                                                entryRadius: 3,
                                                dataEntries: [
                                                  RadarEntry(
                                                      value: smashBenar
                                                          .toDouble()),
                                                  RadarEntry(
                                                      value: serveBenar
                                                          .toDouble()),
                                                  RadarEntry(
                                                      value:
                                                          driveBenar.toDouble())
                                                ]),
                                          ])),
                                    ),
                                    Expanded(flex: 2, child: SizedBox()),
                                    Expanded(
                                      flex: 4,
                                      child: Text(
                                        'Lihat distribusi pukulan yang anda lakukan',
                                        textAlign: TextAlign.right,
                                        overflow: TextOverflow.clip,
                                        maxLines: 2,
                                        style: TextStyle(
                                          fontFamily: 'Poppins',
                                          color: Colors.white,
                                          fontSize: 11,
                                        ),
                                        softWrap: true,
                                      ),
                                    ),
                                    // Expanded(child: SizedBox()),
                                    // Text('Tanggal'),
                                    // SizedBox(
                                    //   height: 50,
                                    // )
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
                              benar: driveBenar,
                              salah: driveSalah,
                              total: driveBenar + driveSalah),
                          SizedBox(height: 20),
                          DetailCard(
                              title: 'Serve',
                              width: width,
                              benar: serveBenar,
                              salah: serveSalah,
                              total: serveBenar + serveSalah),
                          SizedBox(height: 20),
                          DetailCard(
                              title: 'Smash',
                              width: width,
                              benar: smashBenar,
                              salah: smashSalah,
                              total: smashSalah + smashBenar)
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
