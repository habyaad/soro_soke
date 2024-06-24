import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:soro_soke/app/app.locator.dart';
import 'package:soro_soke/models/chat_model.dart';
import 'package:soro_soke/services/message_service.dart';
import 'package:soro_soke/services/user_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import '../../../models/message_model.dart';

class ChatViewModel extends BaseViewModel {
  final UserService _userService = locator<UserService>();
  final NavigationService _navigationService = locator<NavigationService>();
  final MessageService _messageService = locator<MessageService>();
  final TextEditingController messageController = TextEditingController();

  User? currentUser;
  String? chatDate;
  bool dateChecked = false;

  void initializeUser() async {
    currentUser = _userService.currentUser;
  }

  Future<void> sendMessage(ChatModel friend) async {
    String messageContent = messageController.text.trim();
    messageController.clear();
    if (messageContent.isNotEmpty) {
      Message newMessage = Message(
        content: messageContent,
        timestamp: DateTime.now(),
        sender: ChatModel(
            uid: currentUser!.uid,
            photoUrl: currentUser!.photoURL!,
            name: currentUser!.displayName!),
        receiver: ChatModel(
            uid: friend.uid, photoUrl: friend.photoUrl, name: friend.name),
      );

      await _messageService.saveMessage(newMessage);
      //rebuildUi();
    }
  }

  Stream<QuerySnapshot<Object?>> getMessagesStream(String friendID) {
    return _messageService.getMessagesBetweenUsers(friendID);
  }

  void markAsRead(String friendID) {
    _messageService.markChatAsRead(friendID);
  }

  void goBack() {
    _navigationService.back();
  }
}
