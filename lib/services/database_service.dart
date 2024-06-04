import 'package:cloud_firestore/cloud_firestore.dart';

import '../app/app.locator.dart';
import '../models/user_model.dart';
import 'logger_service.dart';

class DatabaseService {
  final _loggerService = locator<LoggerService>();

  final FirebaseFirestore store = FirebaseFirestore.instance;

  Future<void> addUser(UserModel user) {
    final CollectionReference usersCollection = store.collection('users');

    Map<String, dynamic> data = user.toJson();

    return usersCollection
        .doc(user.uid)
        .set(data)
        .then((value) => _loggerService.info("User Added"))
        .catchError(
            (error) => _loggerService.error("Failed to add user: $error"));
  }

  Future<void> saveProfile(String id, Map<String, String> profileData) {
    final CollectionReference usersCollection = store.collection('users');

    return usersCollection
        .doc(id)
        .set(profileData)
        .then((value) => _loggerService.info("Profile Edited"))
        .catchError((error) =>
            _loggerService.error("Failed to edit user profile: $error"));
  }

  Future<DocumentSnapshot> fetchProfile(String id) {
    print("got here");
    final CollectionReference usersCollection = store.collection('users');
    print(usersCollection.doc(id).get());
    return usersCollection.doc(id).get();
  }
}
