import 'package:flutter/material.dart';

class UIStateProvider extends ChangeNotifier {
  bool _isDateTimeExpanded = false;
  bool _isSubmitting = false;
  String? _errorMessage;
  bool _showLocationDropdown = false;
  
  // Getters
  bool get isDateTimeExpanded => _isDateTimeExpanded;
  bool get isSubmitting => _isSubmitting;
  String? get errorMessage => _errorMessage;
  bool get showLocationDropdown => _showLocationDropdown;
  
  // Methods
  void toggleDateTimeExpanded() {
    _isDateTimeExpanded = !_isDateTimeExpanded;
    notifyListeners();
  }
  
  void setDateTimeExpanded(bool expanded) {
    _isDateTimeExpanded = expanded;
    notifyListeners();
  }
  
  void setSubmitting(bool submitting) {
    _isSubmitting = submitting;
    notifyListeners();
  }
  
  void setErrorMessage(String? message) {
    _errorMessage = message;
    notifyListeners();
  }
  
  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }
  
  void showLocationDropdownSheet() {
    _showLocationDropdown = true;
    notifyListeners();
  }
  
  void hideLocationDropdownSheet() {
    _showLocationDropdown = false;
    notifyListeners();
  }
  
  void resetUIState() {
    _isDateTimeExpanded = false;
    _isSubmitting = false;
    _errorMessage = null;
    _showLocationDropdown = false;
    notifyListeners();
  }
}