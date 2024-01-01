import 'package:flutter/material.dart';
import 'package:soro_soke/ui/common/general_button.dart';
import 'package:stacked/stacked.dart';

import '../../../utils/app_colors.dart';
import '../../../utils/ui_helpers.dart';
import '../../../utils/validators.dart';
import '../../common/custom_text_form_field.dart';
import 'sign_up_viewmodel.dart';

class SignUpView extends StackedView<SignUpViewModel> {
  const SignUpView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    SignUpViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
        backgroundColor: AppColors.backgroundColor,
        /*appBar: AppBar(
          title: const Text(
            "Create an account",
            style:
                TextStyle(color: kcPrimaryColor, fontWeight: FontWeight.w500),
          ),
          elevation: 0,
          backgroundColor: Colors.white,
        ),*/
        body: SingleChildScrollView(
            child: Container(
                height: screenHeight(context),
                padding: const EdgeInsets.all(20.0),
                child: Form(
                    key: viewModel.formKey,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Text(
                            "Create a new account",
                            style: TextStyle(
                                fontSize: 32,
                                color: Colors.white,
                                fontWeight: FontWeight.w700),
                          ),
                          verticalSpace(8),
                          const Text(
                            "Please enter your details",
                            style: TextStyle(
                                fontSize: 14,
                                color: Colors.white,
                                fontWeight: FontWeight.w500),
                          ),
                          verticalSpace(24),
                          CustomTextFormField(
                            controller: viewModel.usernameController,
                            hintText: 'Username',
                            prefixIcon: const Icon(Icons.person),
                            validator: (value) =>
                                Validator.validateUsername(value),
                          ),
                          verticalSpace(32),
                          CustomTextFormField(
                            controller: viewModel.emailController,
                            hintText: 'Email',
                            prefixIcon: const Icon(Icons.email),
                            validator: (value) =>
                                Validator.validateEmail(value),
                            keyboardType: TextInputType.emailAddress,
                          ),
                          verticalSpace(32),
                          verticalSpaceSmall,
                          CustomTextFormField(
                            controller: viewModel.passwordController,
                            hintText: 'Password',
                            obscureText: true,
                            prefixIcon: const Icon(Icons.lock),
                            validator: (value) =>
                                Validator.validatePassword(value),
                          ),
                          verticalSpaceLarge,
                          Center(
                              child: GeneralButton(
                            onPressed: () {
                              if (viewModel.formKey.currentState!.validate()) {
                                viewModel.formKey.currentState!.save();
                                // Do something with the validated and saved values
                                viewModel.signUp();
                              }
                            },
                            buttonColor: AppColors.lightPrimaryColor,
                            buttonText: 'Create Account',
                          )),
                          verticalSpaceSmall,
                          Center(
                            child: GestureDetector(
                              onTap: () {
                                Navigator.pushReplacementNamed(
                                    context, '/login-view');
                              },
                              child: const Text(
                                "Already have an account? Sign in",
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white),
                              ),
                            ),
                          ),
                        ])))));
  }

  @override
  SignUpViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      SignUpViewModel();

  @override
  void onDispose(SignUpViewModel viewModel) {
    viewModel.passwordController.dispose();
    viewModel.emailController.dispose();
    viewModel.usernameController.dispose();
  }
}
