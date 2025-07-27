import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:siana_erran_app/providers/errand/location_provider.dart';

class LocationInputWidget extends StatelessWidget {
  final String hint;
  final String selectedLocation;
  final TextEditingController controller;
  final bool isDestination;

  const LocationInputWidget({
    super.key,
    required this.hint,
    required this.selectedLocation,
    required this.controller,
    this.isDestination = false,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<LocationProvider>(
      builder: (context, locationProvider, child) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.grey.shade50,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey.shade200),
          ),
          child: Row(
            children: [
              const Padding(
                padding: EdgeInsets.all(12),
                child: Icon(Icons.search, color: Colors.grey, size: 20),
              ),
              Expanded(
                child: TextField(
                  controller: controller,
                  onChanged: (value) {
                    if (isDestination) {
                      locationProvider.setDestinationText(value);
                    } else {
                      locationProvider.setStartLocationText(value);
                    }
                  },
                  decoration: InputDecoration(
                    hintText: hint,
                    border: InputBorder.none,
                    hintStyle: TextStyle(
                      color: Colors.grey.shade500,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () => _showLocationDropdown(context, locationProvider),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        selectedLocation,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(width: 4),
                      const Icon(Icons.keyboard_arrow_down, color: Colors.grey, size: 20),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showLocationDropdown(BuildContext context, LocationProvider locationProvider) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Select Location',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 16),
              ...locationProvider.locations.map((location) {
                return ListTile(
                  title: Text(location),
                  onTap: () {
                    if (isDestination) {
                      locationProvider.setSelectedDestination(location);
                    } else {
                      locationProvider.setSelectedLocation(location);
                    }
                    Navigator.pop(context);
                  },
                );
              }).toList(),
            ],
          ),
        );
      },
    );
  }
}