import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:soro_soke/app/app.router.dart';
import 'package:soro_soke/services/toast_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../app/app.locator.dart';
import '../../../models/chat_model.dart';
import '../../../models/user_model.dart';
import '../../../services/friend_service.dart';
import '../../../services/user_service.dart';

class FriendRequestsViewModel extends BaseViewModel {
  final _friendService = locator<FriendService>();
  final _userService = locator<UserService>();
  final _navigationService = locator<NavigationService>();
  final _toastService = locator<ToastService>();

  Stream<QuerySnapshot<Map<String, dynamic>>>? requests() {
    return _friendService.getFriendRequests();
    /*for (int i = 0; i < result!.docs.length; i++) {
      QueryDocumentSnapshot<Object?> here = result.docs[i];
      UserModel? user = await _userService.getUserFromID(here.id);
      requests.add(user!);
    }*/

  }

  Future<void> acceptRequest(friendID) async {
    try {
      await _friendService.acceptRequest(friendID);
      _toastService.success("request accepted");
    } catch (e) {
      _toastService.success("an error occured");
    }
    rebuildUi();
  }

  Future<void> rejectRequest(friendID) async {
    try {
      await _friendService.rejectRequest(friendID);
      _toastService.success("request rejected");
    } catch (e) {
      _toastService.success("an error occured");
    }
    rebuildUi();
  }

  void goToUserProfile(ChatModel user) {
    _navigationService.navigateToUserProfileView(user: user);
  }
}
