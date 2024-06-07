import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:soro_soke/models/user_model.dart';
import 'package:soro_soke/services/database_service.dart';
import 'package:soro_soke/services/logger_service.dart';
import 'package:soro_soke/services/user_service.dart';
import '../app/app.locator.dart';
import 'authentication_service.dart';

class FriendService {
  final _authService = locator<AuthenticationService>();
  final _loggerService = locator<LoggerService>();
  final _userService = locator<UserService>();
  final _databaseService = locator<DatabaseService>();

  User? get currentUser => _authService.auth.currentUser;

  Stream<QuerySnapshot<Map<String, dynamic>>>? getFriendRequests() {
    try {
      return _databaseService.store
          .collection('users/${currentUser!.uid}/pending_requests')
          .snapshots();
    } catch (e) {
      _loggerService.error(e.toString());
      return null;
    }
  }

  Stream<QuerySnapshot<Map<String, dynamic>>>? getFriends() {
    try {
      return _databaseService.store
          .collection('users/${currentUser!.uid}/friends')
          .snapshots();
    } catch (e) {
      _loggerService.error(e.toString());
      return null;
    }
  }

  Stream<QuerySnapshot<Map<String, dynamic>>>? getFriendsWithMessages() {
    try {
      return _databaseService.store
          .collection('users/${currentUser!.uid}/friends')
          .snapshots();
    } catch (e) {
      _loggerService.error(e.toString());
      return null;
    }
  }

  Future<QuerySnapshot<Object?>?> acceptRequest(friendID) async {
    try {
      final DateTime now = DateTime.now(); // Get current date and time

      final CollectionReference friendsCollection = _databaseService.store
          .collection('users/${currentUser!.uid}/friends');

      final CollectionReference friendsIDCollection =
          _databaseService.store.collection('users/$friendID/friends');

      final CollectionReference pendingRequestCollection = _databaseService
          .store
          .collection('users/${currentUser!.uid}/pending_requests');

      UserModel? friend = await _userService.getUserFromID(friendID);
      await friendsCollection.doc(friendID).set({
        'id': friendID,
        "name": friend!.name,
        "profilePhoto": friend.profilePhotoUrl,
        'dateBecameFriends': now,

        // Additional friend details you might want to store
      });
      await friendsIDCollection.doc(currentUser!.uid).set({
        'id': currentUser!.uid,
        "name": currentUser!.displayName,
        "profilePhoto": currentUser!.photoURL,
        'dateBecameFriends': now,

        // Additional friend details you might want to store
      });
      await pendingRequestCollection.doc(friendID).delete();
      _loggerService.info("friend added successfully");
      return friendsCollection.get();
    } catch (e) {
      _loggerService.error(e.toString());
      return null;
    }
  }

  Future<QuerySnapshot<Object?>?> removeFriend(friendID) async {
    try {
      final CollectionReference friendsCollection = _databaseService.store
          .collection('users/${currentUser!.uid}/friends');

      final CollectionReference friendsIDCollection =
          _databaseService.store.collection('users/$friendID/friends');

      await friendsCollection.doc(friendID).delete();
      await friendsIDCollection.doc(currentUser!.uid).delete();
      _loggerService.info("friend removed successfully");
      return friendsCollection.get();
    } catch (e) {
      _loggerService.error(e.toString());
      return null;
    }
  }

  Future<QuerySnapshot<Object?>?> rejectRequest(friendID) async {
    try {
      final CollectionReference pendingRequestCollection = _databaseService
          .store
          .collection('users/${currentUser!.uid}/pending_requests');

      await pendingRequestCollection.doc(friendID).delete();
      _loggerService.info("request rejected successfully");
      return pendingRequestCollection.get();
    } catch (e) {
      _loggerService.error(e.toString());
      return null;
    }
  }

  Future<bool> sendFriendRequest(friendID) async {
    try {
      final CollectionReference friendsIDCollection =
          _databaseService.store.collection('users/$friendID/pending_requests');

      await friendsIDCollection.doc(currentUser!.uid).set({
        'id': currentUser!.uid,
        "name": currentUser!.displayName,
        "profilePicture": currentUser!.photoURL,
      });

      _loggerService.info("request sent successfully");
      return true;
    } catch (e) {
      _loggerService.error(e.toString());
      return false;
    }
  }

  Future<bool> hasSentRequest(friendID) async {
    final CollectionReference friendsIDCollection =
        _databaseService.store.collection('users/$friendID/pending_requests');
    DocumentSnapshot result =
        await friendsIDCollection.doc(currentUser!.uid).get();
    if (result.exists) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> hasReceivedRequest(friendID) async {
    final CollectionReference friendsIDCollection = _databaseService.store
        .collection('users/${currentUser!.uid}/pending_requests');
    DocumentSnapshot result = await friendsIDCollection.doc(friendID).get();
    if (result.exists) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> cancelRequest(friendID) async {
    try {
      final CollectionReference friendsIDCollection =
          _databaseService.store.collection('users/$friendID/pending_requests');
      DocumentSnapshot result =
          await friendsIDCollection.doc(currentUser!.uid).get();
      if (result.exists) {
        await friendsIDCollection.doc(currentUser!.uid).delete();
        _loggerService.info("request cancelled successfully");
      } else {}
    } catch (e) {
      _loggerService.error(e.toString());
      return false;
    }
    return true;
  }

  Future<bool> isFriend(friendID) async {
    final CollectionReference friendsIDCollection =
        _databaseService.store.collection('users/${currentUser!.uid}/friends');
    DocumentSnapshot result = await friendsIDCollection.doc(friendID).get();
    if (result.exists) {
      return true;
    } else {
      return false;
    }
  }
}
