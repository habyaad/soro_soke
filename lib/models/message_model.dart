// To parse this JSON data, do
//
//     final message = messageFromJson(jsonString);

import 'dart:convert';

Message messageFromJson(String str) => Message.fromJson(json.decode(str));

String messageToJson(Message data) => json.encode(data.toJson());

class Message {
  final String senderId;
  final String receiverId;
  final String content;
  final DateTime timestamp;

  Message({
    required this.senderId,
    required this.receiverId,
    required this.content,
    required this.timestamp,
  });

  factory Message.fromJson(Map<String, dynamic> json) => Message(
        senderId: json["senderId"],
        receiverId: json["receiverId"],
        content: json["content"],
        timestamp: DateTime.parse(json["timestamp"]),
      );

  Map<String, dynamic> toJson() => {
        "senderId": senderId,
        "receiverId": receiverId,
        "content": content,
        "timestamp": timestamp.toIso8601String(),
      };
}
