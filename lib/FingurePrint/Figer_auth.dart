import 'package:local_auth/local_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FingerprintAuthService {
  final LocalAuthentication _auth = LocalAuthentication();

  Future<bool> isFingerprintAvailable() async {
    return await _auth.canCheckBiometrics;
  }

  Future<bool> authenticate() async {
    try {
      return await _auth.authenticate(
        localizedReason: 'Please authenticate to access the app',
        options: const AuthenticationOptions(
          stickyAuth: true,
          biometricOnly: true,
        ),
      );
    } catch (e) {
      return false;
    }
  }

  Future<void> setFingerprintLock(bool enabled) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('fingerprint_lock', enabled);
  }

  Future<bool> isFingerprintLockEnabled() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool('fingerprint_lock') ?? false;
  }
}
