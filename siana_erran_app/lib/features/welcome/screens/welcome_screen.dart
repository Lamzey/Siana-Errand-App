import 'package:flutter/material.dart';
import 'package:siana_erran_app/core/utils/assets_utiles.dart';
import 'package:siana_erran_app/widgets/custom_logo.dart';

// Main Welcome Screen
class WelcomeScreen extends StatelessWidget {
  final String title;
  final String subtitle;
  final String buttonText;
  final VoidCallback? onButtonPressed;
  final Color primaryColor;
  final Color backgroundColor;
  final String? logoAsset;

  const WelcomeScreen({
    Key? key,
    this.title = 'Welcome to SIANA',
    this.subtitle =
        'The Errand Platform. Discover how we connect you with local agents for all your errands.',
    this.buttonText = 'Get Started',
    this.onButtonPressed,
    this.primaryColor = const Color(0xFF4A90E2),
    this.backgroundColor = const Color(0xFFF5F5F5),
    this.logoAsset = '${iconPath}siana_ac_b.png',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              // Header with logo
              const SizedBox(height: 40),
              CustomLogo(logoAsset: logoAsset, size: 100),

              const SizedBox(height: 60),

              // Main illustration card
              Expanded(
                child: Image.asset(
                  "${imagePath}onboarding_image_one.png",
                  width: 300,
                  height: 300,
                ),
              ),

              const SizedBox(height: 40),

              // Welcome text section
              WelcomeTextSection(title: title, subtitle: subtitle),

              const SizedBox(height: 40),

              // Get started button
              CustomButton(
                text: buttonText,
                onPressed: onButtonPressed,
                backgroundColor: Colors.black87,
              ),

              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}

// Welcome Text Section Component
class WelcomeTextSection extends StatelessWidget {
  final String title;
  final String subtitle;
  final TextStyle? titleStyle;
  final TextStyle? subtitleStyle;

  const WelcomeTextSection({
    Key? key,
    required this.title,
    required this.subtitle,
    this.titleStyle,
    this.subtitleStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          title,
          style:
              titleStyle ??
              const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
          textAlign: TextAlign.center,
        ),

        const SizedBox(height: 16),

        Text(
          subtitle,
          style:
              subtitleStyle ??
              TextStyle(fontSize: 16, color: Colors.grey.shade600, height: 1.5),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

// Custom Button Component
class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final Color backgroundColor;
  final Color textColor;
  final double height;
  final double borderRadius;
  final TextStyle? textStyle;
  final String? arrowIconAsset;

  const CustomButton({
    Key? key,
    required this.text,
    this.onPressed,
    this.backgroundColor = Colors.black87,
    this.textColor = Colors.white,
    this.height = 56,
    this.borderRadius = 28,
    this.textStyle,
    this.arrowIconAsset = 'assets/icons/arrow_forward.png',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: height,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          foregroundColor: textColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          elevation: 0,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              text,
              style:
                  textStyle ??
                  const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const SizedBox(width: 8),
            arrowIconAsset != null
                ? Image.asset(
                    arrowIconAsset!,
                    width: 20,
                    height: 20,
                    color: textColor,
                    errorBuilder: (context, error, stackTrace) {
                      return Icon(
                        Icons.arrow_forward,
                        size: 20,
                        color: textColor,
                      );
                    },
                  )
                : Icon(Icons.arrow_forward, size: 20, color: textColor),
          ],
        ),
      ),
    );
  }
}
