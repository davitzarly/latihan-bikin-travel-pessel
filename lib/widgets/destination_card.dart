import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shimmer/shimmer.dart';
import 'package:travel_guide/models/destination.dart';
import 'package:travel_guide/screens/destination_detail_screen.dart';
import 'package:provider/provider.dart';
import 'package:travel_guide/providers/destination_provider.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class DestinationCard extends StatelessWidget {
  final Destination destination;
  final VoidCallback onTap;
  final VoidCallback? onFavoriteToggle;
  final bool isFavorite;

  const DestinationCard({
    super.key,
    required this.destination,
    required this.onTap,
    this.onFavoriteToggle,
    this.isFavorite = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160,
      margin: const EdgeInsets.only(right: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.grey[200],
      ),
      child: InkWell(
        onTap: onTap,
          borderRadius: BorderRadius.circular(12),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                  child: CachedNetworkImage(
                    imageUrl: destination.images.isNotEmpty ? destination.images[0] : '',
                    height: 120,
                  width: double.infinity,
                          fit: BoxFit.cover,
                    placeholder: (context, url) => Shimmer.fromColors(
                      baseColor: Colors.grey[300]!,
                      highlightColor: Colors.grey[100]!,
                  child: Container(
                        color: Colors.white,
                      ),
                    ),
                    errorWidget: (context, url, error) => Container(
                      color: Colors.grey[300],
                      child: const Icon(Icons.error),
                        ),
                    ),
            ),
            Padding(
                  padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                      Text(
                        destination.name,
                        style: Theme.of(context).textTheme.titleMedium,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                  Row(
                    children: [
                          const Icon(Icons.location_on, size: 16, color: Colors.grey),
                          const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                              destination.location,
                              style: Theme.of(context).textTheme.bodySmall,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                      const SizedBox(height: 4),
                  Row(
                    children: [
                          const Icon(Icons.star, size: 16, color: Colors.amber),
                      const SizedBox(width: 4),
                      Text(
                        destination.rating.toString(),
                            style: Theme.of(context).textTheme.bodySmall,
                      ),
                      const Spacer(),
                          Text(
                            'Rp ${destination.price.toStringAsFixed(0)}',
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Colors.green,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            if (onFavoriteToggle != null)
              Positioned(
                top: 8,
                right: 8,
                child: IconButton(
                  icon: Icon(
                    isFavorite ? Icons.favorite : Icons.favorite_border,
                    color: isFavorite ? Colors.red : Colors.white,
                    size: 20,
                  ),
                  onPressed: onFavoriteToggle,
                  style: IconButton.styleFrom(
                    backgroundColor: Colors.black26,
                    padding: const EdgeInsets.all(4),
                        ),
              ),
            ),
          ],
        ),
      ),
    );
  }
} 