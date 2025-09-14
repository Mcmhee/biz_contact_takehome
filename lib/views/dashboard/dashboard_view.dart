import 'package:biz_contact/models/business_model.dart';
import 'package:biz_contact/views/dashboard/dasboard_view_model.dart';
import 'package:biz_contact/views/details/details_view.dart';
import 'package:biz_contact/widgets/card_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DashboardView extends StatefulWidget {
  const DashboardView({super.key});

  @override
  State<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  @override
  void initState() {
    super.initState();
    // fetch once on startup
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<DashboardViewModel>().fetchCompanies();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Companies")),
      body: Consumer<DashboardViewModel>(
        builder: (context, viewModel, child) {
          final searchController = viewModel.searchController;

          if (viewModel.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (viewModel.error != null && viewModel.allCompanies.isEmpty) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Error: ${viewModel.error}",
                    style: const TextStyle(color: Colors.red),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () => viewModel.fetchCompanies(),
                    child: const Text("Retry"),
                  ),
                ],
              ),
            );
          }

          if (viewModel.allCompanies.isEmpty) {
            return const Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text("No companies found", style: TextStyle(fontSize: 20)),
                  SizedBox(height: 10),
                  Icon(Icons.business, size: 40, color: Colors.grey),
                ],
              ),
            );
          }

          return Column(
            children: [
              // Search bar
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: ValueListenableBuilder(
                  valueListenable: searchController,
                  builder: (context, value, child) {
                    return Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: searchController,
                            decoration: InputDecoration(
                              labelText: 'Search by name, location or contact',
                              prefixIcon: const Icon(Icons.search),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                                borderSide: BorderSide(
                                  color: Colors.grey.shade400,
                                  width: 1.0,
                                ),
                              ),
                            ),
                            onChanged: viewModel.searchCompanies,
                          ),
                        ),
                        if (searchController.text.isNotEmpty)
                          IconButton(
                            icon: const Icon(Icons.clear),
                            onPressed: () {
                              searchController.clear();
                              viewModel.clearSearch();
                            },
                          ),
                      ],
                    );
                  },
                ),
              ),
              const SizedBox(height: 10),

              if (viewModel.companies.isEmpty)
                const Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Text(
                    "No matching companies found.",
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                ),

              Expanded(
                child: ListView.builder(
                  itemCount: viewModel.companies.length,
                  itemBuilder: (context, index) {
                    final company = viewModel.companies[index];
                    return BusinessCard<CompanyModels>(
                      item: company,
                      onTap: () => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => BusinessDetailsView(company: company),
                        ),
                      ),
                      contentBuilder: (company) => Row(
                        children: [
                          CircleAvatar(
                            child: Text(
                              company.businessName?.isNotEmpty == true
                                  ? company.businessName![0]
                                  : '?',
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  company.businessName ?? 'No Name',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(company.location ?? 'No Location'),
                              ],
                            ),
                          ),
                          Text(company.contactNo ?? 'No Contact'),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        label: const Text("Refresh"),
        onPressed: () => context.read<DashboardViewModel>().fetchCompanies(),
        icon: const Icon(Icons.refresh),
        elevation: 0.5,
      ),
    );
  }
}
