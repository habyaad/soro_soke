import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
import 'package:soro_soke/utils/app_colors.dart';
import 'package:soro_soke/utils/ui_helpers.dart';
import 'package:stacked/stacked.dart';

import '../../common/general_button.dart';
import '../../common/profile_detail_tile.dart';
import '../../common/string_utils.dart';
import 'profile_viewmodel.dart';

class ProfileView extends StackedView<ProfileViewModel> {
  const ProfileView({super.key});

  @override
  Widget builder(
    BuildContext context,
    ProfileViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
              onPressed: () {
                viewModel.navigateToEditProfile();
              },
              icon: const Icon(
                Icons.edit,
                color: Colors.white,
              ))
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Center(
            child: Column(
              children: [
                const SizedBox(height: 20),
                GestureDetector(
                  onTap: () {
                    log('clicked');
                    viewModel.uploadPhoto();
                  },
                  child: Stack(
                    children: [
                      CircleAvatar(
                        radius: 60,
                        backgroundImage: NetworkImage(
                            viewModel.currentUser!.photoURL.toString()),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          width: 30,
                          height: 30,
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle, color: Colors.white),
                          child: const Icon(
                            Icons.camera_alt_rounded,
                            color: AppColors.backgroundColor,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  StringUtils.capitalize(
                      viewModel.currentUser!.displayName.toString()),
                  style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                const SizedBox(height: 10),
                Text(
                  viewModel.currentUser!.email.toString(),
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 20),

                FutureBuilder<DocumentSnapshot>(
                  future: viewModel.profile,
                  builder: (BuildContext context,
                      AsyncSnapshot<DocumentSnapshot> snapshot) {
                    if (snapshot.hasError) {
                      return const Text("Something went wrong");
                    }

                    if (snapshot.hasData && !snapshot.data!.exists) {
                      return const Text("Document does not exist");
                    }

                    if (snapshot.connectionState == ConnectionState.done) {
                      Map<String, dynamic> data =
                          snapshot.data!.data() as Map<String, dynamic>;
                      return Column(
                        children: [
                          ProfileDetailTile(
                            icon: Icons.phone,
                            label: 'Phone',
                            value: data['phoneNumber'] ?? 'Nil',
                          ),
                          // const ProfileDetailTile(
                          //   icon: Icons.location_on,
                          //   label: 'Location',
                          //   value: 'Lagos, Nigeria',
                          // ),
                          ProfileDetailTile(
                            icon: Icons.work,
                            label: 'About',
                            value: data['about'] ?? 'Nil',
                          ),
                        ],
                      );
                    }

                    return Shimmer(
                      duration: const Duration(seconds: 4),
                      //Default value
                      interval: const Duration(seconds: 1),
                      //Default value: Duration(seconds: 0)
                      color: Colors.white,
                      //Default value
                      colorOpacity: 0.8,
                      //Default value
                      enabled: true,
                      //Default value
                      direction: const ShimmerDirection.fromLTRB(),
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(.1),
                            borderRadius: BorderRadius.circular(8)),
                        width: double.infinity,
                        height: 100,
                      ),
                    );
                  },
                ),

                // Add more profile detail tiles as needed
                verticalSpaceMedium,
                GeneralButton(
                    onPressed: () {
                      viewModel.logOut();
                    },
                    buttonColor: AppColors.lightPrimaryColor,
                    buttonText: "Sign Out")
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void onViewModelReady(ProfileViewModel viewModel) {
    viewModel.initializeUser();
    viewModel.profile = viewModel.fetchProfile();
  }

  @override
  ProfileViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      ProfileViewModel();
}
