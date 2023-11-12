import 'package:firebase_auth/firebase_auth.dart';
import 'package:stacked/stacked.dart';
import '../../../app/app.locator.dart';
import '../../../services/authentication_service.dart';
import '../../../services/toast_service.dart';
import '../../../services/user_service.dart';

class ProfileViewModel extends BaseViewModel {
  final _authService = locator<AuthenticationService>();
  final _toastService = locator<ToastService>();
  final _userService = locator<UserService>();

  User? currentUser;

  void initializeUser() async {
    currentUser = _userService.currentUser;
  }

  void uploadPhoto() async {
    await _userService.changeProfilePhoto();
    initializeUser();
    rebuildUi();
  }

  void logOut() async {
    await _authService.signOut();
    _toastService.success("Sign-out successful, Login again to continue");
  }
}
