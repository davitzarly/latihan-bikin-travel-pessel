import 'package:flutter/material.dart';

class FacilityChip extends StatelessWidget {
  final String label;
  final IconData? icon;

  const FacilityChip({
    super.key,
    required this.label,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, size: 16),
            const SizedBox(width: 4),
          ],
          Text(label),
        ],
      ),
      backgroundColor: Theme.of(context).primaryColor.withOpacity(0.1),
    );
  }
} 