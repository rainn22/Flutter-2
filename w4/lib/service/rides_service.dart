import 'package:week_3_blabla_project/model/ride_pref/ride_pref.dart';
import 'package:week_3_blabla_project/repository/mock/mock_rides_repository.dart';
import 'package:week_3_blabla_project/repository/rides_repository.dart';
import '../model/ride/ride.dart';

/// This service handles:
/// - The list of available rides
class RidesService {
  static final RidesService _instance = RidesService._internal();
  late RidesRepository _repository;

  // Private constructor
  RidesService._internal();

  // Singleton getter
  factory RidesService() {
    return _instance;
  }

  // Method to initialize repository
  void init(RidesRepository repository) {
    _repository = repository;
  }

  // Fetch rides based on preference and filter
  List<Ride> getRides(RidePreference preference, RidesFilter? filter) {
    return _repository.getRides(preference, filter);
  }

  static void initialize(MockRidesRepository mockRidesRepository) {}
}

class RidesFilter {
  final bool acceptPets;

  RidesFilter({required this.acceptPets});
}