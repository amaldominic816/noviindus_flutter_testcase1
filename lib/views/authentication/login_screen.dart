import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_testcase_one/views/Home/home_screen.dart';
import 'package:logger/logger.dart';
import '../../constants/customButton.dart';
import '../../constants/customTextfield.dart';
import '../../services/auth_service.dart'; // Import your AuthService here

class LoginScreen extends StatelessWidget {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final Logger _logger = Logger();
  final AuthService _authService = AuthService(); // Initialize your AuthService

  LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(

          children: [
            Container(
              color: Colors.red,
              height: 217,
              child: Stack(
                fit: StackFit.expand,
                children: <Widget>[
                  Image.asset(
                    'assets/images/bg.png',
                    fit: BoxFit.cover,
                  ),
                  Center(
                    child: SvgPicture.asset(
                      'assets/images/logo.svg',
                      height: 84,
                      width: 80,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    "Login or register to book your appointments",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(height: 20),
                  CustomTextField(
                    controller: _usernameController,
                    title: "Email",
                    keyboardType: TextInputType.text,
                    hintText: "Enter your Email or username",
                    isRequired: false,
                    borderColor: Color.fromRGBO(217, 217, 217, 0.25),
                    focusedBorderColor: Color.fromRGBO(217, 217, 217, 0.25),
                    errorBorderColor: Color.fromRGBO(217, 217, 217, 0.25),
                    hintStyle: TextStyle(
                      color: Colors.grey,
                      fontSize: 14,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  SizedBox(height: 20),
                  CustomTextField(
                    controller: _passwordController,
                    title: "Password",
                    keyboardType: TextInputType.visiblePassword,
                    hintText: "Enter Password",
                    isRequired: false,
                    hintStyle: TextStyle(
                      color: Colors.grey,
                      fontSize: 14,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  SizedBox(height: 30),
                  CustomElevatedButton(
                    text: "Login",
                    onPressed: () {
                      final username = _usernameController.text;
                      final password = _passwordController.text;
                      _logger.i('Login button pressed for user: $username');

                      _performLogin(context, username, password);
                    },
                    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                    fontWeight: FontWeight.w600,
                    fontsize: 17,
                    borderRadius: 8.52,
                  ),
                ],
              ),
            ),
            SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                "By creating or logging into an account you are agreeing \n    with our Terms and Conditions and Privacy Policy.",
                style: TextStyle(fontSize: 12),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _performLogin(
      BuildContext context, String username, String password) async {
    try {
      bool success = await _authService.login(username, password);

      if (success) {
        _logger.i('User logged in successfully: $username');
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen()),
        );
      } else {
        _logger.e('Login failed for user: $username');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Login failed. Please check your credentials."),
            duration: Duration(seconds: 3),
          ),
        );
      }
    } catch (e) {
      _logger.e('Login error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("An error occurred while logging in."),
          duration: Duration(seconds: 3),
        ),
      );
    }
  }
}
