import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import '../../../utils/ui_helpers.dart';
import 'startup_viewmodel.dart';

class StartupView extends StackedView<StartupViewModel> {
  const StartupView({super.key});

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
          backgroundColor: const Color(0xFF181827),
          body: Container(
            // decoration: const BoxDecoration(
            //     gradient: LinearGradient(colors: [
            //   Color(0xFF181827),
            //   Color(0xFF49243E),
            // ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
            height: screenHeight(context),
            width: screenWidth(context),
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // SizedBox(
                //     height: 300,
                //     child: Image.asset(
                //       "assets/images/logo.jpeg",
                //       fit: BoxFit.scaleDown,
                //     )),
                Container(
                  width: 250,
                  height: 250,
                  decoration: const BoxDecoration(
                      color: Color(0xFF1E1E2C), shape: BoxShape.circle),
                  child: Align(
                    alignment: Alignment.center,
                    child: Container(
                      width: 225,
                      height: 225,
                      decoration: const BoxDecoration(
                          color: Color(0xFF2B2B3A), shape: BoxShape.circle),
                      child: Align(
                        alignment: Alignment.center,
                        child: Container(
                          width: 200,
                          height: 200,
                          decoration: const BoxDecoration(
                              color: Color(0xFF3B3B4B),
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  image: AssetImage(
                                    "assets/images/fabio-lucas-aTpGSPfalzY-unsplash.jpeg",
                                  ),
                                  fit: BoxFit.cover)),

                          //child: ,
                        ),
                      ),
                    ),
                  ),
                ),
                verticalSpace(16),
                const Text(
                  'Soro Soke',
                  style: TextStyle(
                    fontSize: 32,
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                verticalSpace(8),
                const Text(
                  'Talk to your loved ones on what is lingering on your mind',
                  style: TextStyle(fontSize: 16, color: Colors.white),
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
