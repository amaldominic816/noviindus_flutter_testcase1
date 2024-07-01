import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';

import '../../constants/colors.dart';

import '../../provider/auth_provider.dart';
import '../Home/home_screen.dart';
import 'login_screen.dart';


class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();

}

class _SplashScreenState extends State<SplashScreen> {
  final Logger _logger = Logger();
  @override
  void initState() {
    super.initState();
    _checkAuthentication();
  }

  Future<void> _checkAuthentication() async {
    await Future.delayed(Duration(seconds: 2)); // Simulate a delay for splash screen
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    await authProvider.checkAuthentication();
    if (authProvider.isAuthenticated) {
      _logger.i('User is authenticated, navigating to HomeScreen.');
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => HomeScreen()));
    } else {
      _logger.i('User is not authenticated, navigating to LoginScreen.');
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => LoginScreen()));
    }
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
