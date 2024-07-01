import 'package:flutter/material.dart';
import 'package:flutter_testcase_one/views/authentication/splash_screen.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Noviindus',
      theme: ThemeData(
        fontFamily: GoogleFonts.poppins().fontFamily,

        useMaterial3: true,
      ),
      home:  SplashScreen(),
    );
  }
}



