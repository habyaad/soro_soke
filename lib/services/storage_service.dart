import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';

import '../app/app.locator.dart';
import 'logger_service.dart';

class StorageService {
  final _loggerService = locator<LoggerService>();

  final storage = FirebaseStorage.instance;

  Future<String> uploadImageToFirebase(File imageFile) async {
    try {
      // Create a unique filename for the image
      String fileName = DateTime.now().millisecondsSinceEpoch.toString();

      // Reference to the Firebase Storage location
      Reference reference =
          storage.ref().child('profile_images').child('$fileName.jpg');

      // Upload the file to Firebase Storage
      TaskSnapshot taskSnapshot = await reference.putFile(imageFile);

      // Get the download URL of the uploaded image
      String downloadUrl = await taskSnapshot.ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      print('Error uploading image to Firebase Storage: $e');
      return '';
    }
  }

  Future<String?> getDefaultImage() async {
    try {
      Reference reference =
          storage.ref().child('profile_images').child('default-avatar.png');

      return reference.getDownloadURL();
    } catch (e) {
      print('Error uploading image to Firebase Storage: $e');
      return '';
    }
  }
}
