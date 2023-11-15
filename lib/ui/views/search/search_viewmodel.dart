import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:soro_soke/app/app.router.dart';
import 'package:soro_soke/models/user_model.dart';
import 'package:soro_soke/services/user_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import '../../../app/app.locator.dart';
import '../../../services/database_service.dart';

class SearchViewModel extends BaseViewModel {
  final NavigationService _navigationService = locator<NavigationService>();
  final UserService _userService = locator<UserService>();
  final DatabaseService _databaseService = locator<DatabaseService>();
  final TextEditingController searchController = TextEditingController();

  User? currentUser;

  void initializeUser() async {
    currentUser = _userService.currentUser;
  }

  String searchQuery = "";
  List<UserModel> results = [];

  Future<void> getResults() async {
    results = [];
    print(searchController.text);
    QuerySnapshot querySnapshot = await _databaseService.store
        .collection('users')
        .where('name', isEqualTo: searchController.text)
        .get();
    if (querySnapshot.docs.isNotEmpty) {
      // User found
      for (var doc in querySnapshot.docs) {
        print('User found: ${doc.get("name")}');
        UserModel user = UserModel(
            name: doc.get("name"),
            email: doc.get("email"),
            uid: doc.get("uid"),
            profilePhotoUrl: doc.get("profilePhotoUrl")
            // Use the actual field name here
            );
        results.add(user);
        // Access user details using doc.data()
      }
    } else {
      print('User not found');
    }
    rebuildUi();
  }

  void goToUserProfile(UserModel user) {
    _navigationService.navigateToUserProfileView(user: user);
  }

  void goToProfile() {
    _navigationService.navigateToProfileView();
  }
}
