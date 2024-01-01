import 'package:flutter/material.dart';
import 'package:soro_soke/ui/views/friend_requests/widgets/friend_request_tile.dart';
import 'package:soro_soke/utils/app_colors.dart';
import 'package:stacked/stacked.dart';
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
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
        automaticallyImplyLeading: true,
        backgroundColor: AppColors.backgroundColor,
        title: const Text(
          'My Friend Requests',
          style: TextStyle(
              color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              verticalSpaceSmall,
              StreamBuilder(
                  stream: viewModel.requests(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.data!.docs.isEmpty) {
                      return const Text(
                        "No friend requests",
                        style: TextStyle(color: Colors.white),
                      );
                    } else {
                      List requests = snapshot.data!.docs.map((doc) {
                        Map<String, dynamic> data = doc.data();
                        print("data : $data");
                        return data;
                      }).toList();
                      return ListView.separated(
                        shrinkWrap: true,
                        itemBuilder: (BuildContext context, int index) {
                          return FriendRequestTile(
                            onAccept: () {
                              viewModel.acceptRequest(requests[index]["id"]);
                            },
                            onDecline: () {
                              viewModel.rejectRequest(requests[index]["id"]);
                            },
                            username: requests[index]["name"],
                            photo: requests[index]["profilePicture"],
                            uid: requests[index]["id"],
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return verticalSpace(24);
                        },
                        itemCount: requests.length,
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
