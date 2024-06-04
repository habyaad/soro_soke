import 'package:flutter/cupertino.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../app/app.dialogs.dart';
import '../../../app/app.locator.dart';
import '../../../models/api_response_model.dart';
import '../../../services/authentication_service.dart';
import '../../../services/toast_service.dart';

class LoginViewModel extends BaseViewModel {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final _authService = locator<AuthenticationService>();
  final _navigationService = locator<NavigationService>();
  final _toastService = locator<ToastService>();
  final _dialogService = locator<DialogService>();

  void signIn() async {
    String email = emailController.text.toLowerCase();
    String password = passwordController.text;

    _dialogService.showCustomDialog(
      variant: DialogType.loading,
    );
    ApiResponse response = await _authService.signIn(email, password);
    _dialogService.completeDialog(DialogResponse(confirmed: true));

    if (response.success) {
      _toastService.success(response.message);
      _navigationService.replaceWith("/bottom-nav-view");
    } else {
      _toastService.error(response.message);
    }
  }
}
