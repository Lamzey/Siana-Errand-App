
// Section Title Widget
import 'package:flutter/material.dart';

class SectionTitle extends StatelessWidget {
  final String title;

  const SectionTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: Colors.black87,
      ),
    );
  }
}

// Create New Errand Button Widget
class CreateErrandButton extends StatelessWidget {
  final VoidCallback? onPressed;
  const CreateErrandButton({super.key, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.black,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.add, size: 25),
            SizedBox(width: 8),
            Text(
              'Create New Errand',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionTitle(title: 'Need Help?'),
        const SizedBox(height: 12),
        GestureDetector(
          onTap: onPressed,
          child: const Row(
            children: [
              Icon(Icons.headset_mic_outlined, color: Colors.blue, size: 20),
              SizedBox(width: 8),
              Text(
                'Quick Support & Chat',
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
