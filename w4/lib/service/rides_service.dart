import 'package:week_3_blabla_project/dummy_data/dummy_data.dart';
import 'package:week_3_blabla_project/model/ride_pref/ride_pref.dart';
import 'package:week_3_blabla_project/repository/rides_repository.dart';
import '../model/ride/ride.dart';

class RidesService {
  static List<Ride> availableRides = fakeRides;

  static RidesService? _instance;

  final RidesRepository repository;
  RidePreference _currentPreference = fakeRidePrefs[0]; // Default value

  RidesService._internal(this.repository);

  static void initialize(RidesRepository repository) {
    if (_instance == null) {
      _instance = RidesService._internal(repository);
    } else {
      throw Exception("The Ride service is already initialized.");
    }
  }

  static RidesService get instance {
    if (_instance == null) {
      throw Exception("RideService is not initialized. Call initialize() first.");
    }
    return _instance!;
  }

  List<Ride> getRides(RidePreference preferences, RidesFilter filter, RideSortType sortType) {
    // Fetch rides from the repository
    List<Ride> rides = repository.getRides(preferences, filter);

    // Sort rides based on the specified sortType
    switch (sortType) {
      case RideSortType.earliestDeparture:
        rides.sort((a, b) => a.departureDate.compareTo(b.departureDate));
        break;
    }

    return rides;
  }

  RidePreference getCurrentPreference() {
    return _currentPreference;
  }

  void setCurrentPreference(RidePreference newPreference) {
    _currentPreference = newPreference;
  }
}

class RidesFilter {
  final bool acceptPets;

  RidesFilter({required this.acceptPets});
}

enum RideSortType {
  earliestDeparture,
}