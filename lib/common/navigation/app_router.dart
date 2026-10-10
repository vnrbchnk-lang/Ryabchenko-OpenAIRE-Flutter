import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:openaire_publications/common/widgets/app_scaffold.dart';
import 'package:openaire_publications/features/publication/presentation/view/publication_list_screen.dart';
import 'package:openaire_publications/l10n/app_localizations.dart';

abstract final class AppRoutes {
  static const String list = '/';
}

abstract final class AppRouter {
  static final GoRouter router = _create();

  static GoRouter _create() {
    GoRouter.optionURLReflectsImperativeAPIs = true;
    return GoRouter(
      initialLocation: AppRoutes.list,
      routes: [
        GoRoute(
          path: AppRoutes.list,
          builder: (context, state) => const PublicationListScreen(),
        ),
      ],
      errorBuilder: (context, state) => const _NotFoundScreen(),
    );
  }
}

class _NotFoundScreen extends StatelessWidget {
  const _NotFoundScreen();

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      body: Center(child: Text(AppLocalizations.of(context).pageNotFound)),
    );
  }
}
