import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:funds_management/bloc/cubit/theme/theme_change_cubit.dart';

import '../../../../shared/share_preference_helper.dart';

class SwitchModeButton extends StatefulWidget {
  const SwitchModeButton({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SwitchModeButtonState();
}

class _SwitchModeButtonState extends State{

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeChangeCubit, ThemeChangeState>(
      builder: (context, state) {
        return Switch(
          value: state.isDark,
          onChanged: (isDark) {
            setState(() {
              final cubit = context.read<ThemeChangeCubit>();
              state.isDark == isDark;
              cubit.toggleTheme();
            });
          },
        );
      },
    );
  }
}