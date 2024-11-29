import 'package:flutter/material.dart';
import 'package:task_management/core/constants/color_constants.dart';
import 'package:task_management/core/constants/text_style_constant.dart';

ThemeData themeData =ThemeData(
  primaryColor: kBlackColor,
  scaffoldBackgroundColor: Colors.white,

  appBarTheme: AppBarTheme(
    backgroundColor: Colors.white,surfaceTintColor: Colors.transparent,
    foregroundColor: kBlackColor,
    titleTextStyle: textStyle16MediumBlack,

  ),
  dialogTheme: const DialogTheme(backgroundColor: Colors.white,
    surfaceTintColor: Colors.white,
  ),
  cardTheme: const CardTheme(
      surfaceTintColor: Colors.white,
      color: Colors.white
  ),
  listTileTheme: ListTileThemeData(
      titleTextStyle: textStyle16SemiBoldBlack,
      subtitleTextStyle: textStyle12NormalBlack
  ),
  drawerTheme: const DrawerThemeData(backgroundColor: Colors.white,surfaceTintColor: Colors.white,
    /*  width: MediaQuery.sizeOf(context).width/1.5*/),
  floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: Colors.grey.shade100,
      foregroundColor: kBlackColor
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all(kBlackColor), // Button background color
        foregroundColor: WidgetStateProperty.all(kWhiteColor), // Text color

        overlayColor: WidgetStateProperty.resolveWith<Color?>(
              (Set<WidgetState> states) {
            if (states.contains(WidgetState.pressed)) return Colors.grey[400]; // Ripple effect
            return null;
          },
        ),

        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0), // Rounded corners
          ),),
        padding: WidgetStateProperty.all(const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0)), // Padding
        textStyle: WidgetStateProperty.all(const TextStyle(
          fontSize: 16.0,
          fontWeight: FontWeight.w600,
        )), //
      )
  ),
  textButtonTheme:TextButtonThemeData(
    style: ButtonStyle(
      foregroundColor: WidgetStateProperty.all(kBlackColor), // Text color

      overlayColor: WidgetStateProperty.resolveWith<Color?>(
            (Set<WidgetState> states) {
          if (states.contains(WidgetState.pressed)) return Colors.grey[400]; // Ripple effect
          return null;
        },
      ),
      padding: WidgetStateProperty.all(const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0)), // Padding
      textStyle: WidgetStateProperty.all(const TextStyle(
        fontSize: 16.0,
        fontWeight: FontWeight.w600,
      )), // Text style

    ),
  ),
);