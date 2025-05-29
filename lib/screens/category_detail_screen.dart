import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/destination_provider.dart';
import '../models/destination.dart';
import '../widgets/facility_chip.dart';

class CategoryDetailScreen extends StatefulWidget {
  final String title;
  final IconData icon;
  final Color color;

  const CategoryDetailScreen({
    Key? key,
    required this.title,
    required this.icon,
    required this.color,
  }) : super(key: key);

  @override
  State<CategoryDetailScreen> createState() => _CategoryDetailScreenState();
}

class _CategoryDetailScreenState extends State<CategoryDetailScreen> {
  @override
  void initState() {
    super.initState();
    // Set kategori saat screen dibuka
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<DestinationProvider>().setCategory(widget.title);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<DestinationProvider>(
      builder: (context, provider, child) {
        final categoryDestinations = provider.filteredDestinations;

        return Scaffold(
          appBar: AppBar(
            title: Text(widget.title),
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
              IconButton(
                icon: const Icon(Icons.filter_list),
                onPressed: () {
                  // TODO: Implement filter functionality
                },
              ),
            ],
          ),
          body: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                color: widget.color.withOpacity(0.1),
                child: Row(
                  children: [
                    Icon(widget.icon, size: 40, color: widget.color),
                    const SizedBox(width: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.title,
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '${categoryDestinations.length} destinasi tersedia',
                          style: TextStyle(
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Expanded(
                child: categoryDestinations.isEmpty
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
                        padding: const EdgeInsets.all(16),
                        itemCount: categoryDestinations.length,
                        itemBuilder: (context, index) {
                          final destination = categoryDestinations[index];
                          return Card(
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
                                        color: Colors.grey[300],
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
                                                      color: Colors.grey,
                                                    ),
                                                  );
                                                },
                                              ),
                                            )
                                          : const Center(
                                              child: Icon(
                                                Icons.image,
                                                size: 50,
                                                color: Colors.grey,
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
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          color: Colors.grey[600],
                                        ),
                                      ),
                                      const SizedBox(height: 16),
                                      Wrap(
                                        spacing: 8,
                                        runSpacing: 8,
                                        children: destination.facilities
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
                                            'Rp ${destination.price.toStringAsFixed(0)}',
                                            style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.green,
                                            ),
                                          ),
                                          ElevatedButton(
                                            onPressed: () {
                                              // TODO: Implement booking functionality
                                            },
                                            child: const Text('Pesan'),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
              ),
            ],
          ),
        );
      },
    );
  }
} 