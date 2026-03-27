import 'package:flutter/material.dart';

class EmptyDataWidget extends StatelessWidget {
  final String? title;
  final String? message;
  final IconData? icon;

  const EmptyDataWidget({
    super.key,
    this.title = 'No Data',
    this.message = 'No items found. Start by adding new data.',
    this.icon = Icons.inbox,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 80, color: Colors.grey[400]),
          const SizedBox(height: 16),
          Text(
            title ?? 'No Data',
            style: Theme.of(
              context,
            ).textTheme.headlineSmall?.copyWith(color: Colors.grey[600]),
          ),
          const SizedBox(height: 8),
          Text(
            message ?? 'No items found',
            textAlign: TextAlign.center,
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(color: Colors.grey[500]),
          ),
        ],
      ),
    );
  }
}
