import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
import 'package:soro_soke/models/user_model.dart';
import 'package:soro_soke/utils/enums.dart';
import 'package:stacked/stacked.dart';

import '../../../utils/ui_helpers.dart';
import '../../common/general_button.dart';
import '../../common/profile_detail_tile.dart';
import 'user_profile_viewmodel.dart';

class UserProfileView extends StackedView<UserProfileViewModel> {
  final UserModel user;

  const UserProfileView(this.user, {Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    UserProfileViewModel viewModel,
    Widget? child,
  ) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Center(
            child: Column(
              children: [
                const SizedBox(height: 20),
                CircleAvatar(
                  radius: 60,
                  backgroundImage:
                      NetworkImage(user.profilePhotoUrl.toString()),
                ),
                const SizedBox(height: 20),
                Text(
                  user.name,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  user.email,
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
                FutureBuilder<FriendshipState>(
                    future: viewModel.checkState,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
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
                                color: Colors.grey,
                                borderRadius: BorderRadius.circular(8)),
                            width: double.infinity,
                            height: 40,
                          ),
                        );
                      } else if (snapshot.hasError) {
                        if (kDebugMode) {
                          print(snapshot.error);
                        }
                        return
                            //Text('Error: ${snapshot.error}');
                            const Center(child: Text('Error fetching data'));
                      } else {
                        if (snapshot.data == FriendshipState.pendingTO) {
                          return GeneralButton(
                              onPressed: () {
                                viewModel.cancelRequest(user.uid, user);
                              },
                              buttonText: "Cancel Request");
                        } else if (snapshot.data ==
                            FriendshipState.pendingFrom) {
                          return Row(
                            children: [
                              Expanded(
                                child: GeneralButton(
                                    buttonColor: Colors.green,
                                    onPressed: () {
                                      viewModel.acceptRequest(user.uid, user);
                                    },
                                    buttonText: "Accept Request"),
                              ),
                              const SizedBox(
                                width: 16,
                              ),
                              Expanded(
                                child: GeneralButton(
                                    buttonColor: Colors.redAccent,
                                    onPressed: () {
                                      viewModel.rejectRequest(user.uid, user);
                                    },
                                    buttonText: "Reject Request"),
                              ),
                            ],
                          );
                        } else if (snapshot.data == FriendshipState.friends) {
                          return GeneralButton(
                              onPressed: () {
                                viewModel.removeFriend(user.uid, user);
                              },
                              buttonText: "Remove Friend");
                        }
                        return GeneralButton(
                            onPressed: () {
                              viewModel.sendRequest(user.uid, user);
                            },
                            buttonText: "Send Request");
                      }
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void onViewModelReady(UserProfileViewModel viewModel) {
    // TODO: implement onViewModelReady
    super.onViewModelReady(viewModel);
    viewModel.checkState = viewModel.checkFriendshipState(user.uid);
  }

  @override
  UserProfileViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      UserProfileViewModel();
}
