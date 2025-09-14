import 'dart:convert';
import 'package:biz_contact/models/business_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart';

class ApiClient {
  final Dio dio = Dio();

  ApiClient() {
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          if (options.method == 'GET' &&
              options.uri.toString() == 'https://fake.api/companies') {
            final jsonStr = await rootBundle.loadString(
              'assets/data/companies.json',
            );
            await Future.delayed(const Duration(seconds: 1));
            handler.resolve(
              Response(
                requestOptions: options,
                statusCode: 200,
                data: json.decode(jsonStr),
              ),
            );
            return;
          }
          handler.next(options);
        },
      ),
    );
  }

  Future<Result<List<CompanyModels>>> fetchCompanies() async {
    try {
      final response = await dio.get('https://fake.api/companies');
      if (response.statusCode == 200 && response.data != null) {
        final List data = response.data is List
            ? response.data
            : json.decode(response.data as String);
        final companies = data
            .map((e) => CompanyModels.fromJson(e as Map<String, dynamic>))
            .toList();
        return Result.success(companies);
      } else {
        return Result.error(
          'Failed to fetch companies: ${response.statusCode}',
        );
      }
    } on DioError catch (e) {
      return Result.error('Network error: ${e.message}');
    } catch (e) {
      return Result.error('Unexpected error: $e');
    }
  }
}

class Result<T> {
  final T? data;
  final String? error;

  Result._({this.data, this.error});

  factory Result.success(T data) => Result._(data: data);
  factory Result.error(String error) => Result._(error: error);

  bool get isSuccess => data != null && error == null;
}
