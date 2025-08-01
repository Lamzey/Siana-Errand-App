import 'package:flutter/material.dart';

class PaymentMethod {
  final String id;
  final String name;
  final String subtitle;
  final IconData icon;
  final Color color;
  final bool isPrimary;

  PaymentMethod({
    required this.id,
    required this.name,
    required this.subtitle,
    required this.icon,
    required this.color,
    this.isPrimary = false,
  });
}
