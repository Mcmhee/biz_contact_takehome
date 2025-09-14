import 'package:biz_contact/views/dashboard/dasboard_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Companies")),
      body: Consumer<DashboardViewModel>(
        builder: (context, viewModel, child) {
          if (viewModel.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (viewModel.companies.isEmpty) {
            return const Center(child: Text("No companies found"));
          }

          return ListView.builder(
            itemCount: viewModel.companies.length,
            itemBuilder: (context, index) {
              final company = viewModel.companies[index];
              return ListTile(
                title: Text(company.businessName ?? 'No Name'),
                subtitle: Text("${company.location} • ${company.contactNo}"),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.read<DashboardViewModel>().fetchCompanies(),
        child: const Icon(Icons.refresh),
      ),
    );
  }
}
