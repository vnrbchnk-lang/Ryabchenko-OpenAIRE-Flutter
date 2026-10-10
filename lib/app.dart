import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:openaire_publications/common/locale/locale_cubit.dart';
import 'package:openaire_publications/common/navigation/app_router.dart';
import 'package:openaire_publications/common/theme/app_theme.dart';
import 'package:openaire_publications/common/theme/theme_cubit.dart';
import 'package:openaire_publications/features/publication/data/publication_repository.dart';
import 'package:openaire_publications/features/publication/domain/i_publication_repository.dart';
import 'package:openaire_publications/features/publication/presentation/bloc/list/publication_list_cubit.dart';
import 'package:openaire_publications/l10n/app_localizations.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<IPublicationRepository>(
          create: (_) => const PublicationRepository(),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) =>
                PublicationListCubit(context.read<IPublicationRepository>())
                  ..load(),
          ),
          BlocProvider(create: (_) => ThemeCubit()),
          BlocProvider(create: (_) => LocaleCubit()),
        ],
        child: Builder(
          builder: (context) {
            final themeMode = context.watch<ThemeCubit>().state;
            final locale = context.watch<LocaleCubit>().state;
            return MaterialApp.router(
              routerConfig: AppRouter.router,
              onGenerateTitle: (context) =>
                  AppLocalizations.of(context).appTitle,
              debugShowCheckedModeBanner: false,
              theme: AppTheme.light,
              darkTheme: AppTheme.dark,
              themeMode: themeMode,
              locale: locale,
              localizationsDelegates: AppLocalizations.localizationsDelegates,
              supportedLocales: AppLocalizations.supportedLocales,
            );
          },
        ),
      ),
    );
  }
}
