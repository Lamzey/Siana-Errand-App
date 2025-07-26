
// Past Errands Section Widget
import 'package:flutter/material.dart';
import 'package:siana_erran_app/features/home/widgets/others_widgets.dart';

class PastErrandsSection extends StatelessWidget {
  const PastErrandsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionTitle(title: 'Past Errands'),
        const SizedBox(height: 16),
        PastErrandItem(
          title: 'Coffee Delivery',
          date: 'Yesterday, 06:15 AM',
          price: '\$8.50',
        ),
        PastErrandItem(
          title: 'Package Drop-off',
          date: 'Jan 24, 2024',
          price: '\$12.00',
        ),
        PastErrandItem(
          title: 'Pharmacy Pickup',
          date: 'Jan 22, 2024',
          price: '\$15.25',
        ),
      ],
    );
  }
}




// Past Errand Item Widget
class PastErrandItem extends StatelessWidget {
  final String title;
  final String date;
  final String price;
  final VoidCallback? onReorder;
  final VoidCallback? onTap;

  const PastErrandItem({
    super.key,
    required this.title,
    required this.date,
    required this.price,
    this.onReorder,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
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
        child: Row(
          children: [
            Expanded(
              child: PastErrandInfo(title: title, date: date),
            ),
            PastErrandPrice(price: price),
            const SizedBox(width: 8),
            ReorderButton(onPressed: onReorder),
          ],
        ),
      ),
    );
  }
}

// Past Errand Info Widget
class PastErrandInfo extends StatelessWidget {
  final String title;
  final String date;

  const PastErrandInfo({super.key, required this.title, required this.date});

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
        Text(date, style: const TextStyle(fontSize: 14, color: Colors.black54)),
      ],
    );
  }
}

// Past Errand Price Widget
class PastErrandPrice extends StatelessWidget {
  final String price;

  const PastErrandPrice({super.key, required this.price});

  @override
  Widget build(BuildContext context) {
    return Text(
      price,
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: Colors.black87,
      ),
    );
  }
}


// Reorder Button Widget
class ReorderButton extends StatelessWidget {
  final VoidCallback? onPressed;

  const ReorderButton({super.key, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(16),
        ),
        child: const Text(
          'Reorder',
          style: TextStyle(
            fontSize: 12,
            color: Colors.black54,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}