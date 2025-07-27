import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:siana_erran_app/providers/errand/location_provider.dart';


class SuggestedAddressesList extends StatelessWidget {
  final TextEditingController? startLocationController;
  final TextEditingController? destinationController;

  const SuggestedAddressesList({
    super.key,
    this.startLocationController,
    this.destinationController,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<LocationProvider>(
      builder: (context, locationProvider, child) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Suggested Addresses',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey.shade600,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 12),
            ...locationProvider.suggestedAddresses.map((address) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: GestureDetector(
                  onTap: () => _selectAddress(address['address']!, locationProvider),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.location_on_outlined,
                          size: 16,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              address['address']!,
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Colors.black,
                              ),
                            ),
                            Text(
                              address['label']!,
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey.shade600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ],
        );
      },
    );
  }

  void _selectAddress(String address, LocationProvider locationProvider) {
    if (startLocationController != null) {
      startLocationController!.text = address;
      locationProvider.setStartLocationText(address);
    }
    
    // If there's a destination controller (for Shadow tasks), 
    // you might want to add logic to determine which field to fill
    // For now, we'll default to start location
  }
}