import 'dart:convert';

List<CompanyModels> companyModelsFromJson(String str) =>
    List<CompanyModels>.from(
      json.decode(str).map((x) => CompanyModels.fromJson(x)),
    );

String companyModelsToJson(List<CompanyModels> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CompanyModels {
  final String? businessName;
  final String? location;
  final String? contactNo;

  CompanyModels({this.businessName, this.location, this.contactNo});

  factory CompanyModels.fromJson(Map<String, dynamic> json) => CompanyModels(
    businessName: json["businessName"],
    location: json["location"],
    contactNo: json["contactNo"],
  );

  Map<String, dynamic> toJson() => {
    "businessName": businessName,
    "location": location,
    "contactNo": contactNo,
  };
}
