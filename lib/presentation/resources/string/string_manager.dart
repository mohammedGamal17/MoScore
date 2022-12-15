class StringManager {
  static const String noRouteFined = "No Route Fined";

  static const String onBoardModelTitle1 = "SEE THE BEST FOOTBALL APP #1";
  static const String onBoardModelTitle2 = "SEE THE BEST FOOTBALL APP #2";
  static const String onBoardModelTitle3 = "SEE THE BEST FOOTBALL APP #3";
  static const String onBoardModelTitle4 = "SEE THE BEST FOOTBALL APP #4";

  static const String onBoardModelSubTitle1 =
      "MoScore app is an awesome football application #1";
  static const String onBoardModelSubTitle2 =
      "MoScore app is an awesome football application #2";
  static const String onBoardModelSubTitle3 =
      "MoScore app is an awesome football application #3";
  static const String onBoardModelSubTitle4 =
      "MoScore app is an awesome football application #4";

  static const String skip = "Skip";
  static const String done = "Done";

  static const String email = "Email";
  static const String name = "Name";
  static const String password = "Password";
  static const String errorEmail = "Please Write Your Email";
  static const String errorPassword = "Please Write Your Password";
  static const String login = "Log In";
  static const String forgetPassword = "Forget Password";
  static const String register = "Sign Up";
  static const String notMember = "Not a member ?";
  static const String orLoginWith = "Or Log In With";
  static const String orRegisterWith = "Or Sign Up with";

  // error handler
  static const String success = "success";
  static const String badRequestError = "bad_request_error";
  static const String noContent = "no_content";
  static const String forbiddenError = "forbidden_error";
  static const String unauthorizedError = "unauthorized_error";
  static const String notFoundError = "not_found_error";
  static const String conflictError = "conflict_error";
  static const String internalServerError = "internal_server_error";
  static const String unknownError = "unknown_error";
  static const String timeoutError = "timeout_error";
  static const String defaultError = "default_error";
  static const String cacheError = "cache_error";
  static const String noInternetError = "No Internet... Check Your Connection";

  // Render State
  static const String retry = "Retry Again";
  static const String loading = "Loading...";
  static const String ok = "OK";
  static const String error = "Error";
  static const String empty = "No data founded";

  // Authentication screens
  static const String pleaseEnterYourFullName = 'Please Enter Your Full Name';
  static const String pleaseWriteValidName = 'Please Write Valid Name';
  static const String pleaseEnterYourEmail = 'Please Enter Your Email';
  static const String pleaseWriteValidEmail = 'Please Write Valid Email';
  static const String pleaseEnterYourPassword = 'Please Enter Your Password';
  static const String passwordValidate =
      'Password should contain:\nCapital, small letter\nNumber & Special Character.';
  static const String registerSuccess = 'Register Success';
  static const String loginSuccess = 'Login Success';
  static const String loginLater = 'Login Later';

  static const String logOut = 'Log Out';

  // Home Screen
  static const String profile = 'Profile';
  static const String search = 'Search';
  static const String live = 'Live';
  static const String settings = 'Settings';
  static const String rateUs = 'Rate us';
  static const String shareMoScore = 'Share MoScore';

  // Profile Screen
  static const String updated = 'Updated';
  static const String favourites = 'Favourites';
  static const String player = 'Player';
  static const String team = 'Team';
  static const String league = 'League';
  static const String updateImage = 'Update Image';


  static String anonymouslyUser({required String firstThreeIndex}) =>
      'User $firstThreeIndex';

  static String anonymouslyMail({required String firstThreeIndex}) =>
      '$firstThreeIndex@mail.com';
}
