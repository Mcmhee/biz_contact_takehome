import 'dart:convert';

List<CompanyModels> companyModelsFromJson(String str) =>
    List<CompanyModels>.from(
      json.decode(str).map((x) => CompanyModels.fromJson(x)),
    );

String companyModelsToJson(List<CompanyModels> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CompanyModels {
  final String? bizName;
  final String? location;
  final String? contactNo;

  CompanyModels({this.bizName, this.location, this.contactNo});

  factory CompanyModels.fromJson(Map<String, dynamic> json) => CompanyModels(
    bizName: json["bizName"],
    location: json["location"],
    contactNo: json["contactNo"],
  );

  Map<String, dynamic> toJson() => {
    "bizName": bizName,
    "location": location,
    "contactNo": contactNo,
  };
}
