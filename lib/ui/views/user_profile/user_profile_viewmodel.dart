import 'package:soro_soke/app/app.router.dart';
import 'package:soro_soke/models/user_model.dart';
import 'package:soro_soke/services/friend_service.dart';
import 'package:soro_soke/services/toast_service.dart';
import 'package:soro_soke/services/user_service.dart';
import 'package:soro_soke/utils/enums.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../app/app.locator.dart';
import '../../../models/chat_model.dart';

class UserProfileViewModel extends BaseViewModel {
  final _friendService = locator<FriendService>();
  final _navigationService = locator<NavigationService>();
  final _userService = locator<UserService>();
  final _toastService = locator<ToastService>();
  Future<FriendshipState>? checkState;
  Future<UserModel?>? appUser;

  Future<void> sendRequest(friendUid) async {
    await _friendService.sendFriendRequest(friendUid);
    _toastService.success("request sent successfully");
    checkState = checkFriendshipState(friendUid);
    rebuildUi();
  }

  Future<FriendshipState> checkFriendshipState(friendUid) async {
    if (await _friendService.hasSentRequest(friendUid) == true) {
      return FriendshipState.pendingTO;
    } else if (await _friendService.isFriend(friendUid) == true) {
      return FriendshipState.friends;
    } else if (await _friendService.hasReceivedRequest(friendUid) == true) {
      return FriendshipState.pendingFrom;
    } else {
      return FriendshipState.notFriends;
    }
  }

  Future<bool> isFriend(friendUid) async {
    return await _friendService.isFriend(friendUid);
  }

  Future<void> cancelRequest(friendUid) async {
    bool result = await _friendService.cancelRequest(friendUid);
    if (result == true) {
      _toastService.success("request cancelled");
    } else {
      _toastService.success("an error has occurred!");
    }
    checkState = checkFriendshipState(friendUid);
    rebuildUi();
  }

  Future<void> removeFriend(friendUid) async {
    final result = await _friendService.removeFriend(friendUid);
    if (result != null) {
      _toastService.success("friend removed");
    } else {
      _toastService.success("an error has occurred!");
    }
    checkState = checkFriendshipState(friendUid);
    rebuildUi();
  }

  Future<void> acceptRequest(friendID) async {
    try {
      await _friendService.acceptRequest(friendID);
      _toastService.success("request accepted");
    } catch (e) {
      _toastService.success("an error occured");
    }
    checkState = checkFriendshipState(friendID);
    rebuildUi();
  }

  Future<void> rejectRequest(friendID) async {
    try {
      await _friendService.rejectRequest(friendID);
      _toastService.success("request rejected");
    } catch (e) {
      _toastService.success("an error occured");
    }
    checkState = checkFriendshipState(friendID);
    rebuildUi();
  }

  void goToChat(ChatModel user) {
    _navigationService.replaceWithChatView(friend: user);
  }

  Future<UserModel?> getUser(uid) {
    return _userService.getUserFromID(uid);
  }
}
