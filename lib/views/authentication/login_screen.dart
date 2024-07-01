import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_testcase_one/views/Home/home_screen.dart';
import '../../constants/customButton.dart';
import '../../constants/customTextfield.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
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
                  title: "Email",
                  keyboardType: TextInputType.emailAddress,
                  hintText: "Enter your Mail",
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
                  title: "Password",
                  keyboardType: TextInputType.emailAddress,
                  hintText: "Enter Password",
                  isRequired: false,
                  hintStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: 14,

                    fontWeight: FontWeight.w300,
                  ),
                ),
                SizedBox(height: 100),
                CustomElevatedButton(
                  text: "Login",
                  fontWeight: FontWeight.bold,
                  borderRadius: 10,
                  onPressed: () {
                    Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => HomeScreen()),
                        );

                  },
                ),
              ],
            ),
          ),
          SizedBox(height:100),

          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text("By creating or logging into an account you are agreeing \n    with our Terms and Conditions and Privacy Policy.",style: TextStyle(
              fontSize: 10
            ),),
          )
          
        ],
      ),
    );
  }
}
