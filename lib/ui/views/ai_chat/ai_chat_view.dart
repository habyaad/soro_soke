import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
import 'package:stacked/stacked.dart';
import '../../../models/message_model.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/ui_helpers.dart';
import '../../common/custom_text_form_field.dart';
import '../chat/widgets/message_box.dart';
import 'ai_chat_viewmodel.dart';

class AiChatView extends StackedView<AiChatViewModel> {
  const AiChatView({super.key});

  @override
  Widget builder(
    BuildContext context,
    AiChatViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        automaticallyImplyLeading: true,
        backgroundColor: AppColors.backgroundColor,
        leadingWidth: 92,
        leading: Row(
          children: [
            IconButton(
                onPressed: () {
                  viewModel.goBack();
                },
                icon: const Icon(Icons.arrow_back)),
            Container(
                width: 36,
                height: 36,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      alignment: Alignment.centerLeft,
                      image: AssetImage(
                        "assets/images/Googles-Gemini-AI.jpeg",
                      )),
                )),
          ],
        ),
        title: const Text(
          "Personal AI",
          style: TextStyle(
              color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12),
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                colors: [AppColors.backgroundColor, AppColors.primaryColor],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter)),
        child: Column(
          children: [
            // Display Messages

            Expanded(
              child: StreamBuilder(
                stream: viewModel.getMessagesStream(viewModel.AI_ID),
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
                  } else if (!snapshot.hasData) {
                    log("no messages");

                    return const Center(
                      child: SizedBox(),
                    );
                  } else {
                    List<Message> messages = snapshot.data!.docs.map((doc) {
                      Map<String, dynamic> data =
                          doc.data() as Map<String, dynamic>;
                      //log("data : $data");

                      return Message.fromJson(data);
                    }).toList();
                    log("messages: $messages");
                    return ListView.separated(
                      controller: viewModel.scrollController,
                      reverse: true,
                      separatorBuilder: (ctx, idx) => verticalSpace(12),
                      itemCount: messages.length,
                      itemBuilder: (context, index) {
                        bool checked = viewModel.dateChecked;

                        viewModel.dateChecked == false
                            ? null
                            : viewModel.chatDate = DateFormat('MMM d', 'en_US')
                                .format(messages[index].timestamp);
                        viewModel.dateChecked = true;

                        return Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Visibility(
                              visible: checked == false &&
                                  viewModel.chatDate ==
                                      DateFormat('MMM d', 'en_US')
                                          .format(messages[index].timestamp),
                              replacement: const SizedBox(),
                              child: Text(
                                DateFormat('MMM d', 'en_US')
                                    .format(messages[index].timestamp),
                                style: const TextStyle(color: Colors.white),
                              ),
                            ),
                            MessageBox(
                              message: messages[index],
                              sender: messages[index].receiver.uid ==
                                  viewModel.AI_ID,
                            ),
                          ],
                        );
                      },
                    );
                  }
                },
              )

              /*ListView.separated(
                controller: viewModel.scrollController,
                separatorBuilder: (ctx, idx) => verticalSpace(12),
                itemCount: viewModel.generatedContent.length,
                itemBuilder: (context, index) {
                  bool checked = viewModel.dateChecked;

                  // viewModel.dateChecked == false
                  //     ? null
                  //     : viewModel.chatDate = DateFormat('MMM d', 'en_US')
                  //     .format(messages[index].timestamp);
                  // viewModel.dateChecked = true;

                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Visibility(
                      //   visible: checked == false &&
                      //       viewModel.chatDate ==
                      //           DateFormat('MMM d', 'en_US')
                      //               .format(viewModel.generatedContent[index]),
                      //   replacement: const SizedBox(),
                      //   child: Text(
                      //     DateFormat('MMM d', 'en_US')
                      //         .format(messages[index].timestamp),
                      //     style: const TextStyle(color: Colors.white),
                      //   ),
                      // ),
                      MessageBox(
                        message: Message(
                            senderId: '',
                            receiverId: '',
                            content: viewModel.generatedContent[index].text!,
                            timestamp: DateTime.now()),
                        sender: viewModel.generatedContent[index].fromUser,
                      ),
                    ],
                  );
                },
              )*/
              ,
            ),
            // Input for Sending Messages
            verticalSpace(24),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      child: CustomTextFormField(
                        //autoFocus: true,
                        //focusNode: viewModel.textFieldFocus,
                        controller: viewModel.messageController,
                        hintText: 'Enter a prompt...',
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  GestureDetector(
                    onTap: () {
                      FocusScopeNode currentFocus = FocusScope.of(context);

                      if (!currentFocus.hasPrimaryFocus) {
                        currentFocus.unfocus();
                      }
                      viewModel.sendChatMessage(context);
                    },
                    child: Container(
                      alignment: Alignment.center,
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10)),
                      child: Center(
                        child: viewModel.loading
                            ? const SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator())
                            : const Icon(
                                Icons.send,
                                color: AppColors.lightPrimaryColor,
                              ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void onViewModelReady(AiChatViewModel viewModel) {
    super.onViewModelReady(viewModel);
    viewModel.initializeUser();
    viewModel.initChat();
    //viewModel.scrollDown();
  }

  @override
  bool get fireOnViewModelReadyOnce => true;

  @override
  AiChatViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      AiChatViewModel();
}
