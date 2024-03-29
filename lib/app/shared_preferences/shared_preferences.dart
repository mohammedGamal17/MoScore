import 'package:shared_preferences/shared_preferences.dart';

const String isOnBoardingShow = 'isOnBoardingShow';
const String isSignIn = 'isLoggedIn';
const String uId = 'uId';
const String isAnonymously = 'isAnonymously';

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
  Future<void> setIsSignIn({required bool isSign}) async {
    await _sharedPreferences.setBool(isSignIn, isSign);
  }

  /// Get Value of isSignIn
  Future<bool> getIsSignIn() async {
    return _sharedPreferences.getBool(isSignIn) ?? false;
  }

  /// Set Value Of UID
  setUId({
    required String uID,
  }) async {
    await _sharedPreferences.setString(uId, uID);
  }

  /// Get Value Of UID
  String? getUId() {
    return _sharedPreferences.getString(uId);
  }

  /// Set if SignIn or Anonymously
  setIsAnonymously({
    required bool isAnonymous,
  }) {
    _sharedPreferences.setBool(isAnonymously, isAnonymous);
  }

  /// Get if SignIn or Anonymously
  bool getIsAnonymously() {
    return _sharedPreferences.getBool(isAnonymously) ?? false;
  }

  /// Clear All Cache
  clearAllCache() async {
   await _sharedPreferences.remove(isSignIn);
   await _sharedPreferences.remove(uId);
   await _sharedPreferences.remove(isAnonymously);
  }
}
