import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String name;
  final String email;
  final String uid;
  final DateTime? dateCreated;

  UserModel({
    required this.name,
    required this.email,
    required this.uid,
    this.dateCreated,
  });

  //DateTime get currentDateTime => DateTime.now();

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
        name: json['name'],
        email: json['email'],
        uid: json['uid'],
        dateCreated: json['dateCreated']);
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'uid': uid,
      'dateCreated': FieldValue.serverTimestamp()
    };
  }
}
