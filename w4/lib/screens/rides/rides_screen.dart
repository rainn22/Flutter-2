import 'package:flutter/material.dart';
import 'package:week_3_blabla_project/screens/rides/widgets/ride_pref_bar.dart';
import '../../model/ride/ride.dart';
import '../../model/ride_pref/ride_pref.dart';
import '../../service/rides_service.dart';
import '../../theme/theme.dart';

import 'widgets/rides_tile.dart';
import 'widgets/ride_pref_modal.dart'; // Import RidePrefModal

/// The Ride Selection screen allows users to select a ride once preferences are defined.
/// It also allows them to update preferences and activate filters.
class RidesScreen extends StatefulWidget {
  const RidesScreen({super.key});

  @override
  State<RidesScreen> createState() => _RidesScreenState();
}

class _RidesScreenState extends State<RidesScreen> {
  late RidePreference currentPreference;

  @override
  void initState() {
    super.initState();
    // TODO 1: Get initial preference from the service instead of using fake data
    currentPreference = RidesService.instance.getCurrentPreference();
  }

  List<Ride> get matchingRides {
    // Fetching rides using the RidesService singleton
    return RidesService.instance.getRides(currentPreference, RidesFilter(acceptPets: false));
  }

  void onBackPressed() {
    Navigator.of(context).pop(); // Navigate back to the previous screen
  }

  void onPreferencePressed() async {
    // TODO 6: Push the modal with the current preference
    final newPreference = await Navigator.push<RidePreference>(
      context,
      MaterialPageRoute(
        builder: (context) => RidePrefModal(currentPreference: currentPreference),
      ),
    );

    if (newPreference != null) {
      // TODO 9: After pop, update the new preference
      setState(() {
        currentPreference = newPreference;
      });

      // TODO 10: Update the service with the new preference and refresh rides
      RidesService.instance.setCurrentPreference(newPreference);
    }
  }

  void onFilterPressed() {
    // Future feature: Handle filter logic
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(
            left: BlaSpacings.m, right: BlaSpacings.m, top: BlaSpacings.s),
        child: Column(
          children: [
            // Top search bar
            RidePrefBar(
              ridePreference: currentPreference,
              onBackPressed: onBackPressed,
              onPreferencePressed: onPreferencePressed,
              onFilterPressed: onFilterPressed,
            ),

            Expanded(
              child: ListView.builder(
                itemCount: matchingRides.length,
                itemBuilder: (ctx, index) => RideTile(
                  ride: matchingRides[index],
                  onPressed: () {},
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
