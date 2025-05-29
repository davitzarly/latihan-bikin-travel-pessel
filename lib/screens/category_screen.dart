import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/destination_provider.dart';
import '../models/destination.dart';
import '../widgets/facility_chip.dart';
import 'destination_detail_screen.dart';

class CategoryScreen extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color color;

  const CategoryScreen({
    super.key,
    required this.title,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<DestinationProvider>(
      builder: (context, provider, child) {
        final categoryDestinations = provider.filteredDestinations;

        return Scaffold(
          appBar: AppBar(
            title: Text(title),
            actions: [
              IconButton(
                icon: const Icon(Icons.sort),
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (context) => Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ListTile(
                          leading: const Icon(Icons.star),
                          title: const Text('Rating'),
                          onTap: () {
                            provider.setSortBy('rating');
                            Navigator.pop(context);
                          },
                        ),
                        ListTile(
                          leading: const Icon(Icons.attach_money),
                          title: const Text('Harga'),
                          onTap: () {
                            provider.setSortBy('price');
                            Navigator.pop(context);
                          },
                        ),
                        ListTile(
                          leading: const Icon(Icons.sort_by_alpha),
                          title: const Text('Nama'),
                          onTap: () {
                            provider.setSortBy('name');
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
          body: categoryDestinations.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.search_off,
                        size: 64,
                        color: Colors.grey[400],
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Tidak ada destinasi yang ditemukan',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                )
              : ListView.builder(
                  itemCount: categoryDestinations.length,
                  padding: const EdgeInsets.all(16),
                  itemBuilder: (context, index) {
                    final destination = categoryDestinations[index];

                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DestinationDetailScreen(
                              destination: destination,
                            ),
                          ),
                        );
                      },
                      child: Card(
                        margin: const EdgeInsets.only(bottom: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Stack(
                              children: [
                                Container(
                                  height: 200,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: color.withOpacity(0.2),
                                    borderRadius: const BorderRadius.vertical(
                                      top: Radius.circular(12),
                                    ),
                                  ),
                                  child: destination.images.isNotEmpty
                                      ? ClipRRect(
                                          borderRadius: const BorderRadius.vertical(
                                            top: Radius.circular(12),
                                          ),
                                          child: Image.network(
                                            destination.images[0],
                                            fit: BoxFit.cover,
                                            errorBuilder: (context, error, stackTrace) {
                                              return const Center(
                                                child: Icon(
                                                  Icons.image,
                                                  size: 50,
                                                  color: Colors.white,
                                                ),
                                              );
                                            },
                                          ),
                                        )
                                      : const Center(
                                          child: Icon(
                                            Icons.image,
                                            size: 50,
                                            color: Colors.white,
                                          ),
                                        ),
                                ),
                                Positioned(
                                  top: 8,
                                  right: 8,
                                  child: IconButton(
                                    icon: Icon(
                                      provider.isFavorite(destination.id)
                                          ? Icons.favorite
                                          : Icons.favorite_border,
                                      color: provider.isFavorite(destination.id)
                                          ? Colors.red
                                          : Colors.white,
                                    ),
                                    onPressed: () {
                                      provider.toggleFavorite(destination.id);
                                    },
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.all(16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    destination.name,
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    destination.description,
                                    style: TextStyle(
                                      color: Colors.grey[600],
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(height: 16),
                                  Wrap(
                                    spacing: 8,
                                    runSpacing: 8,
                                    children: destination.facilities
                                        .take(3)
                                        .map((facility) => FacilityChip(label: facility))
                                        .toList(),
                                  ),
                                  const SizedBox(height: 16),
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.location_on,
                                        size: 16,
                                        color: Colors.grey,
                                      ),
                                      const SizedBox(width: 4),
                                      Text(
                                        destination.location,
                                        style: const TextStyle(
                                          color: Colors.grey,
                                        ),
                                      ),
                                      const Spacer(),
                                      const Icon(
                                        Icons.star,
                                        size: 16,
                                        color: Colors.amber,
                                      ),
                                      const SizedBox(width: 4),
                                      Text(
                                        destination.rating.toString(),
                                        style: const TextStyle(
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 16),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        destination.price > 0
                                            ? 'Rp ${destination.price.toStringAsFixed(0)}'
                                            : 'Gratis',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: destination.price > 0 ? Colors.green : Colors.blue,
                                        ),
                                      ),
                                      ElevatedButton.icon(
                                        onPressed: () {
                                          // TODO: Implement booking functionality
                                        },
                                        icon: const Icon(Icons.bookmark_border),
                                        label: const Text('Pesan'),
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: color,
                                          foregroundColor: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
        );
      },
    );
  }
} 