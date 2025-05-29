import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel_guide/models/destination.dart';
import 'package:travel_guide/providers/destination_provider.dart';
import 'package:travel_guide/widgets/destination_card.dart';
import 'package:travel_guide/widgets/empty_state.dart';
import 'package:travel_guide/widgets/loading_state.dart';
import 'package:travel_guide/widgets/error_state.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<DestinationProvider>(
      builder: (context, provider, child) {
        return Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              TextField(
                decoration: InputDecoration(
                  hintText: 'Cari destinasi...',
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onChanged: (value) {
                  provider.setSearchQuery(value);
                },
              ),
              const SizedBox(height: 16),
              // TODO: Implementasi hasil pencarian
              const Text('Search Results'),
            ],
          ),
        );
      },
    );
  }
} 