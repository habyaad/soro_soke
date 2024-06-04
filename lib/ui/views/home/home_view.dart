import 'package:flutter/material.dart';
import 'package:soro_soke/ui/common/general_button.dart';
import 'package:soro_soke/utils/app_colors.dart';
import 'package:stacked/stacked.dart';
import '../../../models/chat_model.dart';
import '../../../utils/ui_helpers.dart';
import 'home_viewmodel.dart';

class HomeView extends StackedView<HomeViewModel> {
  const HomeView({Key? key}) : super(key: key);

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
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Text(
                        'Hello, ${viewModel.currentUser!.displayName}!',
                        style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w900,
                            color: Colors.white),
                      ),
                      verticalSpace(24),
                      StreamBuilder(
                        stream: viewModel.getFriends(),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData ||
                              snapshot.data!.docs.isEmpty) {
                            return const Center(
                                child: Text(
                              "No chats, add friends to start chatting",
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
                              physics: const NeverScrollableScrollPhysics(),
                              // Show the latest message at the bottom
                              itemBuilder: (context, index) {
                                return ListTile(
                                  minVerticalPadding: 12,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  tileColor: const Color(0xff493a5e),
                                  onTap: () {
                                    viewModel.goToChat(ChatModel(
                                        name: friends[index]["name"],
                                        uid: friends[index]["id"],
                                        photoUrl: friends[index]
                                            ["profilePhoto"]));
                                  },
                                  leading: CircleAvatar(
                                    radius: 20,
                                    backgroundImage: NetworkImage(
                                        friends[index]["profilePhoto"]),
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
                    ],
                  ),
                ],
              ),
            ),
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
