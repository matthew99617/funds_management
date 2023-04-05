import 'package:bloc/bloc.dart';
import '../../../shared/theme.dart';
import 'package:flutter/material.dart';

part 'theme_change_state.dart';

class ThemeChangeCubit extends Cubit<ThemeChangeState> {
  ThemeChangeCubit() : super(ThemeChangeState(themeData: AppThemes.darkTheme, isDark: true));

  void toggleTheme(){
    if (state.isDark == true){
      emit(ThemeChangeState(themeData: AppThemes.lightTheme, isDark: false));
    } else {
      emit(ThemeChangeState(themeData: AppThemes.darkTheme, isDark: true));
    }
  }
}
