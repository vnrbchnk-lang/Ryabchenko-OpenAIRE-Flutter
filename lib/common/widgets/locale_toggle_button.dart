import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:openaire_publications/common/locale/locale_cubit.dart';
import 'package:openaire_publications/l10n/app_localizations.dart';

class LocaleToggleButton extends StatelessWidget {
  const LocaleToggleButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => context.read<LocaleCubit>().toggle(),
      tooltip: AppLocalizations.of(context).actionToggleLanguage,
      icon: const Icon(Icons.translate),
    );
  }
}
