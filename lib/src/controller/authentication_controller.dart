import 'package:get/get.dart';

import '../services.dart/authentication_service.dart';

enum AuthProcess { signIn, signUp, signUpConfirm }

enum AuthState { awaiting, processing, succeed, failed }

class AuthenticationController extends GetxController {
  final AuthenticationService service;

  AuthenticationController({required this.service});

  String email = '';
  String password = '';
  String name = '';
  String confirmCode = '';

  Rx<AuthProcess> process = AuthProcess.signIn.obs;

  Rx<AuthState> state = AuthState.awaiting.obs;

  void requestProcess(AuthProcess newProcess) {
    process.value = newProcess;
  }

  Future<void> signIn() async {
    _switchToState(AuthState.processing);

    final result = await service.signIn(
      email: email,
      password: password,
    );

    if (result) {
      _switchToState(AuthState.succeed);
      return;
    }
    _switchToState(AuthState.failed);
  }

  Future<void> signUp() async {
    _switchToState(AuthState.processing);

    final result = await service.signUp(
      email: email,
      password: password,
      name: name,
    );

    if (result) {
      _switchToState(AuthState.succeed);
      return;
    }

    _switchToState(AuthState.failed);
  }

  Future<void> confirmSignUp() async {
    _switchToState(AuthState.processing);

    final result = await service.signUpConfirm(
      email: email,
      confirmCode: confirmCode,
    );

    if (result) {
      _switchToState(AuthState.succeed);
      return;
    }
    _switchToState(AuthState.failed);
  }

  Future<void> signOut() async {
    _switchToState(AuthState.processing);

    final result = await service.signOut();

    if (result) {
      _switchToState(AuthState.succeed);
      process.value = AuthProcess.signIn;
      Get.back();
      return;
    }
    _switchToState(AuthState.failed);
  }

  void _switchToState(AuthState newState) {
    state.value = newState;
  }
}
