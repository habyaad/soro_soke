import 'package:flutter/cupertino.dart';
import 'package:soro_soke/app/app.locator.dart';
import 'package:soro_soke/models/api_response_model.dart';
import 'package:soro_soke/services/authentication_service.dart';
import 'package:soro_soke/services/toast_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class SignUpViewModel extends BaseViewModel {
  final formKey = GlobalKey<FormState>();
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final _authService = locator<AuthenticationService>();
  final _navigationService = locator<NavigationService>();
  final _toastService = locator<ToastService>();

  void signUp() async{
    String name = usernameController.text;
    String email = emailController.text;
    String password = passwordController.text;

    ApiResponse response = await _authService.signUp(name, email, password);

    if(response.success){
      _toastService.success("${response.message}, login to access your account");
      _navigationService.replaceWith("/login-view");
    }else{
      _toastService.error(response.message);
    }
  }
}
