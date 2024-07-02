import 'dart:convert';
import 'package:dio/dio.dart';
import '../constants/api.dart';
import '../models/branch_model.dart';
import '../models/treatment_model.dart';

class RegistrationService {
  final Dio _dio = Dio();

  Future<void> addPatient(Map<String, dynamic> body, String token) async {
    Uri url = Uri.parse("${API().baseUrl}${API().PatientUpdate}");

    try {
      final response = await _dio.post(
        url.toString(),
        data: jsonEncode(body),
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200) {
        print("Lead Added");
      } else if (response.statusCode == 500) {
        print("Failed to add lead. ${response.statusCode}");
      } else {
        print("Failed to add lead. Status code: ${response.statusCode}");
      }
    } catch (e) {
      print("Error adding lead: $e");
    }
  }

  Future<List<BranchModel>> getBranch(String token) async {
    final url = Uri.parse("${API().baseUrl}${API().BranchList}");

    try {
      final response = await _dio.get(
        url.toString(),
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      if (response.statusCode == 200) {
        final responseBody = response.data;
        if (responseBody is Map<String, dynamic>) {
          final branchJson = responseBody['branches'];
          if (branchJson != null && branchJson is List) {
            List<BranchModel> branches = branchJson
                .map((branchJson) => BranchModel.fromJson(branchJson))
                .toList();
            return branches;
          } else {
            throw Exception('API returned an unexpected response: ${response.data}');
          }
        } else {
          throw Exception('API returned an unexpected response: ${response.data}');
        }
      } else {
        throw Exception('Failed to load branches: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to load branches: $e');
    }
  }

  Future<List<Treatment>> fetchTreatments(String token) async {
    final url = Uri.parse("${API().baseUrl}${API().TreatmentList}");

    try {
      final response = await _dio.get(
        url.toString(),
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      if (response.statusCode == 200) {
        final jsonData = response.data;
        if (jsonData["status"] == true) {
          final treatmentsData = jsonData["treatments"];
          if (treatmentsData != null && treatmentsData is List) {
            return treatmentsData
                .map((treatmentJson) => Treatment.fromJson(treatmentJson))
                .toList();
          } else {
            throw Exception('Unexpected response structure: ${response.data}');
          }
        } else {
          throw Exception('API Error: ${jsonData["message"]}');
        }
      } else {
        throw Exception('Failed to load treatments: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to load treatments: $e');
    }
  }
}
