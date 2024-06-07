import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:soro_soke/utils/app_colors.dart';
import 'package:stacked/stacked.dart';
import '../../../models/chat_model.dart';
import '../../../utils/ui_helpers.dart';
import '../../common/string_utils.dart';
import 'home_viewmodel.dart';

class HomeView extends StackedView<HomeViewModel> {
  const HomeView({super.key});

  @override
  Widget builder(
    BuildContext context,
    HomeViewModel viewModel,
    Widget? child,
  ) {
    viewModel.initializeUser();

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              verticalSpaceSmall,
              Text(
                'Hi, ${StringUtils.capitalize(viewModel.currentUser!.displayName!)}! 👋',
                style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Colors.white),
              ),
              verticalSpace(4),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Chats',
                    style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.w600,
                        color: Colors.white),
                  ),
                  InkWell(
                    onTap: () {
                      viewModel.goToAIChat();
                    },
                    child: Ink(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 8),
                      decoration: BoxDecoration(
                          color: Colors.black45,
                          borderRadius: BorderRadius.circular(8)),
                      child: const Row(
                        children: [
                          Text(
                            'Chat AI ',
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: Colors.white),
                          ),
                          Icon(
                            Icons.rocket,
                            color: Colors.blueAccent,
                            size: 16,
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
              verticalSpace(24),
              Expanded(
                child: StreamBuilder(
                  stream: viewModel.getFriends(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                      return const Center(
                          child: Text(
                        "No chats, add friends to start chatting",
                        style: TextStyle(color: Colors.white),
                      ));
                    } else {
                      List friends = snapshot.data!.docs.map((doc) {
                        Map<String, dynamic> data = doc.data();
                        log("data : $data");

                        return data;
                      }).toList();

                      return ListView.separated(
                        shrinkWrap: true,
                        separatorBuilder: (ctx, idx) => verticalSpace(12),
                        itemCount: friends.length,
                        physics: const BouncingScrollPhysics(),
                        // Show the latest message at the bottom
                        itemBuilder: (context, index) {
                          return ListTile(
                            minVerticalPadding: 12,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            tileColor: const Color(0xFF261C2C),
                            onTap: () {
                              viewModel.goToChat(ChatModel(
                                  name: friends[index]["name"],
                                  uid: friends[index]["id"],
                                  photoUrl: friends[index]["profilePhoto"]));
                            },
                            leading: CircleAvatar(
                              radius: 20,
                              backgroundImage:
                                  NetworkImage(friends[index]["profilePhoto"]),
                            ),
                            title: Text(
                              friends[index]["name"],
                              style: const TextStyle(
                                  fontSize: 18, color: Colors.pinkAccent),
                            ),
                            subtitle: const Text(
                              "Tap to chat 💬",
                              style: TextStyle(
                                  fontSize: 12, color: Colors.white70),
                            ),
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
  HomeViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      HomeViewModel();

/*@override
  void onViewModelReady(HomeViewModel viewModel) => SchedulerBinding.instance
      .addPostFrameCallback((timeStamp) => viewModel.initializeUser());*/
}
