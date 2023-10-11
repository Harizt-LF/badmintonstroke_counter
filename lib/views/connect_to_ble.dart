import 'package:flutter/material.dart';

class ConnectBle extends StatefulWidget {
  const ConnectBle({super.key});

  @override
  State<ConnectBle> createState() => _ConnectBleState();
}

class _ConnectBleState extends State<ConnectBle> {
  final textController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () => Navigator.of(context).pop(),
            ),
            title: Text(
              'Connect To Badmincount Device',
              style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 15,
                  fontWeight: FontWeight.bold),
            ),
            backgroundColor: Color(0xFF299046)),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: [
              Container(
                width: width,
                child: Row(
                  children: [
                    Flexible(
                      flex: 3,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Hubungkan dengan Badmincount Device',
                            style: TextStyle(
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.bold,
                                fontSize: 18),
                          ),
                          SizedBox(height: 10),
                          Text(
                            'Isi nama sesi kemudian hubungkan dengan badmincount device yang tersedia',
                            style:
                                TextStyle(fontFamily: 'Poppins', fontSize: 11),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Container(
                          height: 150,
                          child: Image.asset('assets/images/connect.png',
                              fit: BoxFit.fitHeight)),
                    )
                  ],
                ),
              ),
              SizedBox(height: 20),
              TextField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(), hintText: 'Input nama sesi'),
                controller: textController,
                maxLines: 1,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
