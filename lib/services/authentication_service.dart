import 'package:firebase_auth/firebase_auth.dart';
import 'package:soro_soke/models/api_response_model.dart';
import 'package:stacked_services/stacked_services.dart';
import '../app/app.locator.dart';
import 'logger_service.dart';

class AuthenticationService {

  final auth = FirebaseAuth.instance;

  final _loggerService = locator<LoggerService>();
  final _navigationService = locator<NavigationService>();


  Stream<User?> get onAuthStateChanged => auth.authStateChanges();


  Future<ApiResponse> signUp(String name, String email, String password) async {
    User? user;

    try {
      UserCredential userCredential =
          await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      user = userCredential.user;
      await user!.updateDisplayName(name);
      await user.reload();

      user = auth.currentUser!;

      _loggerService.message(user.toString());
      // Signup successful, do something (e.g., navigate to home screen)
      ApiResponse response = ApiResponse(
          success: true,
          message: "Created account for ${user.displayName} successful",
          data: user);
      _loggerService.info(response.message);
      return response;
    } on FirebaseAuthException catch (e) {
      // Signup failed, handle the error

      if (e.code == 'weak-password') {
        ApiResponse response = ApiResponse(
            success: false,
            message: "The password provided is too weak.",
            data: null);
        _loggerService.warning(response.message);
        return response;
      } else if (e.code == 'email-already-in-use') {
        ApiResponse response = ApiResponse(
            success: false,
            message: "The account already exists for that email.",
            data: null);
        _loggerService.error(response.message);
        return response;
      } else {
        ApiResponse response = ApiResponse(
            success: false,
            message: "An unknown error has occured!",
            data: null);
        _loggerService.error(response.message);
        return response;
      }
    } catch (e) {
      // Signup failed, handle the error
      ApiResponse response =
          ApiResponse(success: false, message: e.toString(), data: null);
      _loggerService.error(response.message);

      return response;
    }
  }

  Future<ApiResponse> signIn(String email, String password) async {
    User? user;
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      user = userCredential.user!;
      await user.reload();

      user = auth.currentUser!;
      // Sign-in successful, do something (e.g., navigate to home screen)
      ApiResponse response = ApiResponse(
          success: true,
          message: "Login for ${user.displayName} successful",
          data: user);
      _loggerService.info(response.message);
      return response;
    } on FirebaseAuthException catch (e) {
      // Sign-in failed, handle the error

      if (e.code == 'user-not-found') {
        ApiResponse response = ApiResponse(
            success: false,
            message: "No user found for that email.",
            data: user);
        _loggerService.error(response.message);
        return response;
      } else if (e.code == 'wrong-password') {
        ApiResponse response = ApiResponse(
            success: false,
            message: "Wrong password provided for that user.",
            data: user);
        _loggerService.error(response.message);
        return response;
      } else {
        ApiResponse response = ApiResponse(
            success: false,
            message: "An unknown error has occured!",
            data: null);
        _loggerService.error(response.message);
        return response;
      }
    } catch (e) {
      ApiResponse response =
          ApiResponse(success: false, message: e.toString(), data: null);
      _loggerService.error(response.message);

      return response;
    }
  }

  Future<void> signOut() async{
    try{
      await auth.signOut();
      _navigationService.clearStackAndShow("/login-view");
      _loggerService.message("Logout successful");

    } catch(e){
      _loggerService.error(e.toString());
    }
  }
}
