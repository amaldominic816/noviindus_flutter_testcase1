import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../constants/colors.dart';
import '../../../constants/customButton.dart';
import '../../../constants/customDropdown.dart';
import '../../../models/patient_model.dart';

class PatientListView extends StatefulWidget {
  const PatientListView({Key? key}) : super(key: key);

  @override
  _PatientListViewState createState() => _PatientListViewState();
}

class _PatientListViewState extends State<PatientListView> {
  List<PatientModel> patients = []; // Your patient list

  bool isLoading = false;
  String? _selectedValue;
  final List<String> _items = ['Option 1', 'Option 2', 'Option 3'];
  @override
  void initState() {
    super.initState();
    fetchPatientList(); // Fetch patient list when widget initializes
  }

  Future<void> fetchPatientList() async {
    setState(() {
      isLoading = true;
    });

    // Simulating fetching data, replace with your actual fetch logic
    await Future.delayed(Duration(seconds: 2));

    // Replace with your actual data fetching logic
    List<PatientModel> fetchedPatients = [
      PatientModel(name: 'John Doe', patientdetailsSet: [
        PatientDetails(treatmentName: 'Treatment A'),
      ]),
      PatientModel(name: 'Jane Smith', patientdetailsSet: [
        PatientDetails(treatmentName: 'Treatment B'),
      ]),
    ];

    setState(() {
      patients = fetchedPatients;
      isLoading = false;
    });
  }

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(

        children: [
          SizedBox(height: 20,),

          SearchWidget(
            controller: TextEditingController(), // Use your own TextEditingController instance
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
                Text("Sort by:",style: TextStyle(
                  fontSize: 20,
                ),),

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
                    textStyle: TextStyle(color: Colors.black),
                  ),
                ),
              ],

                ),

                ),
SizedBox(height: 10),
Divider(),
          Expanded(
            child: RefreshIndicator(
              onRefresh: fetchPatientList,
              child: isLoading
                  ? Center(child: CircularProgressIndicator())
                  : patients.isEmpty
                  ? Center(child: Text('No patients found'))
                  : ListView.builder(
                itemCount: patients.length,
                itemBuilder: (context, patientModelIndex) {
                  final patient = patients[patientModelIndex];
                  final cardnumber = patientModelIndex + 1;
                  final patientDetails =
                      patient.patientdetailsSet!.first; // Assuming there's only one patient detail

                  return PatientCard(
                    cardnumber: cardnumber,
                    patientname: patient.name!,
                    package: patientDetails.treatmentName!,
                    ontap: () {
                      // Handle card tap action here
                    },
                  );
                },
              ),
            ),
          ),

        ],
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
            child: TextField(style: TextStyle(
              fontSize: 10
            ),
              controller: controller,
              decoration: InputDecoration(

                hintText: 'Search...',
                border: OutlineInputBorder(

                  borderRadius: BorderRadius.circular(10),


                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color:buttonprimary), // Set the color you want here
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
          SizedBox(width: 10,),
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

class PatientCard extends StatelessWidget {
  final cardnumber;
  final patientname;
  final package;
  final ontap;
  const PatientCard(
      {super.key, this.cardnumber, this.patientname, this.package, this.ontap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
      child: Container(
        height: 166,
        decoration: BoxDecoration(
          color: gradient1,
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
                      Text("Date: "),
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

