import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:soro_soke/services/authentication_service.dart';
import 'package:soro_soke/services/database_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../app/app.dialogs.dart';
import '../../../app/app.locator.dart';
import '../../../services/toast_service.dart';
import '../../../services/user_service.dart';

class EditProfileViewModel extends BaseViewModel {
  final _databaseService = locator<DatabaseService>();
  final _toastService = locator<ToastService>();
  final _dialogService = locator<DialogService>();
  final _userService = locator<UserService>();
  final _authService = locator<AuthenticationService>();

  User? currentUser;

  void initializeUser() async {
    currentUser = _userService.currentUser;
    User? user = _authService.auth.currentUser!;
  }

  final formKey = GlobalKey<FormState>();
  final phoneController = TextEditingController();
  final aboutController = TextEditingController();

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
    } catch (e) {
      _dialogService.completeDialog(DialogResponse(confirmed: true));
      log(e.toString());
      _toastService.error("An error has occurred!");
    }
  }
}
