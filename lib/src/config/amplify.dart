import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';

import '../../amplifyconfiguration.dart';

class AmplifyConfigures {
  static Future<void> configureAmplify() async {
    // Add Amplify plugins will be used.
    final authPlugin = AmplifyAuthCognito();

    // Can use addPlugins if you are going to be adding multiple plugins
    await Amplify.addPlugins([authPlugin]);

    // Once Plugins are added, configure Amplify
    // Note: Amplify can only be configured once.
    try {
      await Amplify.configure(amplifyconfig);
    } on AmplifyAlreadyConfiguredException {
      safePrint(
          'Tried to reconfigure Amplify; this can occur when your app restarts on Android.');
    }
  }
}
