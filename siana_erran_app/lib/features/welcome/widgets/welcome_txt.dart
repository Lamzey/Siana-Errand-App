// Welcome Text Section Component
import 'package:flutter/material.dart';

class WelcomeTextSection extends StatelessWidget {
  final String title;
  final String subtitle;
  final TextStyle? titleStyle;
  final TextStyle? subtitleStyle;

  const WelcomeTextSection({
    super.key,
    required this.title,
    required this.subtitle,
    this.titleStyle,
    this.subtitleStyle,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    // Fallback styles drawn from the theme
    final defaultTitleStyle = textTheme.headlineSmall?.copyWith(
      color: colorScheme.onSurface,
      fontWeight: FontWeight.bold,
    );

    final defaultSubtitleStyle = textTheme.bodyLarge?.copyWith(
      color: colorScheme.onSurface.withValues(alpha: 0.7),
      height: 1.5,
    );

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          title,
          style: titleStyle ?? defaultTitleStyle,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 20),
        SizedBox(
          width:270,
          child: Text(
            subtitle,
            style: subtitleStyle ?? defaultSubtitleStyle,
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
