import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quickalert/quickalert.dart';

import '../../../app/constants/constants.dart';
import '../colors/color_manager.dart';
import '../constants/constants.dart';
import '../string/string_manager.dart';
import '../values/values_manager.dart';

void navigateTo(context, widget) => Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return widget;
        },
      ),
    );

void navigateToAndReplace(context, widget) => Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) {
          return widget;
        },
      ),
      (route) => false,
    );

Widget textFormField({
  required TextEditingController controller,
  required String labelText,
  required IconData prefix,
  required TextInputType textInputType,
  required Function validate,
  double borderRadius = 10.0,
  bool autoFocus = false,
  bool isPassword = false,
  IconData? suffix,
  Function? suffixOnTap,
  Function? onTap,
  Function? onChange,
  Function? onSubmit,
  TextDirection? textDirection,
  Color? fillColor,
  int maxLen = 75,
}) {
  return TextFormField(
    keyboardType: textInputType,
    style: TextStyle(color: ColorManager.white),
    controller: controller,
    autofocus: autoFocus,
    obscureText: isPassword,
    decoration: InputDecoration(
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: ColorManager.white, width: 3.0),
      ),
      enabledBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: Colors.grey, width: 1.0),
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      labelText: labelText,
      filled: true,
      fillColor: fillColor,
      labelStyle: TextStyle(color: ColorManager.white),
      prefixIcon: Icon(prefix, color: ColorManager.white),
      suffixIcon: suffix != null
          ? IconButton(
              onPressed: () {
                suffixOnTap!();
              },
              icon: Icon(suffix),
            )
          : null,
      suffixIconColor: ColorManager.white,
    ),
    textDirection: textDirection,
    validator: (value) {
      return validate(value);
    },
    onTap: () {
      // ignore: void_checks
      onTap!();
    },
    onChanged: (String value) {
      onChange!(value);
    },
    onFieldSubmitted: (value) {
      onSubmit!(value);
    },
  );
}

Widget separator({
  double verticalPadding = AppPadding.p20,
  double horizontalPadding = AppPadding.p20,
}) {
  return Padding(
    padding: EdgeInsets.symmetric(
      vertical: verticalPadding,
      horizontal: horizontalPadding,
    ),
    child: Container(
      height: 2.0,
      decoration: BoxDecoration(
        color: ColorManager.backGround,
        gradient: LinearGradient(
          begin: AlignmentDirectional.topStart,
          end: AlignmentDirectional.bottomEnd,
          colors: [
            ColorManager.primary,
            ColorManager.selectedItem,
          ],
        ),
      ),
    ),
  );
}

Widget separatorHorizontal({
  double width = AppSize.s4,
  double height = AppSize.s20,
}) {
  return Container(
    width: width,
    height: height,
    decoration: BoxDecoration(
      color: ColorManager.primary,
      gradient: LinearGradient(
        begin: AlignmentDirectional.topStart,
        end: AlignmentDirectional.bottomEnd,
        colors: [
          ColorManager.primary,
          ColorManager.selectedItem,
        ],
      ),
    ),
  );
}

Widget decorationButton(
  context, {
  required Widget widget,
  required Function function,
  double? height = AppSize.s40,
  double? width = double.infinity,
  double? radius = AppSize.s10,
}) {
  return InkWell(
    onTap: () {
      function();
    },
    child: Center(
      child: Container(
        height: height,
        width: width,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius!),
          color: ColorManager.backGround,
          gradient: LinearGradient(
            begin: AlignmentDirectional.topStart,
            end: AlignmentDirectional.bottomEnd,
            colors: [
              ColorManager.primary,
              ColorManager.selectedItem,
            ],
          ),
        ),
        child: widget,
      ),
    ),
  );
}

ScaffoldFeatureController<SnackBar, SnackBarClosedReason> snack(
  context, {
  required String content,
  Color? bgColor = Colors.green,
}) {
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        content,
        style: Theme.of(context).textTheme.labelLarge,
        textAlign: TextAlign.center,
        maxLines: 2,
      ),
      duration: const Duration(milliseconds: AppConst.snakeTimer),
      padding: const EdgeInsets.symmetric(
        vertical: AppPadding.p10,
        horizontal: AppPadding.p20,
      ),
      backgroundColor: bgColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSize.s40),
      ),
      behavior: SnackBarBehavior.fixed,
    ),
  );
}

class AdaptiveCircleIndicator extends StatelessWidget {
  AdaptiveCircleIndicator({
    Key? key,
  }) : super(key: key);
  final String os = AppConstants.os;

  @override
  Widget build(BuildContext context) {
    if (os == 'IOS' || os == 'MacOS' || os == 'ios') {
      return Center(
        child: CupertinoActivityIndicator(
          color: Theme.of(context).primaryColor,
        ),
      );
    }
    return Center(
      child: CircularProgressIndicator(
        backgroundColor: Theme.of(context).backgroundColor,
        color: Theme.of(context).primaryColor,
      ),
    );
  }
}

Future alert(
  context, {
  required QuickAlertType quickAlertType,
  required String text,
  required Color textColor,
  double borderRadius = AppSize.s20,
  Widget? widget,
}) {
  return QuickAlert.show(
      context: context,
      type: quickAlertType,
      textColor: textColor,
      text: text,
      borderRadius: borderRadius,
      confirmBtnColor: ColorManager.primary,
      widget: widget,
      animType: QuickAlertAnimType.slideInUp);
}

Future noInternet(context) {
  return alert(
    context,
    quickAlertType: QuickAlertType.error,
    text: StringManager.noInternetError,
    textColor: ColorManager.error,
  );
}
