import 'package:soro_soke/app/app.router.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../app/app.locator.dart';

class OnboardingViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();

  void navigateToLogin() async {
    _navigationService.replaceWithLoginView();
  }

  void navigateToRegister() async {
    _navigationService.replaceWithSignUpView();
  }
}
