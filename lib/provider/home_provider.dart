
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

import '../models/patient_model.dart';
import '../services/home_service.dart';





class HomeProvider with ChangeNotifier {
  List<Patientmodel> _patients = [];
  bool _isLoading = false;
  final itemlenth = 0;

  List<Patientmodel> get patients => _patients;
  bool get isLoading => _isLoading;

  final _tokenService = TokenService();
  final _patientService = PatientService();

  Future<void> fetchPatientList() async {
    _isLoading = true;
    notifyListeners();

    try {
      final token = await _tokenService.getToken();
      final patients = await _patientService.getPatientList(token);
      _patients = patients;
      print("Success");
    } catch (e) {
      print("Error while fetching patients: $e");
      _patients = [];
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }



  HomeProvider() {
    fetchPatientList();
  }
}



