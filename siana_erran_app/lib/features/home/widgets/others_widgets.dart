// Section Title Widget
import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class SectionTitle extends StatelessWidget {
  final String title;
  final double fontSize;
  final Color fontColor;
  final FontWeight fontWeight;

  const SectionTitle({
    super.key,
    required this.title,
    this.fontSize = 18,
    this.fontColor = Colors.black87,
    this.fontWeight = FontWeight.w600,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: fontColor,
      ),
    );
  }
}

// Create New Errand Button Widget
class CreateErrandButton extends StatelessWidget {
  final VoidCallback? onTap;
  const CreateErrandButton({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      splashColor: Colors.white.withValues(alpha: 0.2),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(8),
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.add, size: 25, color: Colors.white),
            SizedBox(width: 8),
            Text(
              'Create New Errand',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
// Help Section Widget
class HelpSection extends StatelessWidget {
  final VoidCallback? onPressed;

  const HelpSection({super.key, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(8),
      ),
      child: GestureDetector(
        onTap: onPressed,
        child: const Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              PhosphorIconsRegular.chatCircle,
              color: Colors.black,
              size: 20,
            ),
            SizedBox(width: 10),
            Text(
              'Quick Support & Chat',
              style: TextStyle(
                color: Colors.black87,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
