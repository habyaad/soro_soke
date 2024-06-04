import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'package:soro_soke/models/user_model.dart';
import 'package:soro_soke/services/database_service.dart';
import 'package:soro_soke/services/storage_service.dart';
import 'package:soro_soke/utils/image_picker_helper.dart';
import '../app/app.locator.dart';
import 'authentication_service.dart';
import 'dart:io';

class UserService {
  final _authService = locator<AuthenticationService>();
  final _storageService = locator<StorageService>();
  final _databaseService = locator<DatabaseService>();

  User? get currentUser => _authService.auth.currentUser;

  Stream<User?> get authStream => _authService.auth.authStateChanges();

  Future<void> createUser(UserModel user) async {
    await _databaseService.addUser(user);
  }

  Future<void> changeProfilePhoto() async {
    try {
      XFile? image = await ImagePickerHelper.getImageFromGallery();
      if (image == null) return;
      File file = File(image.path);

      // Upload the image to Firebase Storage
      String photoUrl = await _storageService.uploadImageToFirebase(file);
      User? user = _authService.auth.currentUser!;
      await _databaseService.store.collection('users').doc(user.uid).update({
        'profilePhotoUrl': photoUrl,
      });

      // Update the profile photo URL in Firestore

      await user.updatePhotoURL(photoUrl);
      await user.reload();
    } catch (e) {
      print('Error changing profile photo: $e');
    }
  }

  Future<UserModel?> getUserFromID(uid) async {
    final user = _databaseService.store.collection('users').doc(uid);

    Map<String, dynamic>? here = (await user.get()).data();
    return UserModel.fromJson(here!);
  }
}
