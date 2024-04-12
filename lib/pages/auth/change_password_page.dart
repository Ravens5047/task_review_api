import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:task_api_review/components/button/td_elevated_button.dart';
import 'package:task_api_review/components/snack_bar/td_snack_bar.dart';
import 'package:task_api_review/components/snack_bar/top_snack_bar.dart';
import 'package:task_api_review/components/text_field/td_text_field_password.dart';
import 'package:task_api_review/gen/assets.gen.dart';
import 'package:task_api_review/pages/auth/login_page.dart';
import 'package:task_api_review/resources/app_color.dart';
import 'package:task_api_review/services/local/shared_prefs.dart';
import 'package:task_api_review/services/remote/auth_services.dart';
import 'package:task_api_review/services/remote/body/change_password_body.dart';
import 'package:task_api_review/services/remote/code_error.dart';
import 'package:task_api_review/utils/validator.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({super.key, required this.email});

  final String email;

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  final currentPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final authServices = AuthServices();
  final formKey = GlobalKey<FormState>();
  bool isLoading = false;

  Future<void> _changePassword() async {
    if (formKey.currentState!.validate() == false) {
      return;
    }

    setState(() => isLoading = true);
    await Future.delayed(const Duration(milliseconds: 1200));

    final body = ChangePasswordBody()
      ..password = newPasswordController.text
      ..oldPassword = currentPasswordController.text;

    authServices.changePassword(body).then((response) {
      final data = jsonDecode(response.body);
      if (data['status_code'] == 200) {
        showTopSnackBar(
          context,
          const TDSnackBar.success(
              message: 'Password has been changed, please login 😍'),
        );
        // setState(() => isLoading = false);
        SharedPrefs.removeSeason();
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
              builder: (context) => LoginPage(email: widget.email)),
          (Route<dynamic> route) => false,
        );
      } else {
        print('object message ${data['message']}');
        showTopSnackBar(
          context,
          TDSnackBar.error(
              message: (data['message'] as String?)?.toLang ?? '😐'),
        );
        setState(() => isLoading = false);
      }
    }).catchError((onError) {
      print('object $onError');
      showTopSnackBar(
        context,
        const TDSnackBar.error(message: "Server error 😐"),
      );
      setState(() => isLoading = false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: Form(
          key: formKey,
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 20.0).copyWith(
                top: MediaQuery.of(context).padding.top + 38.0, bottom: 16.0),
            children: [
              const Center(
                child: Text('Change Password',
                    style: TextStyle(color: AppColor.red, fontSize: 24.0)),
              ),
              const SizedBox(height: 38.0),
              Center(
                child: Image.asset(Assets.images.todoIcon.path,
                    width: 90.0, fit: BoxFit.cover),
              ),
              const SizedBox(height: 46.0),
              TdTextFieldPassword(
                controller: currentPasswordController,
                hintText: 'Current Password',
                validator: Validator.requiredValidator,
                textInputAction: TextInputAction.next,
              ),
              const SizedBox(height: 18.0),
              TdTextFieldPassword(
                controller: newPasswordController,
                hintText: 'New Password',
                validator: Validator.passwordValidator,
                textInputAction: TextInputAction.next,
              ),
              const SizedBox(height: 18.0),
              TdTextFieldPassword(
                controller: confirmPasswordController,
                onChanged: (_) => setState(() {}),
                hintText: 'Confirm Password',
                validator: Validator.confirmPasswordValidator(
                    newPasswordController.text),
                onFieldSubmitted: (_) => _changePassword(),
                textInputAction: TextInputAction.done,
              ),
              const SizedBox(height: 92.0),
              TdElevatedButton.outline(
                onPressed: _changePassword,
                text: 'Done',
                isDisable: isLoading,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
