
import '../../model/ride/locations.dart';
import '../locations_repository.dart';

class MockLocationsRepository extends LocationsRepository {
  final List<Location> _getLocations = [
    Location(name: "Phnom Penh", country: Country.kh),
    Location(name: "Siem Reap", country: Country.kh),
    Location(name: "Battambang", country: Country.kh),
    Location(name: "Sihanoukville", country: Country.kh),
    Location(name: "Kampot", country: Country.kh)
  ];

  @override
  List<Location> getLocations() {
    return _getLocations;
  }
}