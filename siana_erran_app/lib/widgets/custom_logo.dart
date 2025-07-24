

// Reusable Logo Component
import 'package:flutter/material.dart';
import 'package:siana_erran_app/core/utils/assets_utiles.dart';

// Reusable Logo Component
class CustomLogo extends StatelessWidget {
  final double size;
  final String? logoAsset;

  const CustomLogo({
    super.key,
    this.size = 60,
    this.logoAsset = '${iconPath}siana_ic.png',
  });

  @override
  Widget build(BuildContext context) {
    if (logoAsset == null) {
      return Container(
        width: size,
        height: size,
        decoration: const BoxDecoration(
          color: Colors.grey,
          shape: BoxShape.circle,
        ),
        child: const Icon(Icons.image, color: Colors.white),
      );
    }

    return SizedBox(
      width: size,
      height: size,
      child: Image.asset(
        logoAsset!,
        width: size,
        height: size,
        fit: BoxFit.contain,
        errorBuilder: (context, error, stackTrace) {
          return Container(
            width: size,
            height: size,
            decoration: const BoxDecoration(
              color: Colors.grey,
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.image, color: Colors.white),
          );
        },
      ),
    );
  }
}




