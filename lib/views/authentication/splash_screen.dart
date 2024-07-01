import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../constants/colors.dart';
import 'login_screen.dart';


class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToHome();
  }

  _navigateToHome() async {
    await Future.delayed(Duration(seconds: 3), () {});
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[

          Positioned.fill(
            child: Image.asset(
              'assets/images/splashbg.png',
              fit: BoxFit.cover,
            ),
          ),
          Positioned.fill(
            child: Container(
              color: gradient1
            ),
          ),
          // Centered logo
          Center(
            child: SvgPicture.asset(
              'assets/images/logo.svg',
              width: 150,
              height: 150,
            ),
          ),
        ],
      ),
    );
  }
}
