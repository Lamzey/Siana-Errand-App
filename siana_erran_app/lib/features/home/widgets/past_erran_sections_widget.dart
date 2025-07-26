
// Past Errands Section Widget
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:siana_erran_app/features/home/widgets/others_widgets.dart';

class PastErrandsSection extends StatelessWidget {
  const PastErrandsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
      ),
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
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              // boxShadow: [
              //   BoxShadow(
              //     color: Colors.black.withValues(alpha: 0.05),
              //     blurRadius: 10,
              //     offset: const Offset(0, 2),
              //   ),
              // ],
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
          Divider(color: Colors.grey.shade300),
        ],
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
            fontWeight: FontWeight.w500,
            color: Colors.black,
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
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          // Border and Icon Color change based on status (success: green)
          color: Colors.white,
          borderRadius: BorderRadius.circular(50),
          border: Border.all(color: Colors.greenAccent)

        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Transform.rotate(
              angle:
                  math.pi /
                  1.68, // Rotates 90 degrees clockwise (use math.pi for radians)
              child: Icon(PhosphorIconsRegular.gitDiff, color: Colors.green),
            ),
            SizedBox(width: 10),
            Text(
              'Reorder',
              style: TextStyle(
                fontSize: 14,
                color: Colors.green.shade800,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}