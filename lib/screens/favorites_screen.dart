import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel_guide/models/destination.dart';
import 'package:travel_guide/providers/destination_provider.dart';
import 'package:travel_guide/widgets/destination_card.dart';
import 'package:travel_guide/widgets/empty_state.dart';
import 'package:travel_guide/widgets/loading_state.dart';
import 'package:travel_guide/widgets/error_state.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<DestinationProvider>(
      builder: (context, provider, child) {
        if (provider.isLoading) {
          return const LoadingState(message: 'Memuat data favorit...');
        }

        if (provider.error != null) {
          return ErrorState(
            message: provider.error!,
            onRetry: () => provider.refresh(),
          );
        }

        final favorites = provider.getFavoriteDestinations();

        if (favorites.isEmpty) {
          return const EmptyState(
            message: 'Belum ada destinasi favorit',
            icon: Icons.favorite_border,
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: favorites.length,
          itemBuilder: (context, index) {
            final destination = favorites[index];
            return DestinationCard(
              destination: destination,
                onTap: () {
                  // TODO: Navigate to detail page
                },
              onFavoriteToggle: () {
                provider.toggleFavorite(destination.id);
              },
              isFavorite: true,
            );
          },
        );
      },
    );
  }
} 