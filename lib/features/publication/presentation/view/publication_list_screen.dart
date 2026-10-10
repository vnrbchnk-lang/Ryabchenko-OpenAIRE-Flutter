import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:openaire_publications/common/widgets/app_scaffold.dart';
import 'package:openaire_publications/features/publication/presentation/bloc/list/publication_list_cubit.dart';
import 'package:openaire_publications/features/publication/presentation/bloc/list/publication_list_state.dart';
import 'package:openaire_publications/features/publication/presentation/view/widgets/publication_card.dart';

class PublicationListScreen extends StatelessWidget {
  const PublicationListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      body: BlocBuilder<PublicationListCubit, PublicationListState>(
        builder: (context, state) => switch (state) {
          PublicationListLoading() => const Center(
            child: CircularProgressIndicator(),
          ),
          PublicationListLoaded(:final items) => ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: items.length,
            separatorBuilder: (_, _) => const SizedBox(height: 12),
            itemBuilder: (context, index) =>
                PublicationCard(publication: items[index]),
          ),
        },
      ),
    );
  }
}
