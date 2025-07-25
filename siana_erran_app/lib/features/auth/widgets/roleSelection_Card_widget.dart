// Reusable Role Selection Card Widget
import 'package:flutter/material.dart';

class RoleSelectionCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String icon;
  final bool isSelected;
  final VoidCallback onTap;
  Color? selectedColor;
  Color? iconSelectedColor;
  Color selectedBorderColor;

  RoleSelectionCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.isSelected,
    required this.onTap,
    required this.selectedColor,
    required this.selectedBorderColor,
    this.iconSelectedColor = Colors.black87,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 163,
        height: 180,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: isSelected ? selectedColor : Colors.grey.shade100,
          border: Border.all(
            color: isSelected ? selectedBorderColor : Colors.white,
            width: isSelected ? 2 : 2,
          ),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              icon,
              width: 32,
              height: 32,
              color: isSelected ? iconSelectedColor : Colors.black87,
            ),
            const SizedBox(height: 8),
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
              subtitle,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
            ),
            const SizedBox(height: 12),
            Container(
              width: 20,
              height: 20,
              padding: EdgeInsets.all(3),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected ? Colors.blue : Colors.grey.shade400,
                  width: 2,
                ),
                color: Colors.transparent,
              ),
              child: isSelected
                  ? Container(
                      width: 10,
                      height: 10,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: const Color.fromARGB(255, 79, 111, 240),
                      ),
                    )
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}
