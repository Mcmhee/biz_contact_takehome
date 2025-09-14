import 'package:biz_contact/models/business_model.dart';
import 'package:biz_contact/services/network_service.dart';
import 'package:biz_contact/services/cache_service.dart';
import 'package:flutter/material.dart';

class DashboardViewModel extends ChangeNotifier {
  final ApiClient _apiClient = ApiClient();
  final StorageService _storageService = StorageService();

  final TextEditingController searchController = TextEditingController();

  List<CompanyModels> _allCompanies = [];
  List<CompanyModels> get allCompanies => _allCompanies;

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

    try {
      //Try cached first
      final cachedJson = await _storageService.getCompaniesJson();
      if (cachedJson != null) {
        try {
          _allCompanies = companyModelsFromJson(cachedJson);
          _companies = List.from(_allCompanies);
        } catch (e) {
          debugPrint('Error parsing cached JSON: $e');
        } finally {
          _isLoading = false;
        }
      }
      notifyListeners();

      //Fetch from API TO update cache and UI
      final result = await _apiClient.fetchCompanies();
      if (result.isSuccess && result.data != null) {
        _allCompanies = result.data!;
        _companies = List.from(_allCompanies);
        await _storageService.saveCompaniesJson(
          companyModelsToJson(_allCompanies),
        );
        _error = null;
      } else {
        if (cachedJson == null) {
          _allCompanies = [];
          _companies = [];
          _error = result.error ?? 'Unknown error';
        }
      }
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void searchCompanies(String query) {
    if (query.isEmpty) {
      clearSearch();
      return;
    }

    final lowerQuery = query.toLowerCase();
    _companies = _allCompanies.where((company) {
      final name = company.businessName?.toLowerCase() ?? '';
      final location = company.location?.toLowerCase() ?? '';
      final contact = company.contactNo?.toLowerCase() ?? '';
      return name.contains(lowerQuery) ||
          location.contains(lowerQuery) ||
          contact.contains(lowerQuery);
    }).toList();

    notifyListeners();
  }

  void clearSearch() {
    _companies = List.from(_allCompanies);
    notifyListeners();
  }
}
