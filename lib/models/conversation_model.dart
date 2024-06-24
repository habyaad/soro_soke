// New Conversation model

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:soro_soke/models/chat_model.dart';

Conversation conversationFromJson(String str) =>
    Conversation.fromJson(json.decode(str));

String conversationToJson(Conversation data) => json.encode(data.toJson());

class Conversation {
  final String lastMessage;
  final DateTime lastUpdatedAt;
  final List<String> participantIds;
  final ChatModel sender;
  final bool read;
  final ChatModel receiver;

  Conversation({
    required this.lastMessage,
    required this.lastUpdatedAt,
    required this.participantIds,
    required this.sender,
    required this.read,
    required this.receiver,
  });

  factory Conversation.fromJson(Map<String, dynamic> json) => Conversation(
        sender: ChatModel.fromJson(json["sender"]),
        receiver: ChatModel.fromJson(json["receiver"]),
        lastMessage: json["lastMessage"],
        read: json["read"],
        lastUpdatedAt: json["lastUpdatedAt"] is Timestamp
            ? (json["lastUpdatedAt"] as Timestamp).toDate()
            : DateTime.parse(json["lastUpdatedAt"]),
        participantIds: List<String>.from(json["participantIds"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "sender": sender.toJson(),
        "receiver": receiver.toJson(),
        "lastMessage": lastMessage,
        "read": read,
        "lastUpdatedAt": lastUpdatedAt.toIso8601String(),
        "participantIds": List<dynamic>.from(participantIds.map((x) => x)),
      };
}
