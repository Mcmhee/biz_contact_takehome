import 'package:biz_contact/models/business_model.dart';
import 'package:flutter/material.dart';

class BusinessDetailsView extends StatelessWidget {
  final CompanyModels company;
  const BusinessDetailsView({super.key, required this.company});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(company.businessName ?? 'No Name'),
        automaticallyImplyLeading: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              title: Text(
                "Location: ${company.location ?? 'No Location'}",
                style: const TextStyle(fontSize: 18),
              ),

              trailing: Icon(Icons.location_on, color: Colors.brown),
            ),
            SizedBox(height: 10),
            ListTile(
              title: Text(
                "Contact: ${company.contactNo ?? 'No Contact'}",
                style: const TextStyle(fontSize: 18),
              ),
              trailing: Icon(Icons.phone, color: Colors.brown),
            ),
          ],
        ),
      ),
    );
  }
}
