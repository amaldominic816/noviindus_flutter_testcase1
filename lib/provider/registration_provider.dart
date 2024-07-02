
//





import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants/api.dart';
import '../models/branch_model.dart';
import '../models/treatment_model.dart';
import '../services/home_service.dart';
import '../services/registration_service.dart';

class RegistrationController with ChangeNotifier {
  final _tokenService = TokenService();
  final _RegistrationService = RegistrationService();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _executiveController = TextEditingController();
  final TextEditingController _paymentController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _totalAmountController = TextEditingController();
  final TextEditingController _discountAmountController = TextEditingController();
  final TextEditingController _advanceAmountController = TextEditingController();
  final TextEditingController _balanceAmountController = TextEditingController();
  final TextEditingController _dateAndTimeController = TextEditingController();
  List<int> _maleTreatments = [];
  List<int> _femaleTreatments = [];
  List<int> _selectedtreatments = [];
  String? _selectedBranch;
  String? get selectedBranch => _selectedBranch;


  TextEditingController get nameController => _nameController;
  TextEditingController get executiveController => _executiveController;
  TextEditingController get paymentController => _paymentController;
  TextEditingController get phoneController => _phoneController;
  TextEditingController get addressController => _addressController;
  TextEditingController get totalAmountController => _totalAmountController;
  TextEditingController get discountAmountController => _discountAmountController;
  TextEditingController get advanceAmountController => _advanceAmountController;
  TextEditingController get balanceAmountController => _balanceAmountController;
  TextEditingController get dateAndTimeController => _dateAndTimeController;
  List<int> get maleTreatments => _maleTreatments;
  List<int> get femaleTreatments => _femaleTreatments;
  List<int> get selectedtreatments => _selectedtreatments;


  void addMaleTreatment(int treatmentId) {
    _maleTreatments.add(treatmentId);
    notifyListeners();
  }

  void addFemaleTreatment(int treatmentId) {
    _femaleTreatments.add(treatmentId);
    notifyListeners();
  }

  void addTreatment(int treatmentId) {
    _selectedtreatments.add(treatmentId);
    notifyListeners();
  }

  void setBranch(String selectedbranch) {
    _selectedBranch = selectedbranch;
    notifyListeners();
  }

  Future<void> registerPatient() async {
    _isLoading = true;
    notifyListeners();

    final formData = FormData.fromMap({
      'name': nameController.text,
      'phone': phoneController.text,
      'address': addressController.text,
      'advanceAmount': double.parse(advanceAmountController.text),
      'balanceAmount': double.parse(balanceAmountController.text),
      'discountAmount': double.parse(discountAmountController.text),
      'totalAmount': double.parse(totalAmountController.text),
      'payment': paymentController.text,
      'dateNdTime': dateAndTimeController.text,
      'aleTreatments': _maleTreatments,
      'femaleTreatments': _femaleTreatments,
      'electedTreatments': _selectedtreatments,
      'branch': _selectedBranch,
    });

    try {
      final token = await _tokenService.getToken();
      final dio = Dio();
      // dio.options.headers['Authorization'] = 'Bearer $token';

      dio.interceptors.add(InterceptorsWrapper(onRequest: (RequestOptions options, handler) async {
        var customHeaders = {
          'Authorization': 'Bearer $token',
          'content-type': 'application/x-www-form-urlencoded',
          // Add your custom headers here
        };
        options.headers.addAll(customHeaders);

        handler.next(options); // Continue with the request
      }));

      final response = await dio.post(
        "${API().baseUrl}${API().PatientUpdate}",
        data: formData,
        options: Options(validateStatus: (status) => true),
      );

      if (response.statusCode == 200) {
        print("Lead Added");
      } else if (response.statusCode == 500) {
        print("Failed to add lead. ${response.statusCode}");
      } else {
        print("Error adding lead: ${response.statusCode}");
      }
    } catch (e) {
      print("Error adding lead: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }


  List<BranchModel> _Branches = [];
  bool _isLoading = false;

  List<BranchModel> get Branches => _Branches;
  bool get isLoading => _isLoading;

  Future<void> fetchBranch() async {
    _isLoading = true;
    notifyListeners();

    try {
      final token = await _tokenService.getToken();
      final Branches = await _RegistrationService.getBranch(token);
      _Branches = Branches;
      print(_Branches);
      print("Success");
    } catch (e) {
      print("Error while fetching patients: $e");
      _Branches = [];
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  getBranch() {
    fetchBranch();
  }

  List<Treatment> _treatments = [];

  List<Treatment> get treatments => _treatments;

  Future<void> fetchTreatments() async {
    _isLoading = true;
    notifyListeners();
    print("Fetching treatments...");

    try {
      final token = await _tokenService.getToken();
      print("Retrieved token: $token");

      final fetchedTreatments = await _RegistrationService.fetchTreatments(token);
      print("Fetched treatments: $fetchedTreatments");

      _treatments = fetchedTreatments;
      notifyListeners();
      print("Success");
    } catch (e) {
      print("Error while fetching treatments: $e");
      _treatments = [];
      notifyListeners();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  onRegister() {
    fetchBranch();
    fetchTreatments();
  }
}