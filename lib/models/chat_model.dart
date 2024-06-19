
// ChatModel class definition

class ChatModel {
  final String? name;
  final String uid;
  final String? photoUrl;

  ChatModel({
    required this.name,
    required this.uid,
    required this.photoUrl,
  });

  // Factory constructor for creating a ChatModel instance from JSON
  factory ChatModel.fromJson(Map<String, dynamic> json) => ChatModel(
        name: json["name"],
        uid: json["uid"],
        photoUrl: json["photoUrl"],
      );

  // Method for converting a ChatModel instance to JSON
  Map<String, dynamic> toJson() => {
        "name": name,
        "uid": uid,
        "photoUrl": photoUrl,
      };
}
