import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/ui_helpers.dart';
import 'startup_viewmodel.dart';

class StartupView extends StackedView<StartupViewModel> {
  const StartupView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    StartupViewModel viewModel,
    Widget? child,
  ) {
    return StreamBuilder<User?>(
      stream: viewModel.authStream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          User? user = snapshot.data;
          if (user == null) {
            // User is not authenticated, show login or sign-up UI
            viewModel.navigateToLogin();
          } else {
            // User is authenticated, show home or authorized UI
            viewModel.navigateToHome();
          }
        }
        return const Scaffold(
          body: Center(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Soro Soke',
                    style: TextStyle(fontSize: 40, fontWeight: FontWeight.w900),
                  ),
                  Text(
                      'Talk to your loved ones on what is lingering on your mind',
                      style: TextStyle(fontSize: 16)),
                  verticalSpaceMedium,
                  SizedBox(
                    width: 16,
                    height: 16,
                    child: CircularProgressIndicator(
                      color: kcPrimaryColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ); // Or a loading indicator
      },
    );
  }

  @override
  StartupViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      StartupViewModel();

/* @override
  void onViewModelReady(StartupViewModel viewModel) => SchedulerBinding.instance
      .addPostFrameCallback((timeStamp) => viewModel.runStartupLogic());*/
}
