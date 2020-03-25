import 'package:flutter/material.dart';

import 'color.dart';

final darkTheme = _buildDarkTheme();
ThemeData _buildDarkTheme() {
  final ColorScheme colorScheme = const ColorScheme.dark().copyWith(
    primary: primaryColor,
    secondary: secondaryColor,
  );
  final ThemeData base = ThemeData(
    brightness: Brightness.dark,
    accentColorBrightness: Brightness.dark,
    primaryColor: primaryColor,
    cardColor: cardColor,
    primaryColorLight: secondaryColor,
    buttonColor: primaryColor,
    indicatorColor: secondaryColor,
    toggleableActiveColor: secondaryColor,
    accentColor: secondaryColor,
    dialogTheme: DialogTheme(
        backgroundColor: cardColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5))),
    popupMenuTheme: PopupMenuThemeData(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5))),
    canvasColor: canvasColor,
    scaffoldBackgroundColor: scaffoldBackgroundColor,
    backgroundColor: backgroundColor,
    errorColor: errorColor,
    buttonTheme: ButtonThemeData(
      colorScheme: colorScheme,
      textTheme: ButtonTextTheme.primary,
    ),
  );
  return base.copyWith(
    textTheme: _buildTextTheme(base.textTheme),
    primaryTextTheme: _buildTextTheme(base.primaryTextTheme),
    accentTextTheme: _buildTextTheme(base.accentTextTheme),
  );
}

TextTheme _buildTextTheme(TextTheme base) {
  return base
      .copyWith(
        headline: base.headline.copyWith(fontWeight: FontWeight.w500),
        title: base.title.copyWith(
          fontSize: 20.0,
        ),
        subtitle: base.subtitle.copyWith(
          fontSize: 18,
          fontWeight: FontWeight.w400,
        ),
        caption: base.caption.copyWith(
          fontWeight: FontWeight.w400,
          fontSize: 16.0,
        ),
        body2: base.body2.copyWith(
          fontWeight: FontWeight.bold,
          fontSize: 16.0,
        ),
        body1: base.body1.copyWith(
          fontSize: 18.0,
          wordSpacing: 2,
        ),
        button: base.button.copyWith(
          fontWeight: FontWeight.bold,
          fontSize: 16.0,
        ),
      )
      //Todo add font
      .apply(
        fontFamily: 'SourceSerifPro',
      );
}
