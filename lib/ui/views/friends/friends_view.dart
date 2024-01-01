import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
import 'package:soro_soke/utils/app_colors.dart';
import 'package:soro_soke/utils/ui_helpers.dart';
import 'package:stacked/stacked.dart';

import '../../../models/chat_model.dart';
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
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColors.backgroundColor,
        title: const Text(
          'My Friends',
          style: TextStyle(
              color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              verticalSpaceSmall,
              StreamBuilder(
                  stream: viewModel.requests(),
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
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white10,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: Colors.white10)),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 8),
                          width: double.infinity,
                          child: Text(
                            'Friend requests(${snapshot.data!.docs.length})',
                            style: const TextStyle(
                                fontSize: 14, color: Colors.white),
                          ),
                        ),
                      );
                    }
                  }),
              verticalSpaceMedium,
              StreamBuilder(
                stream: viewModel.getFriends(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return const Center(
                        child: Text(
                      "No friends",
                      style: TextStyle(color: Colors.white),
                    ));
                  } else {
                    List friends = snapshot.data!.docs.map((doc) {
                      Map<String, dynamic> data = doc.data();
                      print("data : $data");

                      return data;
                    }).toList();

                    return ListView.separated(
                      shrinkWrap: true,
                      separatorBuilder: (ctx, idx) => verticalSpace(12),
                      itemCount: friends.length,
                      reverse: true,
                      // Show the latest message at the bottom
                      itemBuilder: (context, index) {
                        return ListTile(
                          minVerticalPadding: 12,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          tileColor: const Color(0xff493a5e),
                          onTap: () {
                            viewModel.goToUserProfile(ChatModel(
                                name: friends[index]["name"],
                                uid: friends[index]["id"],
                                photoUrl: friends[index]["profilePhoto"]));
                          },
                          leading: CircleAvatar(
                            radius: 15,
                            backgroundImage:
                                NetworkImage(friends[index]["profilePhoto"]),
                          ),
                          title: Text(
                            friends[index]["name"],
                            style: const TextStyle(
                                fontSize: 16, color: Colors.pinkAccent),
                          ),
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
