import 'package:firebase_auth/firebase_auth.dart';
import 'package:soro_soke/models/user_model.dart';
import 'package:soro_soke/services/database_service.dart';
import '../app/app.locator.dart';
import 'authentication_service.dart';

class UserService {
  final _authService = locator<AuthenticationService>();
  final _databaseService = locator<DatabaseService>();

  User? get currentUser => _authService.auth.currentUser;

  Stream<User?> get authStream => _authService.auth.authStateChanges();

  Future<void> createUser(UserModel user) async{
    await _databaseService.addUser(user);
  }
}
