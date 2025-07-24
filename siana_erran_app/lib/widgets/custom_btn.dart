// Custom Button Component
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;

  /// If null, will default to Theme.colorScheme.primary
  final Color? backgroundColor;

  /// If null, will default to Theme.colorScheme.onPrimary
  final Color? textColor;

  /// Height of the button
  final double height;

  /// Corner radius
  final double borderRadius;

  /// If null, will default to Theme.textTheme.labelLarge
  final TextStyle? textStyle;

  /// Optional arrow icon asset, falling back to Icon widget if null or missing
  final String? arrowIconAsset;

  const CustomButton({
    super.key,
    required this.text,
    this.onPressed,
    this.backgroundColor,
    this.textColor,
    this.height = 56,
    this.borderRadius = 28,
    this.textStyle,
    this.arrowIconAsset = 'assets/icons/arrow_forward.png',
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final defaultBg = backgroundColor ?? scheme.primary;
    final defaultText = textColor ?? scheme.onPrimary;
    final defaultTextStyle = (textStyle ?? theme.textTheme.labelLarge)
        ?.copyWith(color: defaultText, fontWeight: FontWeight.w600);

    return SizedBox(
      width: double.infinity,
      height: height,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: defaultBg,
          foregroundColor: defaultText,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          elevation: 0,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(text, style: defaultTextStyle),
            const SizedBox(width: 8),
            arrowIconAsset != null
                ? Image.asset(
                    arrowIconAsset!,
                    width: 20,
                    height: 20,
                    color: defaultText,
                    errorBuilder: (context, error, stackTrace) =>
                        Icon(Icons.arrow_forward, size: 20, color: defaultText),
                  )
                : Icon(Icons.arrow_forward, size: 16, color: defaultText),
          ],
        ),
      ),
    );
  }
}








class CustomButtonTxt extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;

  /// If null, will default to Theme.colorScheme.primary
  final Color? backgroundColor;

  /// If null, will default to Theme.colorScheme.onPrimary
  final Color? textColor;
  final Color? bgColor;

  /// Height of the button
  final double height;
  final double width;

  /// Corner radius
  final double borderRadius;

  /// If null, will default to Theme.textTheme.labelLarge
  final TextStyle? textStyle;

  const CustomButtonTxt({
    super.key,
    required this.text,
    this.onPressed,
    this.backgroundColor,
    this.textColor,
    this.height = 56,
    this.width = double.infinity,
    this.borderRadius = 28,
    this.textStyle,
    this.bgColor,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final defaultBg = backgroundColor ?? scheme.primary;
    final defaultText = textColor ?? scheme.onPrimary;

    return InkWell(
      onTap: onPressed,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        child: Center(child: Text(text, style: textStyle)),
      ),
    );
  }
}
