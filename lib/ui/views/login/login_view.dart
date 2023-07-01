import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/ui_helpers.dart';
import '../../../utils/validators.dart';
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
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          "Login",
          style: TextStyle(color: kcPrimaryColor, fontWeight: FontWeight.w500),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
          child: Container(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                  key: viewModel.formKey,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const Text(
                          "Email",
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                        verticalSpaceSmall,
                        TextFormField(
                          controller: viewModel.emailController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            focusColor: Colors.white,
                            labelText: 'Email',
                            prefixIcon: const Icon(Icons.email),
                            filled: true,
                            fillColor: Colors.orange[50],
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(6.0),
                            ),
                          ),
                          validator: (value) => Validator.validateEmail(value),
                        ),
                        verticalSpaceMedium,
                        const Text(
                          "Password",
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                        verticalSpaceSmall,
                        TextFormField(
                          controller: viewModel.passwordController,
                          obscureText: true,
                          decoration: InputDecoration(
                            focusColor: Colors.white,
                            labelText: 'Password',
                            prefixIcon: const Icon(Icons.lock),
                            filled: true,
                            fillColor: Colors.orange[50],
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(6.0),
                            ),
                          ),
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
                              viewModel.signIn();
                            }
                          },
                          buttonText: 'Login',
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
                                  fontWeight: FontWeight.w500,
                                  color: kcPrimaryColorDark),
                            ),
                          ),
                        ),
                      ])))),
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
