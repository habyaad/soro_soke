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
    await saveChatDetails(message);
    await _databaseService.store
        .collection(
            'messages/${getConversationID(message.receiver.uid, senderId: senderId)}/chat')
        .add(message.toJson());
  }

  Future<void> saveAIMessage(Message message, {senderId}) async {
    await _databaseService.store
        .collection(
        'messages/${getConversationID(message.receiver.uid, senderId: senderId)}/chat')
        .add(message.toJson());
  }
// Retrieve messages between two users

  Stream<QuerySnapshot<Object?>> getMessagesBetweenUsers(String friendUid) {
    return _databaseService.store
        .collection('messages/${getConversationID(friendUid)}/chat')
        //.where("senderId", isEqualTo: user1Id)
        .orderBy("timestamp", descending: true)
        .snapshots();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getChats() {
    return _databaseService.store
        .collection('messages')
        .where("participantIds", arrayContains: _userService.currentUser!.uid)
        .orderBy("lastUpdatedAt", descending: true)
        .snapshots();
  }

  saveChatDetails(Message message) async {
    await _databaseService.store
        .collection('messages')
        .doc(getConversationID(message.receiver.uid))
        .set({
      "lastMessage": message.content,
      "lastUpdatedAt": message.timestamp,
      "participantIds": [message.sender.uid, message.receiver.uid],
      "sender": message.sender.toJson(),
      "receiver": message.receiver.toJson()
    }).onError((e, _) => log("Error writing document: $e"));
  }
}
