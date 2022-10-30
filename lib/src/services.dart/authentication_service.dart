import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';

class AuthenticationService {
  const AuthenticationService();

  Future<bool> signUp({
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      final userAttributes = <CognitoUserAttributeKey, String>{
        CognitoUserAttributeKey.name: name,
      };
      await Amplify.Auth.signUp(
        username: email,
        password: password,
        options: CognitoSignUpOptions(userAttributes: userAttributes),
      );

      return true;
    } on AuthException catch (e) {
      safePrint(e.message);
      return false;
    }
  }

  Future<bool> signIn({required String email, required String password}) async {
    try {
      await Amplify.Auth.signOut();
      await Amplify.Auth.signIn(username: email, password: password);
      return true;
    } on AuthException catch (e) {
      safePrint(e.message);
      return false;
    }
  }

  Future<bool> signUpConfirm(
      {required String email, required String confirmCode}) async {
    try {
      await Amplify.Auth.confirmSignUp(
          username: email, confirmationCode: confirmCode);
      return true;
    } on AuthException catch (e) {
      safePrint(e.message);
      return false;
    }
  }

  Future<bool> signOut() async {
    try {
      await Amplify.Auth.signOut();
      return true;
    } catch (e) {
      return false;
    }
  }
}
