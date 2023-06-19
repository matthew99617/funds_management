import 'package:flutter/material.dart';
import 'package:funds_management/shared/colors.dart';

class AppThemes {

  // lightTheme
  static ThemeData lightTheme = ThemeData(
    appBarTheme: AppBarTheme(
        color: lightBackground,
        iconTheme: IconThemeData(color: lightModeIcon),
        titleTextStyle: TextStyle(
          color: lightModeText,
        )
    ),
    scaffoldBackgroundColor: lightBackground,
    backgroundColor: lightBackground,
    textTheme: TextTheme(
      bodyText1: TextStyle(color: lightModeText),
      bodyText2: TextStyle(color: lightModeText),
      headline1: TextStyle(color: lightModeText),
      headline2: TextStyle(color: lightModeText),
      headline3: TextStyle(color: lightModeText),
      headline4: TextStyle(color: lightModeText),
      headline5: TextStyle(color: lightModeText),
      headline6: TextStyle(color: lightModeText),
    ),
    iconTheme: IconThemeData(color: lightModeIcon),
    dividerTheme: DividerThemeData(color: lightModeDivider),
    inputDecorationTheme: InputDecorationTheme(
      fillColor: lightSearchBar,
      prefixIconColor: lightModeIcon,
      prefixStyle: TextStyle(color: lightModeText),
      suffixIconColor: lightModeIcon,
      suffixStyle: TextStyle(color: lightModeText),
      iconColor: lightModeIcon,
      hintStyle: TextStyle(
        color: lightModeText,
      ),
      labelStyle: TextStyle(
        color: lightModeText,
      ),
    ),
    popupMenuTheme: PopupMenuThemeData(
      color: lightSearchBar,
      textStyle: TextStyle(
        color: lightModeText,
      ),
    ),
    bottomSheetTheme: BottomSheetThemeData(
      backgroundColor: lightBackground,
    ),
    navigationBarTheme: NavigationBarThemeData(
      backgroundColor: lightBackground,
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: lightBackground,
      selectedItemColor: lightModeText,
      unselectedItemColor: lightModeText,
    ),
    expansionTileTheme: ExpansionTileThemeData(
      collapsedBackgroundColor: lightModeSelectedExpandedTile,
      collapsedTextColor: lightModeText,
      collapsedIconColor: lightModeIcon,
    ),
      listTileTheme: ListTileThemeData(
        textColor: lightModeText,
      )
  );

    // darkTheme
  static ThemeData darkTheme = ThemeData(
    appBarTheme: AppBarTheme(
      color: darkBackground,
      iconTheme: IconThemeData(color: darkModeIcon),
      titleTextStyle: TextStyle(
        color: darkModeText,
      )
    ),
    scaffoldBackgroundColor: darkBackground,
    backgroundColor: darkBackground,
    textTheme: TextTheme(
      bodyText1: TextStyle(color: darkModeText),
      bodyText2: TextStyle(color: darkModeText),
      headline1: TextStyle(color: darkModeText),
      headline2: TextStyle(color: darkModeText),
      headline3: TextStyle(color: darkModeText),
      headline4: TextStyle(color: darkModeText),
      headline5: TextStyle(color: darkModeText),
      headline6: TextStyle(color: darkModeText),
    ),
    iconTheme: IconThemeData(color: darkModeIcon),
    dividerTheme: DividerThemeData(color: darkModeDivider),
    inputDecorationTheme: InputDecorationTheme(
      fillColor: darkSearchBar,
      prefixIconColor: darkModeIcon,
      prefixStyle: TextStyle(color: darkModeText),
      suffixIconColor: darkModeIcon,
      suffixStyle: TextStyle(color: darkModeText),
      iconColor: darkModeIcon,
      hintStyle: TextStyle(
      color: darkModeText,
      ),
      labelStyle: TextStyle(
        color: darkModeText,
      ),
    ),
    popupMenuTheme: PopupMenuThemeData(
      color: darkSearchBar,
      textStyle: TextStyle(
        color: darkModeText,
      ),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: darkBackground,
      selectedItemColor: darkModeText,
      unselectedItemColor: darkModeText,
    ),
    bottomSheetTheme: BottomSheetThemeData(
      backgroundColor: darkBackground,
    ),
    navigationBarTheme: NavigationBarThemeData(
      backgroundColor: darkBackground,
    ),
    expansionTileTheme: ExpansionTileThemeData(
      backgroundColor: darkModeSelectedExpandedTile,
      collapsedTextColor: darkModeText,
      collapsedIconColor: darkModeIcon,
    ),
    listTileTheme: ListTileThemeData(
      textColor: darkModeText,
    ),
  );
}