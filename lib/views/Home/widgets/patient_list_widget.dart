

import 'package:flutter/material.dart';

import 'package:provider/provider.dart';


import '../../../constants/colors.dart';
import '../../../constants/customButton.dart';
import '../../../constants/customDropdown.dart';
import '../../../provider/home_provider.dart';




class PatientListView extends StatefulWidget {

  const PatientListView({super.key});

  @override
  State<PatientListView> createState() => _PatientListViewState();
}

class _PatientListViewState extends State<PatientListView> {
  String? _selectedValue;
  final List<String> _items = ['Option 1', 'Option 2', 'Option 3'];
  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(
      builder: (context, controller, child) {
        return Scaffold(
          body:

          Container(
            color: Colors.white,
            child: Column(

                children: [

                SizedBox(height: 20),
              SearchWidget(
                controller: TextEditingController(),
                onSubmitted: (value) {
                  // Implement your search logic here
                  print('Submitted search query: $value');
                  // Example: Call a function to filter your patient list based on the search query
                  // filterPatients(value);
                },
              ),
              SizedBox(height: 50),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Sort by:",
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    Expanded(
                      child: CustomDropdown(
                        items: _items,
                        hintText: 'Date',
                        selectedValue: _selectedValue,
                        onChanged: (String? newValue) {
                          setState(() {
                            _selectedValue = newValue;
                          });
                        },
                        isRequired: true,
                        borderColor: Colors.grey,
                        focusedBorderColor: Colors.grey,
                        errorBorderColor: Colors.red,
                        hintStyle: TextStyle(color: Colors.grey),
                        textStyle: TextStyle(color: Colors.black), title: '',
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              Divider(),
                Expanded(
                  child: RefreshIndicator(
                    onRefresh: () => controller.fetchPatientList(), // Handle refresh
                    child: controller.isLoading
                        ? Center(child: CircularProgressIndicator())
                        : controller.patients.isEmpty
                        ? Center(child: Text('No patients found'))
                        : ListView.builder(

                      itemCount:  controller.patients.indexOf(controller.patients.lastWhere((element) => element.patient!.isNotEmpty)),
                      itemBuilder: (context, patientModelIndex) {
                        final patientList = controller.patients[patientModelIndex].patient!;

                        return ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),

                          itemCount: controller.patients[patientModelIndex].patient!.length,
                          itemBuilder: (context, index) {
                            final  cardnumber = patientModelIndex + 1;
                            final patient = patientList[index];


                            return PatientCard(
                              cardnumber: cardnumber ,
                              patientname: patient.name,
                              package: patient.patientdetailsSet!.first.treatmentName,
                            );
                          },
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}


class PatientCard extends StatelessWidget {
  final cardnumber;
  final patientname;
  final package;
  final date;
  final ontap;
  const PatientCard(
      {super.key, this.cardnumber, this.patientname, this.package, this.ontap, this.date});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
      child: Container(
        height: 166,
        decoration: BoxDecoration(
          color: Color.fromRGBO(241, 241, 241, 1.0),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 15, top: 20),
              child: Row(
                children: [
                  Text(
                    "${cardnumber}.",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(width: 10),
                  Text("${patientname}",
                      style:
                      TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 33),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 5),
                  Text(
                    "Package: ${package}",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w300,
                        color: Color.fromRGBO(0, 104, 55, 1)),
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Icon(
                        Icons.calendar_month,
                        color: Color.fromRGBO(242, 78, 30, 1),
                        size: 15,
                      ),
                      Text("Date:  ${date}"),
                      Icon(
                        Icons.group,
                        color: Color.fromRGBO(242, 78, 30, 1),
                        size: 15,
                      ),
                      Text("name"),
                    ],
                  )
                ],
              ),
            ),

            Divider(),
            Expanded(
              child: InkWell(
                onTap: ontap,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      "View Details",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w300,
                          color: Colors.black),
                    ),
                    SizedBox(width: 10),
                    Icon(
                      Icons.arrow_forward_ios,
                      color: Color.fromRGBO(0, 104, 55, 1),
                      size: 15,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
class SearchWidget extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String>? onSubmitted;

  const SearchWidget({
    Key? key,
    required this.controller,
    this.onSubmitted,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45,
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              style: TextStyle(fontSize: 10),
              controller: controller,
              decoration: InputDecoration(
                hintText: 'Search...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: buttonprimary), // Set the color you want here
                  borderRadius: BorderRadius.circular(10),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey), // Set the color you want here
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onSubmitted: onSubmitted,
            ),
          ),
          SizedBox(width: 10),
          CustomElevatedButton(
            text: "Search",
            fontWeight: FontWeight.w300,
            borderRadius: 10,
            onPressed: () {
              if (onSubmitted != null) {
                onSubmitted!(controller.text);
              }
            },
          ),
        ],
      ),
    );
  }
}

