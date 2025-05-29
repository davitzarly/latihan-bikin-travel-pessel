import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/destination.dart';
import '../providers/destination_provider.dart';
import '../widgets/facility_chip.dart';
import '../widgets/review_card.dart';

class DestinationDetailScreen extends StatelessWidget {
  final Destination destination;

  const DestinationDetailScreen({
    super.key,
    required this.destination,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 300,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  PageView.builder(
                    itemCount: destination.images.length,
                    itemBuilder: (context, index) {
                      return Image.network(
                        destination.images[index],
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => const Center(
                          child: Icon(Icons.image_not_supported, size: 50),
                        ),
                      );
                    },
                  ),
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black.withOpacity(0.7),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              title: Text(
                destination.name,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            actions: [
              Consumer<DestinationProvider>(
                builder: (context, provider, _) => IconButton(
                  icon: Icon(
                    provider.isFavorite(destination.id)
                        ? Icons.favorite
                        : Icons.favorite_border,
                    color: provider.isFavorite(destination.id)
                        ? Colors.red
                        : Colors.white,
                  ),
                  onPressed: () => provider.toggleFavorite(destination.id),
                ),
              ),
            ],
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.location_on, color: Colors.grey),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          destination.location,
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(Icons.star, color: Colors.amber),
                      const SizedBox(width: 4),
                      Text(
                        destination.rating.toString(),
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      const Spacer(),
                      Text(
                        destination.price > 0
                            ? 'Rp ${destination.price}'
                            : 'Gratis',
                        style: TextStyle(
                          color: destination.price > 0
                              ? Theme.of(context).primaryColor
                              : Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Deskripsi',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 8),
                  Text(destination.description),
                  const SizedBox(height: 16),
                  Text(
                    'Fasilitas',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: destination.facilities
                        .map((facility) => FacilityChip(label: facility))
                        .toList(),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Informasi',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 8),
                  if (destination.website != null) ...[
                    ListTile(
                      leading: const Icon(Icons.language),
                      title: const Text('Website'),
                      subtitle: Text(destination.website!),
                    ),
                  ],
                  if (destination.phone != null) ...[
                    ListTile(
                      leading: const Icon(Icons.phone),
                      title: const Text('Telepon'),
                      subtitle: Text(destination.phone!),
                    ),
                  ],
                  if (destination.email != null) ...[
                    ListTile(
                      leading: const Icon(Icons.email),
                      title: const Text('Email'),
                      subtitle: Text(destination.email!),
                    ),
                  ],
                  if (destination.openingHours != null) ...[
                    ListTile(
                      leading: const Icon(Icons.access_time),
                      title: const Text('Jam Operasional'),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: destination.openingHours!.entries
                            .map((entry) => Text(
                                '${entry.key}: ${entry.value}'))
                            .toList(),
                      ),
                    ),
                  ],
                  const SizedBox(height: 16),
                  Text(
                    'Ulasan',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 8),
                  if (destination.reviews.isEmpty)
                    const Center(
                      child: Text('Belum ada ulasan'),
                    )
                  else
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: destination.reviews.length,
                      itemBuilder: (context, index) {
                        return ReviewCard(
                          review: destination.reviews[index],
                        );
                      },
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: ElevatedButton(
            onPressed: () {
              // TODO: Implementasi navigasi ke lokasi
            },
            child: const Text('Lihat Lokasi'),
          ),
        ),
      ),
    );
  }
} 