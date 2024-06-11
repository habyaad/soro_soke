import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:soro_soke/services/user_service.dart';

import '../app/app.locator.dart';
import '../models/message_model.dart';
import 'database_service.dart';

class MessageService {
  final _databaseService = locator<DatabaseService>();
  final _userService = locator<UserService>();

  String getConversationID(String friendUid, {senderId}) {
    String sender = senderId ?? _userService.currentUser!.uid;
    log("sender: ${sender.hashCode}");
    log("receiver: ${friendUid.hashCode}");
    log("--------------------------------------");

    if (sender.hashCode < friendUid.hashCode) {
      log("$sender$friendUid");
      return "$sender$friendUid";
    } else {
      log("$friendUid$sender");
      return "$friendUid$sender";
    }
  }

// Save a message
  Future<void> saveMessage(Message message, {senderId}) async {
    await _databaseService.store
        .collection(
            'messages/${getConversationID(message.receiverId, senderId: senderId)}/chat')
        .add({
      'senderId': message.senderId,
      'receiverId': message.receiverId,
      'content': message.content,
      'timestamp': message.timestamp,
    });
  }

// Retrieve messages between two users

  Stream<QuerySnapshot<Object?>> getMessagesBetweenUsers(String friendUid) {
    return _databaseService.store
        .collection('messages/${getConversationID(friendUid)}/chat')
        //.where("senderId", isEqualTo: user1Id)
        .orderBy("timestamp", descending: true)
        .snapshots();
  }
}
