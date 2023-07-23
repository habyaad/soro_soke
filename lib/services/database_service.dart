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
}
