import 'package:flutter/material.dart';
import 'package:form_validator/form_validator.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/ui_helpers.dart';
import '../../common/custom_text_form_field.dart';
import '../../common/general_button.dart';
import 'edit_profile_viewmodel.dart';

class EditProfileView extends StackedView<EditProfileViewModel> {
  const EditProfileView({super.key});

  @override
  Widget builder(
    BuildContext context,
    EditProfileViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
        foregroundColor: Colors.white,
        title: const Text(
          "Edit Profile",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20.0),
          height: screenHeight(context),
          child: Form(
            key: viewModel.formKey,
            child: Column(children: [
              // const Text(
              //   "Welcome back!",
              //   style: TextStyle(
              //       fontSize: 32,
              //       color: Colors.white,
              //       fontWeight: FontWeight.w700),
              // ),
              // verticalSpace(8),
              // const Text(
              //   "Sign in to your account",
              //   style: TextStyle(
              //       fontSize: 14,
              //       color: Colors.white,
              //       fontWeight: FontWeight.w500),
              // ),
              verticalSpace(16),
              CustomTextFormField(
                controller: viewModel.phoneController,
                hintText: 'Phone number',
                prefixIcon: const Icon(Icons.call),
                validator: ValidationBuilder().phone().build(),
                keyboardType: const TextInputType.numberWithOptions(),
              ),
              verticalSpace(32),
              CustomTextFormField(
                controller: viewModel.aboutController,
                hintText: 'About',
                minLines: 3,
                maxLines: 5,
                maxLength: 120,
                prefixIcon: const Icon(Icons.person),
                validator:
                    ValidationBuilder(optional: true).maxLength(120).build(),
              ),
              verticalSpaceLarge,
              Center(
                  child: GeneralButton(
                onPressed: () {
                  if (viewModel.formKey.currentState!.validate()) {
                    viewModel.formKey.currentState!.save();
                    // Do something with the validated and saved values
                    viewModel.saveProfile();
                  }
                },
                buttonText: 'Save changes',
                buttonColor: AppColors.lightPrimaryColor,
              )),
              verticalSpaceMedium,
              Center(
                child: GestureDetector(
                  onTap: () {
                    // Navigator.pushReplacementNamed(
                    //     context, '/sign-up-view');
                  },
                  child: const Text(
                    "Change password?",
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                        decoration: TextDecoration.underline,
                        decorationColor: Colors.white),
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
  void onViewModelReady(EditProfileViewModel viewModel) {
    viewModel.initializeUser();
  }

  @override
  EditProfileViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      EditProfileViewModel();
}
