import 'package:flutter/material.dart';
import 'package:form_validator/form_validator.dart';
import 'package:soro_soke/ui/views/profile/profile_viewmodel.dart';
import '../../../../utils/app_colors.dart';
import '../../../../utils/ui_helpers.dart';
import '../../../common/custom_text_form_field.dart';
import '../../../common/general_button.dart';

class EditProfileWidget extends StatelessWidget {
  final ProfileViewModel viewModel;

  const EditProfileWidget({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return Container(
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
            validator: ValidationBuilder(optional: true).maxLength(120).build(),
          ),
          verticalSpaceLarge,
          Center(
              child: GeneralButton(
            onPressed: () {
              if (viewModel.formKey.currentState!.validate()) {
                viewModel.formKey.currentState!.save();
                // Do something with the validated and saved values
                FocusScopeNode currentFocus = FocusScope.of(context);

                if (!currentFocus.hasPrimaryFocus) {
                  currentFocus.unfocus();
                }
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
    );
  }
}
