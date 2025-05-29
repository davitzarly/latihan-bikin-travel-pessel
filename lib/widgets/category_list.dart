import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel_guide/providers/destination_provider.dart';

class CategoryList extends StatelessWidget {
  const CategoryList({super.key});

  @override
  Widget build(BuildContext context) {
    final categories = [
      {'icon': Icons.beach_access, 'name': 'Pantai'},
      {'icon': Icons.landscape, 'name': 'Gunung'},
      {'icon': Icons.temple_hindu, 'name': 'Temple'},
      {'icon': Icons.restaurant, 'name': 'Kuliner'},
      {'icon': Icons.hotel, 'name': 'Hotel'},
      {'icon': Icons.park, 'name': 'Taman'},
      {'icon': Icons.museum, 'name': 'Museum'},
      {'icon': Icons.shopping_bag, 'name': 'Belanja'},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Kategori',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              TextButton(
                onPressed: () {
                  // TODO: Implementasi lihat semua kategori
                },
                child: const Text('Lihat Semua'),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 100,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: categories.length,
            itemBuilder: (context, index) {
              final category = categories[index];
              return Padding(
                padding: const EdgeInsets.only(right: 16.0),
                child: Consumer<DestinationProvider>(
                  builder: (context, destinationProvider, child) {
                    final isSelected = destinationProvider.currentCategory == category['name'];
                    return InkWell(
                      onTap: () {
                        if (isSelected) {
                          destinationProvider.setCategory('Semua');
                        } else {
                          destinationProvider.setCategory(category['name'] as String);
                        }
                      },
                      borderRadius: BorderRadius.circular(12),
                      child: Container(
                        width: 80,
                        decoration: BoxDecoration(
                          color: isSelected
                              ? Theme.of(context).colorScheme.primary
                              : Theme.of(context).colorScheme.surface,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: isSelected
                                ? Theme.of(context).colorScheme.primary
                                : Theme.of(context).colorScheme.outline,
                          ),
                          boxShadow: isSelected
                              ? [
                                  BoxShadow(
                                    color: Theme.of(context).colorScheme.primary.withOpacity(0.3),
                                    blurRadius: 8,
                                    offset: const Offset(0, 2),
                                  ),
                                ]
                              : null,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              category['icon'] as IconData,
                              color: isSelected
                                  ? Theme.of(context).colorScheme.onPrimary
                                  : Theme.of(context).colorScheme.primary,
                              size: 28,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              category['name'] as String,
                              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                    color: isSelected
                                        ? Theme.of(context).colorScheme.onPrimary
                                        : Theme.of(context).colorScheme.onSurface,
                                    fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                                  ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          ),
        ),
      ],
    );
  }
} 