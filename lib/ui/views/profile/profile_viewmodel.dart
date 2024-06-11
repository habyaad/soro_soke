import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:soro_soke/app/app.router.dart';
import 'package:soro_soke/services/database_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import '../../../app/app.dialogs.dart';
import '../../../app/app.locator.dart';
import '../../../services/authentication_service.dart';
import '../../../services/toast_service.dart';
import '../../../services/user_service.dart';

class ProfileViewModel extends BaseViewModel {
  final _dialogService = locator<DialogService>();
  final _authService = locator<AuthenticationService>();
  final _navigationService = locator<NavigationService>();
  final _toastService = locator<ToastService>();
  final _userService = locator<UserService>();
  final _databaseService = locator<DatabaseService>();

  final formKey = GlobalKey<FormState>();
  final phoneController = TextEditingController();
  final aboutController = TextEditingController();

  int index = 0;
  User? currentUser;
  Future<DocumentSnapshot>? profile;

  void initializeUser() async {
    currentUser = _userService.currentUser;
  }

  void uploadPhoto() async {
    await _userService.changeProfilePhoto();
    initializeUser();
    rebuildUi();
  }

  void switchIndex(int newIndex) {
    index = newIndex;
    rebuildUi();
  }

  Future<DocumentSnapshot> fetchProfile() async {
    return await _databaseService.fetchProfile(currentUser!.uid);
  }

  void logOut() async {
    await _authService.signOut();
    _toastService.success("Sign-out successful, Login again to continue");
  }

  void saveProfile() async {
    Map<String, String> data = {
      "phoneNumber": phoneController.text,
      "about": aboutController.text
    };
    _dialogService.showCustomDialog(
      variant: DialogType.loading,
    );
    try {
      await _databaseService.saveProfile(currentUser!.uid, data);
      _dialogService.completeDialog(DialogResponse(confirmed: true));

      _toastService.success("Profile edited successfully");
      profile = fetchProfile();
      rebuildUi();
    } catch (e) {
      _dialogService.completeDialog(DialogResponse(confirmed: true));
      log(e.toString());
      _toastService.error("An error has occurred!");
    }
  }
}
