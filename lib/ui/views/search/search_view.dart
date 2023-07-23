import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:soro_soke/utils/app_colors.dart';
import 'package:soro_soke/utils/ui_helpers.dart';
import 'package:stacked/stacked.dart';

import 'search_viewmodel.dart';

class SearchView extends StackedView<SearchViewModel> {
  const SearchView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    SearchViewModel viewModel,
    Widget? child,
  ) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          padding: const EdgeInsets.only(left: 25.0, right: 25.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              verticalSpace(40),

              const Text(
                "Search for users",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 24, color: kcPrimaryColor),
              ),
              const Text(
                "Find loved ones to send a message to",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, ),
              ),
              TextFormField(
                decoration: const InputDecoration(hintText: "username"),
                controller: viewModel.searchController,
                onChanged: (val) {
                  viewModel.updateSearchQuery(val);
                },
              ),
              verticalSpaceMedium,
              Expanded(
                child: StreamBuilder<QuerySnapshot>(
                  stream: viewModel.getResults(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else {
                      final users = snapshot.data!.docs;

                      return ListView.builder(
                        itemCount: users.length,
                        itemBuilder: (context, index) {
                          final user = users[index].data() as Map;
                          if (kDebugMode) {
                            print(user);
                          }
                          return ListTile(
                            title: Text(user['name']),
                            subtitle: Text(user['email']),
                          );
                        },
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  SearchViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      SearchViewModel();
}
