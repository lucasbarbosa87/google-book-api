import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class AppController extends ChangeNotifier {
  ValueNotifier<ThemeMode> get themeMode;
  Future<void> initialize();
  void changeThemeMode(ThemeMode mode);
  void switchThemeMode();
}

class AppControllerImpl extends AppController {
  late final SharedPreferences _sharedPreferences;
  final _themeModeKey = 'theme_mode_key';

  @override
  final themeMode = ValueNotifier<ThemeMode>(ThemeMode.light);

  @override
  Future<void> initialize() async {
    _sharedPreferences = await SharedPreferences.getInstance();
    final cached = _sharedPreferences.getString(_themeModeKey);
    final mode = ThemeMode.values
            .firstWhereOrNull((element) => element.name == cached) ??
        themeMode.value;
    // setAppColors(mode);
    themeMode.value = mode;
  }

  @override
  void changeThemeMode(ThemeMode mode) {
    _sharedPreferences.setString(_themeModeKey, mode.name);
    // setAppColors(mode);
    themeMode.value = mode;
  }

  @override
  void switchThemeMode() {
    final newValue =
        themeMode.value == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    changeThemeMode(newValue);
  }
}
