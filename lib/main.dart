import 'package:flutter/material.dart';
import 'package:flutter_testcase_one/provider/addtreatment_provider.dart';
import 'package:flutter_testcase_one/provider/auth_provider.dart';
import 'package:flutter_testcase_one/provider/home_provider.dart';
import 'package:flutter_testcase_one/provider/registration_provider.dart';
import 'package:flutter_testcase_one/views/authentication/splash_screen.dart';
import 'package:provider/provider.dart';
import 'package:logger/logger.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Logger _logger = Logger();

  MyApp() {
    _initializeLogger(); // Initialize logger outside of build method
  }

  void _initializeLogger() {
    _logger.i('Logger initialized.');
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => HomeProvider()),
        ChangeNotifierProvider(create: (_) => RegistrationController()),
        ChangeNotifierProvider(create: (_) => addtreatmentcontroller()),

      ],
      child: Consumer<AuthProvider>(
        builder: (context, authProvider, _) {
          _logger.i('App started.');
          // Determine initial route based on authentication state
          Widget initialRoute = SplashScreen();

          if (authProvider.isAuthenticated) {
            // Example: Navigate to HomeScreen if authenticated
            // initialRoute = HomeScreen();
          } else {
            // Example: Navigate to LoginScreen if not authenticated
            // initialRoute = LoginScreen();
          }

          return MaterialApp(
            title: 'Flutter Login',
            theme: ThemeData(
              primarySwatch: Colors.red,
            ),
            home: initialRoute,
          );
        },
      ),
    );
  }
}
