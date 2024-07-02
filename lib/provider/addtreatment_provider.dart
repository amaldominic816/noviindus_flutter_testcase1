import 'package:flutter/material.dart';

class addtreatmentcontroller extends ChangeNotifier {

  int male = 0;
  int female = 0;
  String treatmentname = "";

  List<Map<String, String>> treatments = [
    {
      'treatment': 'Treatment 1',
      'male': 'Male Treatment 1',
      'female': 'Female Treatment 1',
    },
    {
      'treatment': 'Treatment 2',
      'male': 'Male Treatment 2',
      'female': 'Female Treatment 2',
    },
  ];


//  List<Map<String, String>> get treatments => treatments;

  void removeTreatment(int index) {
    treatments.removeAt(index);
    notifyListeners();
  }

  void addTreatment() {
    treatments.add({
      'treatment': treatmentname,
      'male': male.toString(),
      'female': female.toString(),
    });
    notifyListeners();

    clear();

  }

  void maleIncrement() {
    male ++;
    notifyListeners();
  }

  void maleDecrement() {
    if (male > 0) male --;
    notifyListeners();
  }

  void femaleIncrement() {
    female ++;
    notifyListeners();
  }

  void femaleDecrement() {
    if (female > 0) female --;
    notifyListeners();
  }

  clear () {
    treatmentname = "";
    male = 0;
    female = 0;
    notifyListeners();
  }
}
