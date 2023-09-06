import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(Badminton());
}

class Badminton extends StatelessWidget {
  const Badminton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Hello, World!',
      home: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            SizedBox(height: 60),
            Container(
              child: Image.asset('assets/images/hero_welcome.png'),
            ),
            SizedBox(
              height: 35,
            ),
            Text(
              'Selamat\nDatang',
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w800,
                fontSize: 50,
              ),
            ),
            SizedBox(height: 9),
            Text(
              "Rekam dan lacak setiap\ngerakan permainan\nbulutangkis anda",
              style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w400, fontSize: 20),
            ),
            SizedBox(height: 20),
            Directionality(
              textDirection: TextDirection.rtl,
              child: ElevatedButton.icon(
                onPressed: () {},
                icon: Icon(Icons.abc),
                label: Text('Masuk'),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
