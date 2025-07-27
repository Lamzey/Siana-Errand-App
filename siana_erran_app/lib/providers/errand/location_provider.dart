import 'package:flutter/material.dart';
import 'package:siana_erran_app/features/Errands/constants/address_constant.dart';
import 'package:siana_erran_app/features/Errands/constants/task_constants.dart';


class LocationProvider extends ChangeNotifier {
  String _selectedLocation = 'New York';
  String _selectedDestination = 'New York';
  String _startLocationText = '';
  String _destinationText = '';
  
  // Getters
  String get selectedLocation => _selectedLocation;
  String get selectedDestination => _selectedDestination;
  String get startLocationText => _startLocationText;
  String get destinationText => _destinationText;
  List<String> get locations => TaskConstants.locations;
  List<Map<String, String>> get suggestedAddresses => AddressConstants.suggestedAddresses;
  
  // Methods
  void setSelectedLocation(String location) {
    _selectedLocation = location;
    notifyListeners();
  }
  
  void setSelectedDestination(String destination) {
    _selectedDestination = destination;
    notifyListeners();
  }
  
  void setStartLocationText(String text) {
    _startLocationText = text;
    notifyListeners();
  }
  
  void setDestinationText(String text) {
    _destinationText = text;
    notifyListeners();
  }
  
  void selectSuggestedAddress(String address, {bool isDestination = false}) {
    if (isDestination) {
      _destinationText = address;
    } else {
      _startLocationText = address;
    }
    notifyListeners();
  }
  
  void resetLocations() {
    _selectedLocation = 'New York';
    _selectedDestination = 'New York';
    _startLocationText = '';
    _destinationText = '';
    notifyListeners();
  }
  
  Map<String, dynamic> getLocationData() {
    return {
      'selectedLocation': _selectedLocation,
      'selectedDestination': _selectedDestination,
      'startLocationText': _startLocationText,
      'destinationText': _destinationText,
    };
  }
}