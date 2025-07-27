import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:siana_erran_app/providers/errand/location_provider.dart';
import 'package:siana_erran_app/providers/errand/task_provider.dart';
import 'location_input_widget.dart';
import 'suggested_addresses_list.dart';

class LocationSectionWidget extends StatefulWidget {
  const LocationSectionWidget({super.key});

  @override
  State<LocationSectionWidget> createState() => _LocationSectionWidgetState();
}

class _LocationSectionWidgetState extends State<LocationSectionWidget> {
  late TextEditingController _startLocationController;
  late TextEditingController _destinationController;

  @override
  void initState() {
    super.initState();
    _startLocationController = TextEditingController();
    _destinationController = TextEditingController();
  }

  @override
  void dispose() {
    _startLocationController.dispose();
    _destinationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<TaskProvider, LocationProvider>(
      builder: (context, taskProvider, locationProvider, child) {
        if (taskProvider.isShadowTask) {
          return _buildShadowLocationSection(locationProvider);
        } else {
          return _buildDeliveryLocationSection(locationProvider);
        }
      },
    );
  }

  Widget _buildDeliveryLocationSection(LocationProvider locationProvider) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Location Of Task',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 12),
        LocationInputWidget(
          hint: 'Enter start location...',
          selectedLocation: locationProvider.selectedLocation,
          controller: _startLocationController,
          isDestination: false,
        ),
        const SizedBox(height: 16),
        SuggestedAddressesList(
          startLocationController: _startLocationController,
        ),
      ],
    );
  }

  Widget _buildShadowLocationSection(LocationProvider locationProvider) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Where does the task start?',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 12),
        LocationInputWidget(
          hint: 'Enter start location...',
          selectedLocation: locationProvider.selectedLocation,
          controller: _startLocationController,
          isDestination: false,
        ),
        const SizedBox(height: 16),
        const Text(
          'Where does the task end?',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 12),
        LocationInputWidget(
          hint: 'Enter destination...',
          selectedLocation: locationProvider.selectedDestination,
          controller: _destinationController,
          isDestination: true,
        ),
        const SizedBox(height: 16),
        SuggestedAddressesList(
          startLocationController: _startLocationController,
          destinationController: _destinationController,
        ),
      ],
    );
  }
}