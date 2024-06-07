import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import '../../../app/app.locator.dart';
import '../../../services/message_service.dart';
import '../../../services/user_service.dart';

class AiChatViewModel extends BaseViewModel {
  final UserService _userService = locator<UserService>();
  final NavigationService _navigationService = locator<NavigationService>();
  final MessageService _messageService = locator<MessageService>();
  final TextEditingController messageController = TextEditingController();

  late final GenerativeModel _model;
  late final ChatSession _chat;
  final ScrollController scrollController = ScrollController();
  final FocusNode textFieldFocus = FocusNode();
  final List<({Image? image, String? text, bool fromUser})> generatedContent =
      <({Image? image, String? text, bool fromUser})>[];

  bool loading = false;

  User? currentUser;
  String? chatDate;
  bool dateChecked = false;

  void initializeUser() async {
    currentUser = _userService.currentUser;
  }

  void initChat() {
    _model = GenerativeModel(
      model: 'gemini-1.5-flash-latest',
      apiKey: dotenv.env['GEMINI_API_KEY']!,
    );
    _chat = _model.startChat();
  }

  void scrollDown() {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => scrollController.animateTo(
        scrollController.position.maxScrollExtent,
        duration: const Duration(
          milliseconds: 750,
        ),
        curve: Curves.easeOutCirc,
      ),
    );
  }

  // Future<void> sendMessage(String friendID) async {
  //
  //   if (messageContent.isNotEmpty) {
  //     Message newMessage = Message(
  //       senderId: currentUser!.uid, // replace with the actual current user ID
  //       receiverId: friendID,
  //       content: messageContent,
  //       timestamp: DateTime.now(),
  //     );
  //
  //     await _messageService.saveMessage(newMessage);
  //     //rebuildUi();
  //   }
  // }

  Stream<QuerySnapshot<Object?>> getMessagesStream(String friendID) {
    return _messageService.getMessagesBetweenUsers(friendID);
  }

  void goBack() {
    _navigationService.back();
  }

  Future<void> sendChatMessage(BuildContext context) async {
    if(messageController.text.isEmpty){
      return;
    }
    String message = messageController.text.trim();
    messageController.clear();

    loading = true;
    rebuildUi();

    try {
      generatedContent.add((image: null, text: message, fromUser: true));
      final response = await _chat.sendMessage(
        Content.text(message),
      );
      final text = response.text;
      generatedContent.add((image: null, text: text, fromUser: false));

      if (text == null) {
        _showError('No response from API.', context);
        return;
      } else {
        loading = false;
        rebuildUi();

        scrollDown();
      }
    } catch (e) {
      _showError(e.toString(), context);
      loading = false;
      rebuildUi();
    } finally {
      messageController.clear();
      loading = false;
      rebuildUi();
      textFieldFocus.requestFocus();
    }
  }

  void _showError(String message, BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Something went wrong'),
          content: const SingleChildScrollView(
            child: SelectableText("Try again later or check your internet"),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            )
          ],
        );
      },
    );
  }
}
