// Active Errand Card Widget
import 'package:flutter/material.dart';



// Active Errands Section Widget
class ActiveErrandsSection extends StatelessWidget {
  const ActiveErrandsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),
        ActiveErrandCard(
          icon: Icons.shopping_cart_outlined,
          title: 'Grocery Delivery',
          time: '10:30 AM',
          status: 'In Progress',
          progress: 0.6,
          price: 'ETA 15 min',
          statusColor: Colors.deepPurpleAccent,
        ),
        const SizedBox(height: 12),
        ActiveErrandCard(
          icon: Icons.description_outlined,
          title: 'Document Pickup',
          time: '12:00 PM',
          status: 'Pending',
          progress: 0.3,
          price: 'ETA 30 min',
          statusColor: Colors.orange,
        ),
        const SizedBox(height: 12),
        ActiveErrandCard(
          icon: Icons.local_laundry_service_outlined,
          title: 'Laundry Service',
          time: '04:45 PM',
          status: 'In Progress',
          progress: 0.8,
          price: 'ETA 45 min',
          statusColor: Colors.blue,
        ),
      ],
    );
  }
}
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
          crossAxisAlignment: CrossAxisAlignment.end,
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
              ],
            ),
            const SizedBox(height: 12),
            ErrandProgressBar(progress: progress, color: statusColor),
            const SizedBox(height: 15),
            const Icon(Icons.chevron_right, color: Colors.black26),
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
            fontSize: 18,
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
            fontWeight: FontWeight.w400,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          price,
          style: const TextStyle(
            fontSize: 14,
            color: Colors.black54,
            fontWeight: FontWeight.w400,
          ),
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
