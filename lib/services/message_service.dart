import '../app/app.locator.dart';
import '../models/message_model.dart';
import 'database_service.dart';

class MessageService {
  final _databaseService = locator<DatabaseService>();

// Save a message
  Future<void> saveMessage(Message message) async {
    await _databaseService.store.collection('messages').add({
      'senderId': message.senderId,
      'receiverId': message.receiverId,
      'content': message.content,
      'timestamp': message.timestamp,
    });
  }

// Retrieve messages between two users
  Stream<List<Message>> getMessagesBetweenUsers(
      String user1Id, String user2Id) {
    return _databaseService.store
        .collection('messages')
        .where('senderId', whereIn: [user1Id, user2Id])
        .where('receiverId', whereIn: [user1Id, user2Id])
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map((snapshot) {
          return snapshot.docs.map((doc) {
            Map<String, dynamic> data = doc.data();
            return Message(
              senderId: data['senderId'],
              receiverId: data['receiverId'],
              content: data['content'],
              timestamp: data['timestamp'].toDate(),
            );
          }).toList();
        });
  }
}
