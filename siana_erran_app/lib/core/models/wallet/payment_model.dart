// Models
import 'package:flutter/material.dart';

class UserPaymentMethod {
  final String id;
  final String type;
  final String title;
  final String details;
  final String accountName;
  final bool isVerified;
  bool isDefault;

  UserPaymentMethod({
    required this.id,
    required this.type,
    required this.title,
    required this.details,
    required this.accountName,
    required this.isVerified,
    required this.isDefault,
  });
}

class PaymentMethodTemplate {
  final String id;
  final String name;
  final String subtitle;
  final IconData icon;
  final Color color;
  final List<String> fields;

  PaymentMethodTemplate({
    required this.id,
    required this.name,
    required this.subtitle,
    required this.icon,
    required this.color,
    required this.fields,
  });
}
