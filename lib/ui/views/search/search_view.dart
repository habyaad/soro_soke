import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:soro_soke/ui/common/custom_text_form_field.dart';
import 'package:soro_soke/utils/app_colors.dart';
import 'package:soro_soke/utils/ui_helpers.dart';
import 'package:stacked/stacked.dart';

import '../../../models/chat_model.dart';
import '../../../models/user_model.dart';
import 'search_viewmodel.dart';

class SearchView extends StackedView<SearchViewModel> {
  const SearchView({super.key});

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
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.only(left: 25.0, right: 25.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              verticalSpace(40),
              const Text(
                "Search for users",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 24, color: Colors.white),
              ),
              verticalSpace(8),
              const Text(
                "Find friends to send a message",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
              verticalSpace(24),
              CustomTextFormField(
                controller: viewModel.searchController,
                hintText: "username",
                suffix: Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: GestureDetector(
                    onTap: () {
                      viewModel.getResults();
                    },
                    child: Container(
                      width: 30,
                      height: 30,
                      decoration: const BoxDecoration(
                          color: AppColors.primaryColor,
                          shape: BoxShape.circle),
                      child: const Center(
                        child: Icon(
                          Icons.search,
                          color: Colors.white70,
                          size: 24,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              verticalSpace(16),
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
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      tileColor: const Color(0xff493a5e),
                      onTap: () {
                        if (user.uid == viewModel.currentUser!.uid) {
                          viewModel.goToProfile();
                        }
                        viewModel.goToUserProfile(ChatModel(
                            name: user.name,
                            uid: user.uid,
                            photoUrl: user.profilePhotoUrl.toString()));
                      },
                      leading: CircleAvatar(
                        radius: 30,
                        backgroundImage: NetworkImage(user.profilePhotoUrl!),
                      ),
                      title: Text(
                        user.name,
                        style: const TextStyle(
                            fontSize: 24, color: Colors.pinkAccent),
                      ),
                      subtitle: Text(
                        user.email,
                        style:
                            const TextStyle(fontSize: 12, color: Colors.white),
                      ),
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
