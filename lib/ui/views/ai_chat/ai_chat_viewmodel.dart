import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import '../../../app/app.locator.dart';
import '../../../models/message_model.dart';
import '../../../services/message_service.dart';
import '../../../services/user_service.dart';

class AiChatViewModel extends BaseViewModel {
  String AI_ID = "PersonalAI";
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
      (_) => scrollController.hasClients
          ? scrollController.animateTo(
              scrollController.position.minScrollExtent,
              duration: const Duration(
                milliseconds: 750,
              ),
              curve: Curves.easeOutCirc,
            )
          : null,
    );
  }

  Future<void> saveMessage(
      String message, String senderID, String receiverID) async {
    Message newMessage = Message(
      senderId: senderID, // replace with the actual current user ID
      receiverId: receiverID,
      content: message,
      timestamp: DateTime.now(),
    );
    await _messageService.saveMessage(newMessage, senderId: senderID);
  }

  Stream<QuerySnapshot<Object?>> getMessagesStream(String friendID) {
    return _messageService.getMessagesBetweenUsers(friendID);
  }

  void goBack() {
    _navigationService.back();
  }

  Future<void> sendChatMessage(BuildContext context) async {
    if (messageController.text.isEmpty) {
      return;
    }
    String message = messageController.text.trim();
    messageController.clear();
    loading = true;
    rebuildUi();
    await saveMessage(message, currentUser!.uid, AI_ID);

    try {
      final response = await _chat.sendMessage(
        Content.text(message),
      );
      final text = response.text?.trim();

      if (text == null) {
        _showError('No response from API.', context);
        return;
      } else {
        log(text);

        await saveMessage(text, AI_ID, currentUser!.uid);
        loading = false;
        scrollDown();
        rebuildUi();
      }
    } catch (e) {
      log(e.toString());
      _showError("An error has occurred, try again!", context);
      loading = false;
      rebuildUi();
    } finally {
      loading = false;
      rebuildUi();
    }
  }

  void _showError(String message, BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Something went wrong'),
          content: SingleChildScrollView(
            child: SelectableText(message),
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
