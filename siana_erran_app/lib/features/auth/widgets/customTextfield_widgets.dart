// Reusable Custom Text Field Widget
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final String hintText;
  final bool isPassword;
  final IconData? prefixIcon;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  Color? hintColor;
  Color? fillColor;
  

  CustomTextField({
    super.key,
    required this.label,
    required this.hintText,
    this.isPassword = false,
    this.prefixIcon,
    this.controller,
    this.validator,
    required this.hintColor,
    required this.fillColor, 
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(6),
          ),
          child: TextFormField(
            controller: controller,
            obscureText: isPassword,
            validator: validator,
            decoration: InputDecoration(
              hintText: hintText,
              filled: true,
              fillColor: fillColor,
              hintStyle: TextStyle(color: hintColor, fontSize: 14),
              prefixIcon: prefixIcon != null
                  ? Icon(prefixIcon, color: hintColor, size: 20)
                  : null,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6),
                borderSide: BorderSide.none,
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 12,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
