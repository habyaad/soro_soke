import 'package:flutter/material.dart';
import 'package:soro_soke/ui/common/app_colors.dart';
import 'package:soro_soke/ui/common/general_button.dart';
import 'package:soro_soke/ui/common/ui_helpers.dart';
import 'package:stacked/stacked.dart';

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
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text(
            "Create an account",
            style:
                TextStyle(color: kcPrimaryColor, fontWeight: FontWeight.w500),
          ),
          elevation: 0,
          backgroundColor: Colors.white,
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
                            "Username",
                            style: TextStyle(fontWeight: FontWeight.w500),
                          ),
                          verticalSpaceSmall,
                          TextFormField(
                            controller: viewModel.usernameController,
                            decoration: InputDecoration(
                              labelText: 'Username',
                              prefixIcon: const Icon(Icons.person),
                              filled: true,
                              fillColor: Colors.orange[50],
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(6.0),
                              ),
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter a username';
                              }
                              return null;
                            },
                          ),
                          verticalSpaceMedium,
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
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter an email';
                              }
                              return null;
                            },
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
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter a password';
                              }
                              return null;
                            },
                          ),
                          verticalSpaceLarge,
                          Center(child: GeneralButton(onPressed: () {  }, buttonText: 'Create Account',)),
                          verticalSpaceSmall,
                          Center(
                            child: GestureDetector(
                              onTap: (){
                                Navigator.pushNamed(context, '/login-view');
                              },
                              child: const Text(
                                "Already have an account? Sign in",
                                style: TextStyle(fontWeight: FontWeight.w500, color: kcPrimaryColorDark),
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
}
