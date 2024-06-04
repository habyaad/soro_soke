import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:soro_soke/app/app.locator.dart';
import 'package:soro_soke/models/api_response_model.dart';
import 'package:soro_soke/models/user_model.dart';
import 'package:soro_soke/services/authentication_service.dart';
import 'package:soro_soke/services/toast_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../app/app.dialogs.dart';
import '../../../services/user_service.dart';

class SignUpViewModel extends BaseViewModel {
  final formKey = GlobalKey<FormState>();
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final _authService = locator<AuthenticationService>();
  final _userService = locator<UserService>();
  final _navigationService = locator<NavigationService>();
  final _toastService = locator<ToastService>();
  final _dialogService = locator<DialogService>();

  void signUp() async {
    String name = usernameController.text.toLowerCase();
    String email = emailController.text.toLowerCase();
    String password = passwordController.text;

    _dialogService.showCustomDialog(
      variant: DialogType.loading,
    );
    ApiResponse response = await _authService.signUp(name, email, password);
    _dialogService.completeDialog(DialogResponse(confirmed: true));

    if (response.success) {
      User user = response.data;
      UserModel userModelData = UserModel(
          name: user.displayName.toString(),
          email: user.email.toString(),
          uid: user.uid);
      await _userService.createUser(userModelData);
      _toastService
          .success("${response.message}, login to access your account");
      _navigationService.replaceWith("/login-view");
    } else {
      _toastService.error(response.message);
    }
  }
}
