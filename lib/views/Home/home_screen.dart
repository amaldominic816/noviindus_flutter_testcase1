import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_testcase_one/services/auth_service.dart';
import 'package:flutter_testcase_one/views/Home/widgets/patient_list_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';


import '../../constants/customButton.dart';
import '../authentication/login_screen.dart';

class HomeScreen extends StatelessWidget {
   HomeScreen({super.key});

  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () async {
              await _authService.logout();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => LoginScreen()),
              );
            },
          ),
          GestureDetector(
            onTap: () {

            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: SvgPicture.asset(
                "assets/images/notification.svg",
                height: 28,
                width: 28,
              ),
            ),
          ),

        ],
      ),
      floatingActionButton: CustomElevatedButton(
        text: "Register Now",
        onPressed: () {
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(builder: (context) => Registerscreen()),
          // ).then((value) => Provider.of<RegistrationController>(context, listen: false).onRegister());


        },
        padding: EdgeInsets.only(
            left: MediaQuery.of(context).size.width * 0.25,
            right: MediaQuery.of(context).size.width * 0.25,
            bottom: MediaQuery.of(context).size.height * 0.02,
            top: MediaQuery.of(context).size.height * 0.02),
        fontWeight: FontWeight.w600,
        fontsize: 17,
        borderRadius: 8.52,




      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body:
      PatientListView(),
    );
  }

}

