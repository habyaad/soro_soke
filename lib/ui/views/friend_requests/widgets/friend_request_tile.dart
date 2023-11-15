import 'package:flutter/material.dart';
import 'package:soro_soke/app/app.router.dart';
import 'package:soro_soke/models/user_model.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../../app/app.locator.dart';

class FriendRequestTile extends StatelessWidget {
  final UserModel user;
  final VoidCallback onAccept;
  final VoidCallback onDecline;

  const FriendRequestTile({
    super.key,
    required this.onAccept,
    required this.onDecline,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    final navigationService = locator<NavigationService>();

    return ListTile(
      title: GestureDetector(
        onTap: () {
          navigationService.navigateToUserProfileView(user: user);
        },
        child: Text(
          "${user.name} wants to be your friend",
          style: const TextStyle(fontSize: 18),
        ),
      ),
      leading: CircleAvatar(
        radius: 30,
        backgroundImage: NetworkImage(user.profilePhotoUrl.toString()),
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: const Icon(Icons.check),
            onPressed: onAccept,
            color: Colors.green,
          ),
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: onDecline,
            color: Colors.red,
          ),
        ],
      ),
    );
  }
}
