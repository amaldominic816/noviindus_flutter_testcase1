import 'dart:convert';

class PatientModel {
  String? name;
  List<PatientDetails>? patientdetailsSet;

  PatientModel({
    this.name,
    this.patientdetailsSet,
  });

  factory PatientModel.fromJson(Map<String, dynamic> json) {
    return PatientModel(
      name: json['name'],
      patientdetailsSet: json['patientdetailsSet'] != null
          ? List<PatientDetails>.from(json['patientdetailsSet'].map((x) => PatientDetails.fromJson(x)))
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
    'name': name,
    'patientdetailsSet': patientdetailsSet != null
        ? List<dynamic>.from(patientdetailsSet!.map((x) => x.toJson()))
        : null,
  };
}

class PatientDetails {
  String? treatmentName;

  PatientDetails({
    this.treatmentName,
  });

  factory PatientDetails.fromJson(Map<String, dynamic> json) {
    return PatientDetails(
      treatmentName: json['treatmentName'],
    );
  }

  Map<String, dynamic> toJson() => {
    'treatmentName': treatmentName,
  };
}
