import 'dart:convert';

import 'package:soro_soke/models/chat_model.dart';

// To parse this JSON data, do
//
//     final message = messageFromJson(jsonString);

Message messageFromJson(String str) => Message.fromJson(json.decode(str));

String messageToJson(Message data) => json.encode(data.toJson());

class Message {
  final ChatModel sender;
  final ChatModel receiver;
  final String content;
  final DateTime timestamp;

  Message({
    required this.sender,
    required this.receiver,
    required this.content,
    required this.timestamp,
  });

  factory Message.fromJson(Map<String, dynamic> json) => Message(
        sender: ChatModel.fromJson(json["sender"]),
        receiver: ChatModel.fromJson(json["receiver"]),
        content: json["content"],
        timestamp: DateTime.parse(json["timestamp"]),
      );

  Map<String, dynamic> toJson() => {
        "sender": sender.toJson(),
        "receiver": receiver.toJson(),
        "content": content,
        "timestamp": timestamp.toIso8601String(),
      };
}
