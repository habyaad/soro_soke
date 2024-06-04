import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:soro_soke/app/app.router.dart';
import 'package:soro_soke/services/database_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import '../../../app/app.locator.dart';
import '../../../services/authentication_service.dart';
import '../../../services/toast_service.dart';
import '../../../services/user_service.dart';

class ProfileViewModel extends BaseViewModel {
  final _authService = locator<AuthenticationService>();
  final _navigationService = locator<NavigationService>();
  final _toastService = locator<ToastService>();
  final _userService = locator<UserService>();
  final _databaseService = locator<DatabaseService>();

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

  Future<DocumentSnapshot> fetchProfile() async {
    return await _databaseService.fetchProfile(currentUser!.uid);
  }

  void navigateToEditProfile() async {
    _navigationService.navigateToEditProfileView();
  }

  void logOut() async {
    await _authService.signOut();
    _toastService.success("Sign-out successful, Login again to continue");
  }
}
