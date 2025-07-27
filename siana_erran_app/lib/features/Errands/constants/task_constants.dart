import 'package:flutter/material.dart';

class TaskConstants {
  static const List<String> mainTaskTypes = ['Delivery', 'Pickup', 'Shadow'];
  static const List<String> additionalTaskTypes = ['Personal Shopper', 'Other'];
  static const List<String> locations = [
    'New York', 
    'Los Angeles', 
    'Chicago', 
    'Denver', 
    'Dallas'
  ];
  
  static const Map<String, IconData> taskTypeIcons = {
    'Delivery': Icons.local_shipping_outlined,
    'Pickup': Icons.shopping_bag_outlined,
    'Shadow': Icons.person_outline,
    'Personal Shopper': Icons.shopping_cart_outlined,
    'Other': Icons.more_horiz,
  };

  static const List<String> monthNames = [
    'January', 'February', 'March', 'April', 'May', 'June',
    'July', 'August', 'September', 'October', 'November', 'December'
  ];

  static const List<String> weekDayAbbreviations = [
    'Su', 'Mo', 'Tu', 'We', 'Th', 'Fr', 'Sa'
  ];

  static const String defaultTaskDescription = 
      'e.g., Pick up groceries from ABC Supermarket, include milk, eggs, and bread. Deliver by 5 PM.';

  static const double defaultEstimatedQuote = 12.50;
}