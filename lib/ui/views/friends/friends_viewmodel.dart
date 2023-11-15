import 'package:soro_soke/app/app.router.dart';
import 'package:soro_soke/models/user_model.dart';
import 'package:soro_soke/services/user_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../app/app.locator.dart';
import '../../../services/friend_service.dart';

class FriendsViewModel extends BaseViewModel {
  final _friendService = locator<FriendService>();
  final _userService = locator<UserService>();
  final _navigationService = locator<NavigationService>();

  List<UserModel> friends = [];

  Stream<List<Future<UserModel>>>? getFriends() {
    return _friendService.getFriends()?.map((ids) {
      return ids.map((id) {
        return _userService.getUserFromID(id).then((snapshot) {
          print(snapshot!.email);
          return snapshot;
        });
      }).toList();
    });
  }

  Future<UserModel?> getUser(uid) {
    return _userService.getUserFromID(uid);
  }

  Future<int>? requests() async {
    final result = await _friendService.getFriendRequests();
    return result!.size;
  }

  void goToFriendRequest() {
    _navigationService.navigateToFriendRequestsView();
  }

  void goToUserProfile(user) {
    _navigationService.navigateToUserProfileView(user: user);
  }
}
