import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:soro_soke/app/app.locator.dart';
import 'package:soro_soke/services/message_service.dart';
import 'package:soro_soke/services/user_service.dart';
import 'package:stacked/stacked.dart';

import '../../../models/message_model.dart';

class ChatViewModel extends BaseViewModel {
  final UserService _userService = locator<UserService>();
  final MessageService _messageService = locator<MessageService>();
  final TextEditingController messageController = TextEditingController();

  User? currentUser;
  String? chatDate;
  bool dateChecked = false;
  void initializeUser() async {
    currentUser = _userService.currentUser;
  }

  Future<void> sendMessage(String friendID) async {
    String messageContent = messageController.text.trim();
    messageController.clear();
    if (messageContent.isNotEmpty) {
      Message newMessage = Message(
        senderId: currentUser!.uid, // replace with the actual current user ID
        receiverId: friendID,
        content: messageContent,
        timestamp: DateTime.now(),
      );

      await _messageService.saveMessage(newMessage);
      //rebuildUi();
    }
  }

  Stream<QuerySnapshot<Object?>> getMessagesStream(String friendID) {
    return _messageService.getMessagesBetweenUsers(friendID);
  }
}
