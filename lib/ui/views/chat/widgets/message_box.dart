import 'package:flutter/material.dart';
import 'package:soro_soke/utils/app_colors.dart';
import 'package:soro_soke/utils/ui_helpers.dart';

import '../../../../models/message_model.dart';

class MessageBox extends StatelessWidget {
  final Message message;
  final bool sender;

  const MessageBox({super.key, required this.message, required this.sender});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: sender ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: const Radius.circular(10),
                bottomLeft: Radius.circular(!sender ? 0 : 10),
                topRight: const Radius.circular(10),
                bottomRight: Radius.circular(sender ? 0 : 10)),
            gradient: LinearGradient(
                colors: sender
                    ? [AppColors.lightPrimaryColor, AppColors.darkPrimaryColor]
                    : [AppColors.darkPrimaryColor, AppColors.lightPrimaryColor],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight)),
        constraints: BoxConstraints(
          maxWidth: (screenWidth(context)) * 0.6,
        ),
        child: Column(
          crossAxisAlignment:
              sender ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            Text(
              message.content,
              style: const TextStyle(fontSize: 16, color: Colors.white),
            ),
            Text(
              "${message.timestamp.hour.toString()}:${message.timestamp.minute.toString()}",
              style: const TextStyle(fontSize: 8, color: Colors.white70),
              textAlign: TextAlign.right,
            ),
          ],
        ),
      ),
    );
  }
}
