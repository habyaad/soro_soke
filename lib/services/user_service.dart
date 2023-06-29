import 'package:firebase_auth/firebase_auth.dart';
import '../app/app.locator.dart';
import 'authentication_service.dart';

class UserService {
  final _authService = locator<AuthenticationService>();

  User? get currentUser => _authService.auth.currentUser;

  Stream<User?> get authStream => _authService.auth.authStateChanges();

}
