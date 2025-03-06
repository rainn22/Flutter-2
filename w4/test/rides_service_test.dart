import 'package:week_3_blabla_project/model/ride/locations.dart';
import 'package:week_3_blabla_project/model/ride_pref/ride_pref.dart';
import 'package:week_3_blabla_project/repository/mock/mock_rides_repository.dart';
import 'package:week_3_blabla_project/service/rides_service.dart';
import 'package:week_3_blabla_project/utils/date_time_util.dart';

void main() {
  RidesService.initialize(MockRidesRepository());

  final preference = RidePreference(
    departure: Location(name: "Battambang", country: Country.kh),
    arrival: Location(name: "Siem Reap", country: Country.kh),
    departureDate: DateTime.now(),
    requestedSeats: 1,
  );

  // Without filter (all rides)
  displayResults(preference);

  // With filter (only pet-friendly rides)
  displayResults(preference, RidesFilter(acceptPets: true));
}

void displayResults(RidePreference preference, [RidesFilter? filter]) {
  final results = RidesService.instance.repository
      .getRides(preference, filter)
      .where((ride) => ride.availableSeats >= preference.requestedSeats)
      .toList();

  print(
      'For your preference (${preference.departure.name} -> ${preference.arrival.name}, today ${preference.requestedSeats} passenger)');
  print('We found ${results.length} rides:');

  for (final ride in results) {
    final duration = ride.arrivalDateTime.difference(ride.departureDate);
    print('- at ${DateTimeUtils.formatTime(ride.departureDate)} '
        '\twith ${ride.driver.firstName} '
        '(${duration.inHours} hours)');

      if (ride.availableSeats == 0) {
      print('Warning: This ride is full!');
    }
  }
}
