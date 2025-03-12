import 'package:week_3_blabla_project/EXERCISE-1/RidePreferencesListener.dart';
import 'package:week_3_blabla_project/EXERCISE-1/service/ride_prefs_service.dart';
import 'package:week_3_blabla_project/EXERCISE-1/service/repository/ride_preferences_repository.dart';

void main() {
  var repository = InMemoryRidePreferencesRepository();
  RidePrefService.initialize(repository);
  var rideService = RidePrefService.instance;

  var logger = ConsoleLogger();
  rideService.addListener(logger);

  rideService.setCurrentPreference;
}
