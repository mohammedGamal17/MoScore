import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../colors/color_manager.dart';
import '../fonts/fonts_manager.dart';
import '../style/style_manager.dart';
import '../values/values_manager.dart';

ThemeData getLightModeThemeData() {
  return ThemeData(
    // color
    primaryColor: ColorManager.primary,
    primaryColorLight: ColorManager.lightPrimary,
    primaryColorDark: ColorManager.darkPrimary,
    errorColor: ColorManager.error,
    indicatorColor: ColorManager.primary,
    disabledColor: ColorManager.settingList,
    splashColor: ColorManager.darkPrimary,
    backgroundColor: ColorManager.backGround,
    // text
    textTheme: TextTheme(
      headlineLarge: getTextSemiBoldStyle(
        //league and live match score teams
        color: ColorManager.white,
        fontSize: FontsSize.s18,
      ),
      headlineMedium: getTextSemiBoldStyle(
        // selected league and selected live match
        color: ColorManager.white,
        fontSize: FontsSize.s16,
      ),
      headlineSmall: getTextSemiBoldStyle(
        // un selected league and selected live match
        color: ColorManager.listTitle,
        fontSize: FontsSize.s14,
      ),
      titleLarge: getTextRegularStyle(
        // section title
        color: ColorManager.headLine,
        fontSize: FontsSize.s18,
      ),
      titleMedium: getTextRegularStyle(
        // matches team
        color: ColorManager.black,
        fontSize: FontsSize.s14,
      ),
      titleSmall: getTextRegularStyle(
        // matches time , see all and matches details titles
        color: ColorManager.primary,
        fontSize: FontsSize.s12,
      ),
      bodyLarge: getTextRegularStyle(
        // selected league and selected live match details
        color: ColorManager.black,
        fontSize: FontsSize.s16,
      ),
      bodyMedium: getTextSemiBoldStyle(
        //  matches details titles data win and login head line
        color: ColorManager.primary,
        fontSize: FontsSize.s16,
      ),
      bodySmall: getTextRegularStyle(
        //  matches details titles data lose
        color: ColorManager.black,
        fontSize: FontsSize.s16,
      ),
      labelLarge: getTextRegularStyle(
        // selected week and home/away
        color: ColorManager.white,
        fontSize: FontsSize.s12,
      ),
      labelMedium: getTextRegularStyle(
        // selected week and home/away match details
        color: ColorManager.listTitle,
        fontSize: FontsSize.s12,
      ),
      labelSmall: getTextRegularStyle(
        color: ColorManager.listTitle,
        fontSize: FontsSize.s12,
      ),
      displayLarge: getTextRegularStyle(
        //login and register font style
        color: ColorManager.formFieldText,
        fontSize: FontsSize.s14,
      ),
      displayMedium: getTextRegularStyle(
        color: ColorManager.formFieldText,
        fontSize: FontsSize.s14,
      ),
      displaySmall: getTextRegularStyle(
        color: ColorManager.primary,
        fontSize: FontsSize.s12,
        overflow: TextOverflow.ellipsis,
      ),
    ),

    // input
    inputDecorationTheme: InputDecorationTheme(
      // content padding
      contentPadding: const EdgeInsets.all(AppPadding.p12),

      // hint style
      hintStyle: getTextRegularStyle(
        color: ColorManager.formFieldText,
        fontSize: FontsSize.s14,
      ),

      //label style
      labelStyle: getTextRegularStyle(
        color: ColorManager.formFieldText,
        fontSize: FontsSize.s14,
      ),

      //enabled
      enabledBorder: OutlineInputBorder(
        borderSide:
            BorderSide(color: ColorManager.formFieldText, width: AppSize.s1),
        borderRadius: BorderRadius.circular(AppSize.s10),
      ),

      //focus
      focusedBorder: OutlineInputBorder(
        borderSide:
            BorderSide(color: ColorManager.selectedItem, width: AppSize.s1),
        borderRadius: BorderRadius.circular(AppSize.s10),
      ),

      //error style
      errorStyle: getTextRegularStyle(
        color: ColorManager.error,
      ),
      errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: ColorManager.error, width: AppSize.s1),
          borderRadius: const BorderRadius.all(Radius.circular(AppSize.s8))),
      focusedErrorBorder: OutlineInputBorder(
          borderSide:
              BorderSide(color: ColorManager.selectedItem, width: AppSize.s1),
          borderRadius: const BorderRadius.all(Radius.circular(AppSize.s8))),
      suffixIconColor: ColorManager.content,
    ),
    // card view
    cardTheme: CardTheme(
      color: ColorManager.backGround,
      shadowColor: ColorManager.listTitle,
      elevation: AppSize.s2,
    ),

    // app bar
    appBarTheme: AppBarTheme(
      centerTitle: true,
      color: ColorManager.primary,
      shadowColor: ColorManager.lightPrimary,
      elevation: AppSize.s2,
      titleTextStyle: getTextRegularStyle(
        color: ColorManager.backGround,
        fontSize: FontsSize.s16,
      ),
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: ColorManager.primary,
      ),
    ),

    // button
    buttonTheme: ButtonThemeData(
      height: AppSize.s40,
      shape: const StadiumBorder(),
      disabledColor: ColorManager.settingList,
      buttonColor: ColorManager.primary,
      splashColor: ColorManager.darkPrimary,
      hoverColor: ColorManager.lightPrimary,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSize.s12),
        ),
        backgroundColor: ColorManager.primary,
        fixedSize: const Size(double.maxFinite, AppSize.s40),
        elevation: AppSize.s4,
        shadowColor: ColorManager.lightPrimary,
        textStyle: getTextRegularStyle(
          color: ColorManager.backGround,
          fontSize: FontsSize.s16,
        ),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: ColorManager.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSize.s12),
        ),
        elevation: AppSize.s2,
        shadowColor: ColorManager.lightPrimary,
        textStyle: getTextRegularStyle(
          color: ColorManager.backGround,
          fontSize: FontsSize.s16,
        ),
      ),
    ),

    // floating Action
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      elevation: AppSize.s2,
      focusColor: ColorManager.backGround,
      foregroundColor: ColorManager.backGround,
      backgroundColor: ColorManager.primary,
      splashColor: ColorManager.lightPrimary,
      hoverColor: ColorManager.lightPrimary,
      iconSize: AppSize.s40,
    ),

    // navigation Bar
    navigationBarTheme: NavigationBarThemeData(
      backgroundColor: ColorManager.primary,
      elevation: AppSize.s2,
    ),

    // bottom navigation bar
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      showSelectedLabels: false,
      showUnselectedLabels: false,
      elevation: AppSize.s2,
      type: BottomNavigationBarType.fixed,
      selectedIconTheme: IconThemeData(
        color: ColorManager.primary,
      ),
      unselectedIconTheme: IconThemeData(
        color: ColorManager.navigationBarItemColor,
      ),
    ),
  );
}
