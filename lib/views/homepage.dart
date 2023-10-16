import 'package:badmintonstroke_counter/database/datacount_model.dart';
import 'package:badmintonstroke_counter/views/connect_to_ble.dart';
import 'package:flutter/material.dart';
import 'package:badmintonstroke_counter/widgets/session_card.dart';
import 'package:badmintonstroke_counter/database/database.dart';

class HomePageView extends StatefulWidget {
  const HomePageView({super.key});

  @override
  State<HomePageView> createState() => _HomePageViewState();
}

class _HomePageViewState extends State<HomePageView> {
  DatabaseInstance databaseInstance = DatabaseInstance();

  @override
  void initState() {
    databaseInstance.database();
    refresh();
    super.initState();
  }

  Future refresh() async {
    await databaseInstance.getData();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFF299046),
          title: const Text('Halo, User !'),
        ),
        body: RefreshIndicator(
          onRefresh: refresh,
          child: Padding(
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
                child: SizedBox(
                    width: width,
                    height: height,
                    child: FutureBuilder<List<DatacountModel>>(
                        future: databaseInstance.getData(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return ListView.separated(
                              itemCount: snapshot.data!.length,
                              separatorBuilder: (context, index) {
                                return Divider(
                                  height: 10,
                                  color: Colors.white,
                                );
                              },
                              itemBuilder: (context, index) {
                                return SessionCard(
                                    width: width,
                                    index: index,
                                    sessionName:
                                        snapshot.data![index].sessionName,
                                    serveCount:
                                        snapshot.data![index].serveCount,
                                    smashCount:
                                        snapshot.data![index].smashCount,
                                    driveCount:
                                        snapshot.data![index].driveCount,
                                    createdAt: snapshot.data![index].createdAt);
                              },
                            );
                          } else {
                            return Expanded(
                                child: Center(
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                        height: 180,
                                        width: 180,
                                        child: Image.asset(
                                            'assets/images/dataMiss.png')),
                                    const SizedBox(height: 10),
                                    const Text(
                                      'Data Kosong !',
                                      style: TextStyle(
                                          fontFamily: 'assets/fonts/Poppins',
                                          fontWeight: FontWeight.w700,
                                          fontSize: 20),
                                    ),
                                  ]),
                            ));
                          }
                        })
                    //     : ListView.separated(
                    //         itemCount: dataLength,
                    //         separatorBuilder: (BuildContext context, int index) =>
                    //             const Divider(
                    //               height: 10,
                    //               color: Colors.white,
                    //             ),
                    //         itemBuilder: (BuildContext context, index) {
                    //           return SessionCard(
                    //             width: width,
                    //             index: index,
                    //           );
                    //         }),
                    ),
              ),
              const SizedBox(height: 15),
              Flexible(
                fit: FlexFit.loose,
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const ConnectBle()));
                  },
                  child: Container(
                    height: 50,
                    width: width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: const Color(0xFF299046),
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Tambahkan Data',
                            style: TextStyle(
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w600,
                                color: Colors.white)),
                        Icon(
                          Icons.add,
                          size: 20,
                          color: Colors.white,
                        )
                      ],
                    ),
                  ),
                ),
              )
            ]),
          ),
        ));
  }
}
