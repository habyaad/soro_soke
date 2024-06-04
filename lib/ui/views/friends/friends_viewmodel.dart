import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:soro_soke/app/app.router.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../app/app.locator.dart';
import '../../../models/chat_model.dart';
import '../../../services/friend_service.dart';

class FriendsViewModel extends BaseViewModel {
  final _friendService = locator<FriendService>();
  final _navigationService = locator<NavigationService>();

  Stream<QuerySnapshot<Map<String, dynamic>>>? getFriends() {
    return _friendService.getFriends();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>>? requests() {
    return _friendService.getFriendRequests();
  }

  void goToFriendRequest() {
    _navigationService.navigateToFriendRequestsView();
  }

  void goToUserProfile(ChatModel user) {
    _navigationService.navigateToUserProfileView(user: user);
  }
}
