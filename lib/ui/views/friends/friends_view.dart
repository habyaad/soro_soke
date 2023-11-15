import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
import 'package:soro_soke/utils/ui_helpers.dart';
import 'package:stacked/stacked.dart';

import '../../../models/user_model.dart';
import 'friends_viewmodel.dart';

class FriendsView extends StackedView<FriendsViewModel> {
  const FriendsView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    FriendsViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Friends'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              verticalSpaceSmall,
              FutureBuilder<int>(
                  future: viewModel.requests(),
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
                              color: Colors.grey.withOpacity(.1),
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
                      return GestureDetector(
                        onTap: () {
                          viewModel.goToFriendRequest();
                        },
                        child: Text(
                          'Friend requests(${snapshot.data!})',
                          style: const TextStyle(fontSize: 24),
                        ),
                      );
                    }
                  }),
              verticalSpaceMedium,
              StreamBuilder(
                stream: viewModel.getFriends(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(child: Text("No friends"));
                  } else {
                    List<Future<UserModel>> friends = snapshot.data!;

                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: friends.length,
                      itemBuilder: (BuildContext context, int index) {
                        return FutureBuilder(
                          future: friends[index],
                          /*shrinkWrap: true,
                          itemCount: friends.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              title: Text(friends[index]),
                              subtitle:
                                  Text('Became Friends on: ${friends[index]}'),
                            );
                          },*/
                          builder: (BuildContext context,
                              AsyncSnapshot<dynamic> userSnapshot) {
                            if (userSnapshot.connectionState ==
                                ConnectionState.waiting) {
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
                                      color: Colors.grey.withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(8)),
                                  width: double.infinity,
                                  height: 40,
                                ),
                              ); // Show a loader while waiting for the future to resolve
                            } else if (userSnapshot.hasError) {
                              return Text(
                                  'Error fetching user: ${userSnapshot.error}');
                            } else if (!userSnapshot.hasData) {
                              return const Text('No user data available');
                            }

                            // Once the future resolves, display the user data
                            return ListTile(
                              onTap: () {
                                viewModel.goToUserProfile(userSnapshot.data!);
                              },
                              title: Text(userSnapshot.data!.name),
                              subtitle: Text(userSnapshot.data!.email),
                            );
                            // Include more UI elements to display user details
                          },
                        );
                      },
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  FriendsViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      FriendsViewModel();
}
