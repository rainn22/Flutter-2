import '../../model/ride/ride_pref.dart';

abstract class RidePreferencesRepository {
  List<RidePreference> getPastPreferences();
  void addPreference(RidePreference preference);
}

class InMemoryRidePreferencesRepository implements RidePreferencesRepository {
  final List<RidePreference> _preferences = [];

  @override
  List<RidePreference> getPastPreferences() {
    return List.unmodifiable(_preferences);
  }

  @override
  void addPreference(RidePreference preference) {
    _preferences.add(preference);
    print("Added preference: $preference");
  }
}
