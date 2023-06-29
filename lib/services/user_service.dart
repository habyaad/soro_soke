import 'package:firebase_auth/firebase_auth.dart';

class UserService {
  
  User? currentUser = FirebaseAuth.instance.currentUser;

  Stream<User?> authStream = FirebaseAuth.instance.authStateChanges();

}
