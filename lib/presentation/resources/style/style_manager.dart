import 'package:flutter/material.dart';

import '../fonts/fonts_manager.dart';

TextStyle _textStyle(
  TextOverflow textOverflow,
  double fontSize,
  Color color,
  FontWeight fontWeight,
) {
  return TextStyle(
    color: color,
    fontSize: fontSize,
    fontFamily: FontsConstants.fontFamily,
    fontWeight: fontWeight,
    overflow: textOverflow,
  );
}

//ExtraLight
TextStyle getTextExtraLightStyle({
  TextOverflow overflow = TextOverflow.ellipsis,
  double fontSize = FontsSize.s12,
  required Color color,
}) {
  return _textStyle(
    overflow,
    fontSize,
    color,
    FontsWight.extraLight,
  );
}

//Light
TextStyle getTextLightStyle({
  TextOverflow overflow = TextOverflow.ellipsis,
  double fontSize = FontsSize.s12,
  required Color color,
}) {
  return _textStyle(
    overflow,
    fontSize,
    color,
    FontsWight.light,
  );
}

//Regular
TextStyle getTextRegularStyle({
  TextOverflow overflow = TextOverflow.visible,
  double fontSize = FontsSize.s12,
  required Color color,
}) {
  return _textStyle(
    overflow,
    fontSize,
    color,
    FontsWight.regular,
  );
}

//SemiBold
TextStyle getTextSemiBoldStyle({
  TextOverflow overflow = TextOverflow.ellipsis,
  double fontSize = FontsSize.s12,
  required Color color,
}) {
  return _textStyle(
    overflow,
    fontSize,
    color,
    FontsWight.semiBold,
  );
}

//Bold
TextStyle getTextBoldStyle({
  TextOverflow overflow = TextOverflow.ellipsis,
  double fontSize = FontsSize.s12,
  required Color color,
}) {
  return _textStyle(
    overflow,
    fontSize,
    color,
    FontsWight.bold,
  );
}

//Black
TextStyle getTextBlackStyle({
  TextOverflow overflow = TextOverflow.ellipsis,
  double fontSize = FontsSize.s12,
  required Color color,
}) {
  return _textStyle(
    overflow,
    fontSize,
    color,
    FontsWight.black,
  );
}
