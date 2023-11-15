import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String _defaultProfilePhotoPath =
      "https://firebasestorage.googleapis.com/v0/b/soro-soke-f0a15.appspot.com/o/profile_images%2Fdefault-avatar.png?alt=media&token=5a499abc-af14-4c71-9b95-fc7755a74eaa";

  final String name;
  final String email;
  final String? profilePhotoUrl;
  final String uid;
  final DateTime? dateCreated;

  UserModel({
    required this.name,
    required this.email,
    this.profilePhotoUrl,
    required this.uid,
    this.dateCreated,
  });

  //DateTime get currentDateTime => DateTime.now();

  factory UserModel.fromJson(Map<String, dynamic> json) {
    // Convert Firestore Timestamp to DateTime
    DateTime? dateCreated;
    if (json['dateCreated'] is Timestamp) {
      dateCreated = (json['dateCreated'] as Timestamp).toDate();
    }
    return UserModel(
        name: json['name'],
        email: json['email'],
        uid: json['uid'],
        dateCreated: dateCreated,
        profilePhotoUrl: json['profilePhotoUrl']);
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'uid': uid,
      'dateCreated': FieldValue.serverTimestamp(),
      'profilePhotoUrl': profilePhotoUrl ?? _defaultProfilePhotoPath
    };
  }
}
