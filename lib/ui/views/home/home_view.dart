import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
import 'package:soro_soke/utils/app_colors.dart';
import 'package:stacked/stacked.dart';
import '../../../models/chat_model.dart';
import '../../../models/conversation_model.dart';
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
                  stream: viewModel.streamData,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Shimmer(
                        duration: const Duration(seconds: 4),
                        //Default value
                        interval: const Duration(seconds: 1),
                        //Default value: Duration(seconds: 0)
                        color: Colors.grey,
                        //Default value
                        colorOpacity: 0.01,
                        //Default value
                        enabled: true,
                        //Default value
                        direction: const ShimmerDirection.fromLTRB(),
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.grey.withOpacity(.01),
                              borderRadius: BorderRadius.circular(8)),
                          width: double.infinity,
                          height: 100,
                        ),
                      );
                    } else if (!snapshot.hasData ||
                        snapshot.data!.docs.isEmpty) {
                      return const Center(
                          child: Text(
                        "No chats, add friends to start chatting",
                        style: TextStyle(color: Colors.white),
                      ));
                    } else {
                      List<Conversation> convos =
                          snapshot.data!.docs.map((doc) {
                        Map<String, dynamic> data = doc.data();
                        log("data : $data");

                        return Conversation.fromJson(data);
                      }).toList();

                      return ListView.separated(
                        shrinkWrap: true,
                        separatorBuilder: (ctx, idx) => verticalSpace(12),
                        itemCount: convos.length,
                        physics: const BouncingScrollPhysics(),
                        // Show the latest message at the bottom
                        itemBuilder: (context, index) {
                          bool sender = convos[index].sender.uid ==
                              viewModel.currentUser!.uid;
                          ChatModel receiver = sender
                              ? convos[index].receiver
                              : convos[index].sender;
                          String msg = sender
                              ? "You: ${convos[index].lastMessage}"
                              : convos[index].lastMessage;
                          return ListTile(
                            minVerticalPadding: 12,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            tileColor: const Color(0xFF261C2C),
                            onTap: () {
                              viewModel.goToChat(receiver);
                            },
                            leading: CircleAvatar(
                              radius: 20,
                              backgroundImage:
                                  NetworkImage(receiver.photoUrl ?? ""),
                            ),
                            title: Text(
                              receiver.name ?? "",
                              style: const TextStyle(
                                  fontSize: 18, color: Colors.pinkAccent),
                            ),
                            subtitle: Text(
                              msg,
                              style: const TextStyle(
                                  fontSize: 10,
                                  color: Colors.white70,
                                  fontStyle: FontStyle.italic,
                                  overflow: TextOverflow.ellipsis),
                            ),
                            trailing: Text(
                              "${convos[index].lastUpdatedAt.hour}: ${convos[index].lastUpdatedAt.minute}",
                              style: const TextStyle(
                                  fontSize: 10,
                                  color: Colors.white70,
                                  overflow: TextOverflow.ellipsis),
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
  void onViewModelReady(HomeViewModel viewModel) {
    super.onViewModelReady(viewModel);
    viewModel.initializeUser();
    viewModel.getFriends();
  }

  @override
  bool get fireOnViewModelReadyOnce => true;

  @override
  HomeViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      HomeViewModel();
}
