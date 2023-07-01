import 'package:stacked/stacked.dart';
import '../../../app/app.locator.dart';
import '../../../services/authentication_service.dart';
import '../../../services/toast_service.dart';

class ProfileViewModel extends BaseViewModel {

  final _authService = locator<AuthenticationService>();
  final _toastService = locator<ToastService>();

  void logOut() async {
    await _authService.signOut();
    _toastService.success("Signout successful, Login again to continue");
  }

}
