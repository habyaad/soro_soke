import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/ui_helpers.dart';
import '../../../utils/validators.dart';
import '../../common/custom_text_form_field.dart';
import '../../common/general_button.dart';
import 'login_viewmodel.dart';

class LoginView extends StackedView<LoginViewModel> {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    LoginViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      /*appBar: AppBar(
        title: const Text(
          "Login",
          style: TextStyle(color: kcPrimaryColor, fontWeight: FontWeight.w500),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),*/
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20.0),
          height: screenHeight(context),
          child: Form(
            key: viewModel.formKey,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Welcome back!",
                    style: TextStyle(
                        fontSize: 32,
                        color: Colors.white,
                        fontWeight: FontWeight.w700),
                  ),
                  verticalSpace(8),
                  const Text(
                    "Sign in to your account",
                    style: TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                        fontWeight: FontWeight.w500),
                  ),
                  verticalSpace(24),
                  CustomTextFormField(
                    controller: viewModel.emailController,
                    hintText: 'Email',
                    prefixIcon: const Icon(Icons.email),
                    validator: (value) => Validator.validateEmail(value),
                    keyboardType: TextInputType.emailAddress,
                  ),
                  verticalSpace(32),
                  CustomTextFormField(
                    controller: viewModel.passwordController,
                    hintText: 'Password',
                    maxLines: 1,
                    obscureText: true,
                    prefixIcon: const Icon(Icons.lock),
                    validator: (value) => Validator.validatePassword(value),
                  ),
                  verticalSpaceLarge,
                  Center(
                      child: GeneralButton(
                    onPressed: () {
                      if (viewModel.formKey.currentState!.validate()) {
                        viewModel.formKey.currentState!.save();
                        // Do something with the validated and saved values
                        viewModel.signIn();
                      }
                    },
                    buttonText: 'Login',
                    buttonColor: AppColors.lightPrimaryColor,
                  )),
                  verticalSpaceSmall,
                  Center(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pushReplacementNamed(
                            context, '/sign-up-view');
                      },
                      child: const Text(
                        "Don't have an account yet? Sign up",
                        style: TextStyle(
                            fontWeight: FontWeight.w500, color: Colors.white),
                      ),
                    ),
                  ),
                ]),
          ),
        ),
      ),
    );
  }

  @override
  LoginViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      LoginViewModel();

  @override
  void onDispose(LoginViewModel viewModel) {
    viewModel.passwordController.dispose();
    viewModel.emailController.dispose();
  }
}
