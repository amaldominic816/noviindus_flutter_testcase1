import 'package:flutter/material.dart';
import 'package:flutter_testcase_one/views/Home/widgets/patient_list_widget.dart';


import '../../constants/customButton.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {},
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
      body: Container(
        child: PatientListView(),
      ),
    );
  }
}
