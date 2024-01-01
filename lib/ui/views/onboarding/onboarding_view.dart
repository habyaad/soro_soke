import 'package:flutter/material.dart';
import 'package:soro_soke/utils/app_colors.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter_onboarding_slider/flutter_onboarding_slider.dart';
import 'onboarding_viewmodel.dart';

class OnboardingView extends StackedView<OnboardingViewModel> {
  const OnboardingView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    OnboardingViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        padding: const EdgeInsets.only(left: 25.0, right: 25.0),
        child: OnBoardingSlider(
          headerBackgroundColor: Colors.white,
          finishButtonText: 'Register',
          pageBackgroundColor: Colors.white,
          finishButtonStyle: const FinishButtonStyle(
            backgroundColor: AppColors.primaryColor,
          ),
          trailingFunction: () {
            viewModel.navigateToLogin();
          },
          onFinish: () {
            viewModel.navigateToRegister();
          },
          skipTextButton: const Text('Skip',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
          trailing: const Text('Login',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
          background: const [
            SizedBox(),
            SizedBox(),

            /*Image.asset('assets/slide_1.png'),
            Image.asset('assets/slide_2.png'),*/
          ],
          totalPage: 2,
          speed: 1.8,
          pageBodies: [
            Column(
              children: <Widget>[
                SizedBox(
                  height: 480,
                  child: Image.asset(
                    'assets/images/onboarding-1.jpeg',
                    fit: BoxFit.scaleDown,
                  ),
                ),
                const Text(
                  'One Platform \nMultiple Connections',
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.w700),
                ),
              ],
            ),
            Column(
              children: <Widget>[
                SizedBox(
                  height: 480,
                  child: Image.asset(
                    'assets/images/onboarding-2.jpeg',
                    fit: BoxFit.scaleDown,
                  ),
                ),
                const Text(
                  'Seamless Communication with Friends',
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.w700),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  OnboardingViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      OnboardingViewModel();
}
