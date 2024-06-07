import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:soro_soke/app/app.locator.dart';
import 'package:soro_soke/app/app.router.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import '../../../models/chat_model.dart';
import '../../../services/friend_service.dart';
import '../../../services/user_service.dart';

class HomeViewModel extends BaseViewModel {
  final _userService = locator<UserService>();
  final _friendService = locator<FriendService>();
  final _navigationService = locator<NavigationService>();

  User? currentUser;

  void initializeUser() async {
    currentUser = _userService.currentUser;
  }

  Stream<QuerySnapshot<Map<String, dynamic>>>? getFriends() {
    return _friendService.getFriends();
  }

  void goToChat(ChatModel user) {
    _navigationService.navigateToChatView(friend: user);
  }
  void goToAIChat() {
    _navigationService.navigateToAiChatView();
  }
}
