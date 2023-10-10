import 'package:flutter/material.dart';

class SessionCard extends StatelessWidget {
  const SessionCard({
    super.key,
    required this.width,
    required this.index,
  });

  final double width;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: 130,
      child: Column(
        children: [
          Flexible(
            flex: 1,
            child: Container(
              alignment: Alignment.center,
              width: width,
              decoration: BoxDecoration(
                  color: const Color(0xFFFF299046),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20))),
              child: Text(
                'Session ${index + 1}',
                style: const TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
          ),
          Flexible(
              flex: 1,
              child: Container(
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(color: Colors.black26, blurRadius: 3)
                    ],
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20))),
                child: const Padding(
                  padding: EdgeInsets.only(left: 20, right: 20, top: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [Text('01'), Text('Gerakan')],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [Text('01'), Text('Gerakan')],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [Text('01'), Text('Gerakan')],
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
