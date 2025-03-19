import 'package:week_3_blabla_project/EXERCISE-1/RidePreferencesListener.dart';
import 'package:week_3_blabla_project/EXERCISE-1/service/ride_prefs_service.dart';
import 'package:week_3_blabla_project/EXERCISE-1/service/repository/ride_preferences_repository.dart';

void main() {
  RidepreferencesService ridepreferencesService = RidepreferencesService();
  ConsoleLogger consoleLogger = ConsoleLogger();

  RidePreference selectedPreference = RidePreference(
    departure: Location(name: "Phnom penh", country: Country.cambodia),
    arrival: Location(name: "Phnom penh", country: Country.cambodia),
    departureDate: DateTime.now(),
    requestedSeats: 2,
  );

  ridepreferencesService.addListener(consoleLogger);

  ridepreferencesService.setRidePreference(selectedPreference);
}