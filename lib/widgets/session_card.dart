import 'package:flutter/material.dart';

class SessionCard extends StatelessWidget {
  const SessionCard({
    super.key,
    required this.width,
    required this.index,
    required this.sessionName,
    required this.serveCount,
    required this.smashCount,
    required this.driveCount,
    required this.createdAt,
  });

  final double width;
  final int index;
  final String? sessionName;
  final int? serveCount;
  final int? smashCount;
  final int? driveCount;
  final String? createdAt;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: 130,
      child: Column(
        children: [
          Flexible(
            flex: 1,
            child: Container(
              alignment: Alignment.center,
              width: width,
              decoration: const BoxDecoration(
                  color: Color(0xFF299046),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20))),
              child: Text(
                '$sessionName',
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Flexible(
              flex: 1,
              child: Container(
                decoration: const BoxDecoration(
                    boxShadow: [
                      BoxShadow(color: Colors.black26, blurRadius: 3)
                    ],
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20))),
                child: Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [Text('$serveCount'), const Text('Serve')],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [Text('$smashCount'), const Text('Smash')],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('$driveCount'),
                          const Text('Forehand Drive')
                        ],
                      ),
                    ],
                  ),
                ),
              ))
        ],
      ),
    );
  }
}
