import 'package:flutter/material.dart';
import 'package:soro_soke/models/user_model.dart';
import 'package:soro_soke/ui/common/custom_text_form_field.dart';
import 'package:soro_soke/ui/views/chat/widgets/message_box.dart';
import 'package:soro_soke/utils/app_colors.dart';
import 'package:soro_soke/utils/ui_helpers.dart';
import 'package:stacked/stacked.dart';
import '../../../models/chat_model.dart';
import '../../../models/message_model.dart';
import 'chat_viewmodel.dart';

class ChatView extends StackedView<ChatViewModel> {
  final ChatModel friend;

  const ChatView(this.friend, {Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    ChatViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        automaticallyImplyLeading: true,
        backgroundColor: AppColors.backgroundColor,
        title: Text(
          friend.name,
          style: const TextStyle(
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
                stream: viewModel.getMessagesStream(friend.uid),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    print("no messages");

                    return const Center(
                      child: SizedBox(),
                    );
                  }
                  List<Message> messages = snapshot.data!.docs.map((doc) {
                    Map<String, dynamic> data =
                        doc.data() as Map<String, dynamic>;
                    print("data : $data");

                    return Message(
                      senderId: data['senderId'],
                      receiverId: data['receiverId'],
                      content: data['content'],
                      timestamp: data['timestamp'].toDate(),
                    );
                  }).toList();
                  print("messages: $messages");
                  print("got messages");
                  return ListView.separated(
                    separatorBuilder: (ctx, idx) => verticalSpace(12),
                    itemCount: messages.length,
                    reverse: true, // Show the latest message at the bottom
                    itemBuilder: (context, index) {
                      return MessageBox(
                        message: messages[index],
                        sender: messages[index].receiverId == friend.uid,
                      );
                    },
                  );
                },
              ),
            ),
            // Input for Sending Messages
            verticalSpace(24),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 50,
                      child: CustomTextFormField(
                        controller: viewModel.messageController,
                        hintText: 'Type your message...',
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  GestureDetector(
                    onTap: () {
                      viewModel.sendMessage(friend.uid);
                    },
                    child: Container(
                      alignment: Alignment.center,
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10)),
                      child: const Center(
                        child: Icon(
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
  void onViewModelReady(ChatViewModel viewModel) {
    // TODO: implement onViewModelReady
    super.onViewModelReady(viewModel);
    viewModel.initializeUser();
  }

  @override
  ChatViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      ChatViewModel();
}
