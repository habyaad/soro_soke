import 'package:firebase_auth/firebase_auth.dart';
import 'package:soro_soke/app/app.locator.dart';
import 'package:soro_soke/services/authentication_service.dart';
import 'package:soro_soke/services/toast_service.dart';
import 'package:stacked/stacked.dart';
import '../../../services/user_service.dart';

class HomeViewModel extends BaseViewModel {
  final _userService = locator<UserService>();

  User? currentUser;

  void initializeUser() async {
    currentUser = _userService.currentUser;
  }
}
