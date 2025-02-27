import 'package:flutter/material.dart';
import '../../../model/ride/locations.dart';

class LocationTile extends StatelessWidget {
  final Location location;
  final VoidCallback onTap;

  const LocationTile({
    super.key,
    required this.location,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.location_on), // Icon for the location
      title: Text(
        location.name,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle: Text(
        location.country.name, // Display the country name
        style: const TextStyle(
          fontSize: 14,
          color: Colors.grey,
        ),
      ),
      onTap: onTap, // Handle tap events
    );
  }
}