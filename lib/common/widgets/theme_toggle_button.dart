import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:openaire_publications/common/theme/theme_cubit.dart';
import 'package:openaire_publications/l10n/app_localizations.dart';

class ThemeToggleButton extends StatelessWidget {
  const ThemeToggleButton({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = Theme.of(context).brightness == Brightness.dark;
    return IconButton(
      onPressed: () => context.read<ThemeCubit>().toggle(),
      tooltip: AppLocalizations.of(context).actionToggleTheme,
      icon: Icon(dark ? Icons.light_mode : Icons.dark_mode),
    );
  }
}
