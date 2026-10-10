import 'package:flutter/material.dart';
import 'package:openaire_publications/common/theme/app_colors.dart';

abstract final class AppTheme {
  static ThemeData get light => _build(Brightness.light);

  static ThemeData get dark => _build(Brightness.dark);

  static ThemeData _build(Brightness brightness) => ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.seed,
      brightness: brightness,
    ),
  );
}
