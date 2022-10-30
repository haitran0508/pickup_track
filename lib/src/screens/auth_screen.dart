import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pickup_track/src/widgets/hyper_link.dart';

import '../config/routes.dart';
import '../constants/string_constants.dart';
import '../controller/authentication_controller.dart';
import '../widgets/rounded_button.dart';
import '../widgets/text_field.dart';

class AuthenticationScreen extends StatelessWidget {
  const AuthenticationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final controller = Get.find<AuthenticationController>();

    return Scaffold(
      appBar: AppBar(title: Text(StringConstants.appName)),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50),
            child: Form(
              key: formKey,
              child: Obx(() {
                final process = controller.process;

                switch (process.value) {
                  case AuthProcess.signUp:
                    return _buildSignUpSection(context, formKey);

                  case AuthProcess.signUpConfirm:
                    return _buildSignUpConfirmSection(context, formKey);

                  default:
                    return _buildSignInSection(context, formKey);
                }
              }),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSignInSection(
      BuildContext context, GlobalKey<FormState> formKey) {
    final controller = Get.find<AuthenticationController>();
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        BorderedTextField.email(
          key: const ValueKey('email-signin'),
          onChanged: (value) {
            controller.email = value!;
          },
        ),
        const SizedBox(height: 20),
        BorderedTextField.password(
          key: const ValueKey('password-signin'),
          onChanged: (value) {
            controller.password = value!;
          },
        ),
        const SizedBox(height: 30),
        Obx(
          () {
            final authState = controller.state;
            if (authState.value == AuthState.processing) {
              return const CircularProgressIndicator();
            } else {
              return RoundedButton(
                label: StringConstants.signIn,
                onPressed: () async {
                  if (formKey.currentState!.validate()) {
                    await controller.signIn();

                    if (authState.value == AuthState.succeed) {
                      Get.toNamed(Routes.tracking);
                    } else {
                      Get.snackbar(
                        StringConstants.alert,
                        StringConstants.failMessage,
                        backgroundColor: Colors.white,
                        colorText: Colors.blue,
                      );
                    }
                  }
                },
              );
            }
          },
        ),
        const SizedBox(height: 30),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(StringConstants.signUpSuggest),
            const SizedBox(width: 5),
            GestureDetector(
              onTap: () {
                controller.requestProcess(AuthProcess.signUp);
              },
              child: HyperLink(StringConstants.signUp),
            )
          ],
        )
      ],
    );
  }

  Widget _buildSignUpSection(
      BuildContext context, GlobalKey<FormState> formKey) {
    final controller = Get.find<AuthenticationController>();
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        BorderedTextField(
          key: const ValueKey('name-singup'),
          label: StringConstants.name,
          onChanged: (value) {
            controller.name = value!;
          },
        ),
        const SizedBox(height: 20),
        BorderedTextField.email(
          key: const ValueKey('email-singup'),
          onChanged: (value) {
            controller.email = value!;
          },
        ),
        const SizedBox(height: 20),
        BorderedTextField.password(
          key: const ValueKey('password-singup'),
          onChanged: (value) {
            controller.password = value!;
          },
        ),
        const SizedBox(height: 30),
        Obx(
          () {
            final authState = controller.state;
            if (authState.value == AuthState.processing) {
              return const CircularProgressIndicator();
            } else {
              return RoundedButton(
                label: StringConstants.signUp,
                onPressed: () async {
                  if (formKey.currentState!.validate()) {
                    await controller.signUp();

                    if (authState.value == AuthState.succeed) {
                      controller.requestProcess(AuthProcess.signUpConfirm);
                    } else {
                      Get.snackbar(
                        StringConstants.alert,
                        StringConstants.failMessage,
                        backgroundColor: Colors.white,
                        colorText: Colors.blue,
                      );
                    }
                  }
                },
              );
            }
          },
        ),
        const SizedBox(height: 30),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(StringConstants.signInSuggest),
            const SizedBox(width: 5),
            GestureDetector(
              onTap: () {
                controller.requestProcess(AuthProcess.signIn);
              },
              child: HyperLink(StringConstants.signIn),
            )
          ],
        )
      ],
    );
  }

  Widget _buildSignUpConfirmSection(
      BuildContext context, GlobalKey<FormState> formKey) {
    final controller = Get.find<AuthenticationController>();
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        BorderedTextField(
          key: const ValueKey('code-singup'),
          label: StringConstants.code,
          onChanged: (value) {
            controller.confirmCode = value!;
          },
        ),
        Obx(
          () {
            final authState = controller.state;
            if (authState.value == AuthState.processing) {
              return const CircularProgressIndicator();
            } else {
              return RoundedButton(
                label: StringConstants.code,
                onPressed: () async {
                  final authState = controller.state;

                  await controller.confirmSignUp();

                  if (authState.value == AuthState.succeed) {
                    controller.requestProcess(AuthProcess.signIn);
                  } else {
                    Get.snackbar(
                      StringConstants.alert,
                      StringConstants.failMessage,
                      backgroundColor: Colors.white,
                      colorText: Colors.blue,
                    );
                  }
                },
              );
            }
          },
        ),
        const SizedBox(height: 30),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(StringConstants.signInSuggest),
            const SizedBox(width: 5),
            GestureDetector(
              onTap: () {
                controller.requestProcess(AuthProcess.signIn);
              },
              child: HyperLink(StringConstants.signIn),
            )
          ],
        )
      ],
    );
  }
}
