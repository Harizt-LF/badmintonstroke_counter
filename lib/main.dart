import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const Badminton());
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
            const SizedBox(height: 60),
            Image.asset('assets/images/hero_welcome.png'),
            const SizedBox(
              height: 35,
            ),
            Text(
              'Selamat\nDatang',
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w800,
                fontSize: 50,
              ),
            ),
            const SizedBox(height: 9),
            Text(
              "Rekam dan lacak setiap\ngerakan permainan\nbulutangkis anda",
              style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w400, fontSize: 20),
            ),
            const SizedBox(height: 20),
            Directionality(
              textDirection: TextDirection.rtl,
              child: ElevatedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.arrow_back_ios),
                label: const Text('Masuk'),
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  backgroundColor: const Color.fromARGB(255, 37, 136, 65),
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
