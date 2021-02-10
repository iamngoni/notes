import 'package:flutter/material.dart';
import 'package:notes/controllers/settings.dart';
import 'package:provider/provider.dart';

Widget darkModeSwitch() {
  return Consumer<SettingsState>(
    builder: (context, controller, child) {
      return GestureDetector(
        child: controller.darkMode == true
            ? Text(
                "🌚",
                style: TextStyle(
                  fontSize: 18,
                ),
              )
            : Text(
                "🌞",
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
        onTap: () => controller.changeDarkMode(),
      );
    },
  );
}
