import 'package:shared_preferences/shared_preferences.dart';

const String isOnBoardingShow = 'isOnBoardingShow';
const String isSignIn = 'isLoggedIn';

class AppPreferences {
  final SharedPreferences _sharedPreferences;

  AppPreferences(this._sharedPreferences);

  //OnBoarding
  /// Set Value in On Boarding to be TRUE in shared pref
  Future<void> setIsOnBoarding() async {
    await _sharedPreferences.setBool(isOnBoardingShow, true);
  }

  /// Get Value of On Boarding
  Future<bool> getIsOnBoarding() async {
    return _sharedPreferences.getBool(isOnBoardingShow) ?? false;
  }

  //login
  /// Set Value in Is SignIn to be TRUE in shared pref
  Future<void> setIsSignIn() async {
    await _sharedPreferences.setBool(isSignIn, true);
  }

  /// Get Value of isSignIn
  Future<bool> getIsSignIn() async {
    return _sharedPreferences.getBool(isSignIn) ?? false;
  }
}
