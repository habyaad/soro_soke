import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:soro_soke/app/app.locator.dart';
import 'package:soro_soke/app/app.router.dart';
import 'package:soro_soke/services/message_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import '../../../models/chat_model.dart';
import '../../../services/friend_service.dart';
import '../../../services/user_service.dart';

class HomeViewModel extends BaseViewModel {
  final _userService = locator<UserService>();
  final _messageService = locator<MessageService>();
  final _navigationService = locator<NavigationService>();

  late Stream<QuerySnapshot<Map<String, dynamic>>> streamData;
  User? currentUser;

  void initializeUser() async {
    currentUser = _userService.currentUser;
  }

  void getFriends() {
    streamData = _messageService.getChats();
    rebuildUi();
  }

  markChatAsRead(receiverUid) async {
    _messageService.markChatAsRead(receiverUid);
  }

  void goToChat(ChatModel user) {
    _navigationService.navigateToChatView(friend: user);
  }

  void goToAIChat() {
    _navigationService.navigateToAiChatView();
  }
}
