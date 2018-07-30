import 'package:flutter/material.dart';

class AppOptions {
  final AppTheme appTheme;

  const AppOptions({this.appTheme});

  AppOptions copyWith({AppTheme appTheme}) {
    return AppOptions(appTheme: appTheme);
  }
}

class AppTheme {
  final ThemeData themeData;

  const AppTheme(this.themeData);

  AppTheme changePrimaryColor(Color color) {
    return AppTheme(themeData.copyWith(primaryColor: color));
  }
}

final AppTheme defTheme =
    AppTheme(ThemeData().copyWith(primaryColor: Colors.blue));
