import 'package:flutter/material.dart';
import 'package:qr_app/themes/theme.dart';

class Constants {
  static String AppBarTitle = "ERDAL BAKKAL";

  static AppBar customAppBar = AppBar(
    centerTitle: true,
    title: Text(
      Constants.AppBarTitle,
      style: ThemeManager.OnlyTheme.appBarTheme.titleTextStyle,
    ),
    backgroundColor: ThemeManager.OnlyTheme.appBarTheme.backgroundColor,
  );
}
