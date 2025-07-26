// Active Errand Card Widget
import 'package:flutter/material.dart';

class ActiveErrandCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String time;
  final String status;
  final double progress;
  final String price;
  final Color statusColor;
  final VoidCallback? onTap;

  const ActiveErrandCard({
    super.key,
    required this.icon,
    required this.title,
    required this.time,
    required this.status,
    required this.progress,
    required this.price,
    required this.statusColor,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          children: [
            Row(
              children: [
                ErrandIcon(icon: icon),
                const SizedBox(width: 12),
                Expanded(
                  child: ErrandInfo(
                    title: title,
                    status: status,
                    statusColor: statusColor,
                  ),
                ),
                ErrandTimePrice(time: time, price: price),
                const SizedBox(width: 8),
                const Icon(Icons.chevron_right, color: Colors.black26),
              ],
            ),
            const SizedBox(height: 12),
            ErrandProgressBar(progress: progress, color: statusColor),
          ],
        ),
      ),
    );
  }
}



// Errand Icon Widget
class ErrandIcon extends StatelessWidget {
  final IconData icon;

  const ErrandIcon({super.key, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Icon(icon, color: Colors.black54, size: 20),
    );
  }
}

// Errand Info Widget
class ErrandInfo extends StatelessWidget {
  final String title;
  final String status;
  final Color statusColor;

  const ErrandInfo({
    super.key,
    required this.title,
    required this.status,
    required this.statusColor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          status,
          style: TextStyle(
            fontSize: 14,
            color: statusColor,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

// Errand Time and Price Widget
class ErrandTimePrice extends StatelessWidget {
  final String time;
  final String price;

  const ErrandTimePrice({super.key, required this.time, required this.price});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          time,
          style: const TextStyle(
            fontSize: 14,
            color: Colors.black54,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          price,
          style: const TextStyle(fontSize: 12, color: Colors.black54),
        ),
      ],
    );
  }
}

// Errand Progress Bar Widget
class ErrandProgressBar extends StatelessWidget {
  final double progress;
  final Color color;

  const ErrandProgressBar({
    super.key,
    required this.progress,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return LinearProgressIndicator(
      value: progress,
      backgroundColor: Colors.grey[200],
      valueColor: AlwaysStoppedAnimation<Color>(color),
      minHeight: 4,
    );
  }
}
