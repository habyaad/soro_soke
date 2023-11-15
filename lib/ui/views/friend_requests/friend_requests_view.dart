import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:soro_soke/ui/views/friend_requests/widgets/friend_request_tile.dart';
import 'package:stacked/stacked.dart';

import '../../../models/user_model.dart';
import '../../../utils/ui_helpers.dart';
import 'friend_requests_viewmodel.dart';

class FriendRequestsView extends StackedView<FriendRequestsViewModel> {
  const FriendRequestsView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    FriendRequestsViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Friend Requests'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              verticalSpaceSmall,
              FutureBuilder<List<UserModel>>(
                  future: viewModel.requests(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(child: CircularProgressIndicator());
                    } else {
                      return ListView.separated(
                        shrinkWrap: true,
                        itemBuilder: (BuildContext context, int index) {
                          return FriendRequestTile(
                            onAccept: () {
                              viewModel
                                  .acceptRequest(snapshot.data![index].uid);
                            },
                            onDecline: () {
                              viewModel
                                  .rejectRequest(snapshot.data![index].uid);
                            },
                            user: snapshot.data![index],
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return verticalSpace(24);
                        },
                        itemCount: snapshot.data!.length,
                      );
                    }
                  }),
            ],
          ),
        ),
      ),
    );
  }

  @override
  FriendRequestsViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      FriendRequestsViewModel();
}
