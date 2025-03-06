import 'package:flutter/material.dart';
import 'package:week_3_blabla_project/screens/rides/widgets/filter_dialog.dart';
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
  String sortBy = 'Earliest departure'; // Default sorting option
  bool petsAccepted = false; // Default pet acceptance

  @override
  void initState() {
    super.initState();
    // Fetch initial preference from the service
    currentPreference = RidesService.instance.getCurrentPreference();
  }

  // Get matching rides based on current preference and filter
  List<Ride> get matchingRides {
    return RidesService.instance.getRides(
      currentPreference,
      RidesFilter(acceptPets: petsAccepted), // Use the filter with pets acceptance
      sortBy == 'Earliest departure' ? RideSortType.earliestDeparture : RideSortType.earliestDeparture, // Add more sorting options if needed
    );
  }

  void onBackPressed() {
    Navigator.of(context).pop(); // Navigate back to the previous screen
  }

  void onPreferencePressed() async {
    // Push the modal with the current preference
    final newPreference = await Navigator.push<RidePreference>(
      context,
      MaterialPageRoute(
        builder: (context) => RidePrefModal(currentPreference: currentPreference),
      ),
    );

    if (newPreference != null) {
      // Update the new preference
      setState(() {
        currentPreference = newPreference;
      });

      // Update the service with the new preference
      RidesService.instance.setCurrentPreference(newPreference);
    }
  }

  void onFilterPressed() {
    showDialog(
      context: context,
      builder: (context) {
        return FilterDialog(
          onApply: (String selectedSort, bool petsAccepted) {
            setState(() {
              sortBy = selectedSort;
              this.petsAccepted = petsAccepted;
            });
          },
        );
      },
    );
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
                  onPressed: () {
                    // Handle ride selection
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}