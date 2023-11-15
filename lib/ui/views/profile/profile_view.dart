import 'package:flutter/material.dart';
import 'package:soro_soke/utils/ui_helpers.dart';
import 'package:stacked/stacked.dart';

import '../../common/general_button.dart';
import '../../common/profile_detail_tile.dart';
import 'profile_viewmodel.dart';

class ProfileView extends StackedView<ProfileViewModel> {
  const ProfileView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    ProfileViewModel viewModel,
    Widget? child,
  ) {
    viewModel.initializeUser();
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Center(
            child: Column(
              children: [
                const SizedBox(height: 20),
                GestureDetector(
                  onTap: () {
                    print('clicked');
                    viewModel.uploadPhoto();
                  },
                  child: CircleAvatar(
                    radius: 60,
                    backgroundImage: NetworkImage(
                        viewModel.currentUser!.photoURL.toString()),
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  viewModel.currentUser!.displayName.toString(),
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  viewModel.currentUser!.email.toString(),
                  style: const TextStyle(fontSize: 16, color: Colors.grey),
                ),
                const SizedBox(height: 20),
                const ProfileDetailTile(
                  icon: Icons.phone,
                  label: 'Phone',
                  value: '+1 123-456-7890',
                ),
                const ProfileDetailTile(
                  icon: Icons.location_on,
                  label: 'Location',
                  value: 'New York, USA',
                ),
                const ProfileDetailTile(
                  icon: Icons.work,
                  label: 'Occupation',
                  value: 'Software Engineer',
                ),
                // Add more profile detail tiles as needed
                verticalSpaceMedium,
                GeneralButton(
                    onPressed: () {
                      viewModel.logOut();
                    },
                    buttonText: "Sign Out")
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  ProfileViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      ProfileViewModel();
}
