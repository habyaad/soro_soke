import 'package:firebase_auth/firebase_auth.dart';
import 'package:soro_soke/services/user_service.dart';
import 'package:stacked/stacked.dart';
import 'package:soro_soke/app/app.locator.dart';
import 'package:soro_soke/app/app.router.dart';
import 'package:stacked_services/stacked_services.dart';

class StartupViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final _userService = locator<UserService>();

  Stream<User?> get authStream => _userService.authStream;
  // Place anything here that needs to happen before we get into the application
 /* Future runStartupLogic() async {
    await Future.delayed(const Duration(seconds: 3));

    // This is where you can make decisions on where your app should navigate when
    // you have custom startup logic
  }*/

  void navigateToHome() async {
    await Future.delayed(const Duration(seconds: 3));
    _navigationService.replaceWith("/home-view");
  }

  void navigateToLogin() async {
    await Future.delayed(const Duration(seconds: 3));
    _navigationService.replaceWithLoginView();
  }
}
