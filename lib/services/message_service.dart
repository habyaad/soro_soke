import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:soro_soke/services/user_service.dart';

import '../app/app.locator.dart';
import '../models/message_model.dart';
import 'database_service.dart';

class MessageService {
  final _databaseService = locator<DatabaseService>();
  final _userService = locator<UserService>();

  String getConversationID(String friendUid) {
    print("mine: ${_userService.currentUser!.uid.hashCode}");
    print("yours: ${friendUid.hashCode}");
    print("--------------------------------------");

    if (_userService.currentUser!.uid.hashCode < friendUid.hashCode) {
      print("${_userService.currentUser!.uid}$friendUid");
      return "${_userService.currentUser!.uid}$friendUid";
    } else {
      print("$friendUid${_userService.currentUser!.uid}");
      return "$friendUid${_userService.currentUser!.uid}";
    }
  }

// Save a message
  Future<void> saveMessage(Message message) async {
    await _databaseService.store
        .collection('messages/${getConversationID(message.receiverId)}/chat')
        .add({
      'senderId': message.senderId,
      'receiverId': message.receiverId,
      'content': message.content,
      'timestamp': message.timestamp,
    });
  }

// Retrieve messages between two users

  Stream<QuerySnapshot<Object?>> getMessagesBetweenUsers(String friendUid) {
    try {
      return _databaseService.store
          .collection('messages/${getConversationID(friendUid)}/chat')
          //.where("senderId", isEqualTo: user1Id)
          .orderBy("timestamp", descending: true)
          .snapshots();
    } catch (e) {
      print('Error retrieving messages: $e');
      // Handle errors more gracefully in a production app
      rethrow;
    }
  }
}
