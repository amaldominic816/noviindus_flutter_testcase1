import 'package:flutter/material.dart';
import 'package:flutter_testcase_one/provider/auth_provider.dart';
import 'package:flutter_testcase_one/views/authentication/splash_screen.dart';
import 'package:provider/provider.dart';
import 'package:logger/logger.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Logger _logger = Logger();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
      ],
      child: Consumer<AuthProvider>(
        builder: (context, authProvider, _) {
          _logger.i('App started.');
          return MaterialApp(
            title: 'Flutter Login',
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            home: SplashScreen(),
          );
        },
      ),
    );
  }
}
