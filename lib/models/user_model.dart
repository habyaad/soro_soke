import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String firstName;
  final String lastName;
  final String email;
  final String password;
  final String uid;
  final DateTime dateCreated;

  UserModel({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
    required this.uid,
    required this.dateCreated,
  });

  DateTime get currentDateTime => DateTime.now();

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
        firstName: json['firstName'],
        lastName: json['lastName'],
        email: json['email'],
        password: json['password'],
        uid: json['uid'],
        dateCreated: json['dateCreated']
    );
  }

  Map<String, dynamic> toJson(UserModel user) {
    return {
      'firstName': user.firstName,
      'lastName': user.lastName,
      'email': user.email,
      'password': user.password,
      'uid': user.uid,
      'dateCreated': FieldValue.serverTimestamp()
    };
  }
}
