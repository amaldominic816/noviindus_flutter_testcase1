
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_testcase_one/views/Registration/widgets/paymentoptions.dart';
import 'package:flutter_testcase_one/views/Registration/widgets/treatmentcard.dart';
import 'package:provider/provider.dart';

import '../../constants/customButton.dart';
import '../../constants/customDropdown.dart';
import '../../constants/customTextfield.dart';
import '../../provider/addtreatment_provider.dart';
import '../../provider/registration_provider.dart';
import 'addtreatment.dart';

class Registerscreen extends StatelessWidget {
  Registerscreen({super.key});



  @override
  Widget build(BuildContext context) {
    return Consumer <RegistrationController>(
        builder: (context, registrationcontroller, child) {
          return Scaffold(
            appBar: AppBar(
              elevation: 0,
              bottom: PreferredSize(
                preferredSize: Size(MediaQuery.of(context).size.width, 30),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 25, bottom: 10),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Register Now",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    Divider(
                      height: 1,
                      color: Color.fromRGBO(0, 0, 0, 0.2),
                      thickness: 1,
                    ),
                  ],
                ),
              ),
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomTextField(
                      controller: registrationcontroller.nameController,
                      keyboardType: TextInputType.name,
                      hintText: "Enter Your Full Name",
                      title: "Name",
                    ),
                    CustomTextField(
                      controller: registrationcontroller.phoneController,
                      keyboardType: TextInputType.number,
                      hintText: " Enter Your Whatsapp Number",
                      title: "Whatsapp Number",
                    ),
                    CustomTextField(
                      controller: registrationcontroller.addressController,
                      keyboardType: TextInputType.streetAddress,
                      hintText: "Enter Your full address",
                      title: "Address",
                    ),
                    CustomDropdown(
                      items: ["Kozhikode","Palakkad","Thrissur","Kannur"],
                      hintText: "Choose Your Location",
                      title: "Location",
                    ),
                    Consumer<RegistrationController>(
                      builder: (context, controller, child) {
                        final items = controller.Branches;
                        List<String> NewBranchData = [];

                        for (int i = 0; i < items.length; i++) {
                          final data = items.elementAt(i).name;
                          NewBranchData.add(data.toString());
                        }

                        return CustomDropdown(
                          items: NewBranchData.toList() ,
                          hintText: "Choose Branch",
                          title: "Branch",
                          onChanged: (value) {
                            // You can handle the selected value here
                            print('Selected value: $value');
                            registrationcontroller.setBranch(value.toString());
                          },
                        );
                      },
                    ),
                    Consumer<addtreatmentcontroller>(
                      builder: (context, value, child) {
                        return ListView.separated(
                          itemCount: value.treatments.length,
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            final treatment = value.treatments[index];

                            return TreatmentCard(
                                treatmentname: treatment['treatment'],
                                malecount: treatment['male'],
                                femalecount: treatment['female'],

                                index:  index,

                                delete: () {
                                  // Provider.of<addtreatmentcontroller>(context, listen:false).removeTreatment(index);
                                  value.removeTreatment(index);

                                }

                            );
                          }, separatorBuilder: (BuildContext context, int index) {
                          return SizedBox(height: 10,);
                        },
                        );
                      },
                    ),
                    Row(
                      children: [
                        Expanded(
                            child: CustomElevatedButton(
                              text: "+Add Treatment",
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return Dialog(
                                      backgroundColor: Colors.white,
                                      insetPadding: EdgeInsets.all(0),
                                      child: Addtreatment(),
                                    );
                                  },
                                ).then((value) =>
                                    Provider.of<RegistrationController>(context, listen: false).fetchTreatments());;
                              },
                              color: Color.fromRGBO(56, 154, 72, 0.4),
                              textColor: Colors.black,
                            )),
                      ],
                    ),
                    CustomTextField(
                      controller: registrationcontroller.totalAmountController,
                      keyboardType: TextInputType.number,
                      hintText: "Enter Amount",
                      title: "Amount",),
                    CustomTextField(
                      controller: registrationcontroller.discountAmountController,
                      keyboardType: TextInputType.number,
                      hintText: " Enter Discount Amount",
                      title: "Amount",),
                    PaymentOptionsWidget(onChanged: (value) {
                      print(value);
                      registrationcontroller.paymentController.text = value.toString();
                    },),
                    CustomTextField(
                      controller: registrationcontroller.advanceAmountController,
                      keyboardType: TextInputType.number,
                      hintText:"Advance Amount",
                      title: "Advance",),
                    CustomTextField(
                      controller: registrationcontroller.balanceAmountController,
                      keyboardType: TextInputType.number,
                      hintText: "Balance Amount",
                      title: "Balance",),

                    Row(
                      children: [
                        Expanded(child: CustomElevatedButton(text: "Saved", onPressed: () {
                          print("saved adeeddddddddddddddddddddddddddddddddddddddddddddd");
                          registrationcontroller.registerPatient();
                        }, textColor: Colors.white,)),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        }
    );
  }
}