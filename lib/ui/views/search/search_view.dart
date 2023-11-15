import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:soro_soke/ui/common/general_button.dart';
import 'package:soro_soke/utils/app_colors.dart';
import 'package:soro_soke/utils/ui_helpers.dart';
import 'package:stacked/stacked.dart';

import '../../../models/user_model.dart';
import 'search_viewmodel.dart';

class SearchView extends StackedView<SearchViewModel> {
  const SearchView({Key? key}) : super(key: key);

  @override
  void onViewModelReady(SearchViewModel viewModel) {
    super.onViewModelReady(viewModel);
    viewModel.initializeUser();
  }

  @override
  void onDispose(SearchViewModel viewModel) {
    // TODO: implement onDispose
    super.onDispose(viewModel);
  }

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
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              TextFormField(
                decoration: const InputDecoration(hintText: "username"),
                controller: viewModel.searchController,
              ),
              verticalSpaceLarge,
              GeneralButton(
                  onPressed: () {
                    viewModel.getResults();
                  },
                  buttonText: "Search"),
              verticalSpaceLarge,
              Visibility(
                visible: viewModel.results.isNotEmpty,
                replacement: verticalSpaceTiny,
                child: ListView.separated(
                  shrinkWrap: true,
                  itemCount: viewModel.results.length,
                  itemBuilder: (context, index) {
                    final UserModel user = viewModel.results[index];
                    if (kDebugMode) {
                      print(user);
                    }
                    return ListTile(
                      onTap: () {
                        if (user.uid == viewModel.currentUser!.uid) {
                          viewModel.goToProfile();
                        }
                        viewModel.goToUserProfile(user);
                      },
                      leading: CircleAvatar(
                        radius: 30,
                        backgroundImage: NetworkImage(user.profilePhotoUrl!),
                      ),
                      title: Text(user.name),
                      subtitle: Text(user.email),
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return verticalSpace(24);
                  },
                ),
              )
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
