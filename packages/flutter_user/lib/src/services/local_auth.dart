import "package:flutter/services.dart";
import "package:flutter_user/flutter_user.dart";
import "package:local_auth/local_auth.dart";

/// A service that handles local authentication using the local_auth package.
class LocalAuthService {
  final LocalAuthentication _localAuth = LocalAuthentication();

  /// Try to open the authentication dialog for the user. If the device does
  /// not support local authentication, the [onBiometricsError] callback is
  /// called. If the user cancels the authentication, the [onBiometricsFail]
  /// callback is called. If the authentication is successful, the
  /// [onBiometricsSuccess] callback is called.
  Future<void> authenticate(LoginOptions loginOptions) async {
    var biometricsOptions = loginOptions.biometricsOptions;

    try {
      if (!await _localAuth.isDeviceSupported()) {
        biometricsOptions.onBiometricsError?.call();
        return;
      }
      var didAuthenticate = await _localAuth.authenticate(
        localizedReason: loginOptions.translations.biometricsLoginMessage,
        options: AuthenticationOptions(
          biometricOnly: !biometricsOptions.allowBiometricsAlternative,
          stickyAuth: true,
          sensitiveTransaction: false,
        ),
      );
      if (didAuthenticate) {
        biometricsOptions.onBiometricsSuccess?.call();
      }

      if (!didAuthenticate) {
        biometricsOptions.onBiometricsFail?.call();
      }
    } on PlatformException catch (_) {
      biometricsOptions.onBiometricsError?.call();
    }
  }
}
