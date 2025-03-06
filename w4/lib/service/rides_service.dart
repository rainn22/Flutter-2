import 'package:week_3_blabla_project/dummy_data/dummy_data.dart';
import 'package:week_3_blabla_project/model/ride_pref/ride_pref.dart';
import 'package:week_3_blabla_project/repository/rides_repository.dart';
import '../model/ride/ride.dart';

/// This service handles:
/// - The list of available rides
class RidesService {
  static List<Ride> availableRides = fakeRides;

  static RidesService? _instance;

  final RidesRepository repository;

  RidesService._internal(this.repository);

  static void initialize(RidesRepository repository) {
    if (_instance == null) {
      _instance = RidesService._internal(repository);
    } else {
      throw Exception("The Ride is already initialized.");
    }
  }

  static RidesService get instance {
    if (_instance == null) {
      throw Exception(
          "RideService is not initialized. Call initialize() first.");
    }
    return _instance!;
  }

  List<Ride> getRides(RidePreference preferences, RidesFilter filter) {
    return repository.getRides(preferences, filter);
  }
}

class RidesFilter {
  final bool acceptPets;

  RidesFilter({required this.acceptPets});
}