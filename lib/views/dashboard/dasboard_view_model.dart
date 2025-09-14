import 'package:biz_contact/models/business_model.dart';
import 'package:biz_contact/services/network_service.dart';
import 'package:flutter/material.dart';

class DashboardViewModel extends ChangeNotifier {
  final ApiClient _apiClient = ApiClient();

  List<CompanyModels> _companies = [];
  List<CompanyModels> get companies => _companies;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _error;
  String? get error => _error;

  Future<void> fetchCompanies() async {
    _isLoading = true;
    _error = null;
    notifyListeners();
    final result = await _apiClient.fetchCompanies();
    if (result.isSuccess && result.data != null) {
      _companies = result.data!;
    } else {
      _companies = [];
      _error = result.error;
    }
    _isLoading = false;
    notifyListeners();
  }
}
