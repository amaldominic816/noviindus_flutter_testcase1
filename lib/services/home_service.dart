
import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:shared_preferences/shared_preferences.dart';

import '../constants/api.dart';
import '../models/patient_model.dart';

class PatientService {
  Future<List<Patientmodel>> getPatientList(String token) async {
    final url = Uri.parse( "${API().baseUrl}${API().PatientList}");
    final response = await http.get(url, headers: {
      'Authorization': 'Bearer $token',
    });

    if (response.statusCode == 200) {
      final responseBody = jsonDecode(response.body);
      if (responseBody is Map<String, dynamic>) {
        final patientList = responseBody['patient'];
        patientList;
        if (patientList is List<dynamic>) {
          return patientList.map((json) => Patientmodel(patient: [Patient.fromJson(json)])).toList();
        } else {
          throw Exception('API returned an unexpected response: ${response.body}');
        }
      } else {
        throw Exception('API returned an unexpected response: ${response.body}');
      }
    } else {
      throw Exception('API returned an unexpected response: ${response.statusCode}');
    }
  }
}


class TokenService {
  Future<String> getToken() async {
    // Implement secure token storage and retrieval
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token') ?? '';
  }
}