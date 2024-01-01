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
            viewModel.navigateToOnboarding();
          } else {
            // User is authenticated, show home or authorized UI
            viewModel.navigateToHome();
          }
        }
        return Scaffold(
          backgroundColor: Colors.white,
          body: Container(
            height: screenHeight(context),
            width: screenWidth(context),
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                    height: 300,
                    child: Image.asset(
                      "assets/images/logo.jpeg",
                      fit: BoxFit.scaleDown,
                    )),
                const Text(
                  'Soro Soke',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                verticalSpace(16),
                const Text(
                  'Talk to your loved ones on what is lingering on your mind',
                  style: TextStyle(fontSize: 16, color: Colors.purpleAccent),
                  textAlign: TextAlign.center,
                ),
              ],
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
