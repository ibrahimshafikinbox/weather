import 'package:flutter/material.dart';
import 'package:weather_app/core/utils/colors/app_colors.dart';

class SettingView extends StatelessWidget {
  const SettingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldbg,
      body: Center(
        child: Text("settings and profile , for time will be empty"),
      ),
    );
  }
}
