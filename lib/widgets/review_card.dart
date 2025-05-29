import 'package:flutter/material.dart';
import 'package:travel_guide/models/destination.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:intl/intl.dart';

class ReviewCard extends StatelessWidget {
  final Review review;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;
  final bool isEditable;

  const ReviewCard({
    super.key,
    required this.review,
    this.onEdit,
    this.onDelete,
    this.isEditable = false,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundColor: Theme.of(context).primaryColor.withOpacity(0.1),
                  child: Text(
                    review.userName.isNotEmpty ? review.userName[0].toUpperCase() : '?',
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        review.userName,
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        DateFormat('dd MMM yyyy, HH:mm').format(review.date),
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
                if (isEditable) ...[
                  IconButton(
                    icon: const Icon(Icons.edit, size: 20),
                    onPressed: onEdit,
                    tooltip: 'Edit Review',
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete, size: 20),
                    onPressed: onDelete,
                    tooltip: 'Hapus Review',
                  ),
                ],
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                RatingBar.builder(
                  initialRating: review.rating,
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemSize: 16,
                  ignoreGestures: true,
                  itemBuilder: (context, _) => const Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  onRatingUpdate: (rating) {},
                ),
                const SizedBox(width: 8),
                Text(
                  review.rating.toStringAsFixed(1),
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[700],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              review.comment,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                height: 1.5,
              ),
            ),
            if (review.reply != null) ...[
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Balasan dari Admin',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[700],
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      review.reply!,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
} 