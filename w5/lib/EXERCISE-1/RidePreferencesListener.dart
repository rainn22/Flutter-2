import 'package:week_3_blabla_project/EXERCISE-1/model/ride/ride_pref.dart';

abstract class RidePreferencesListener {
  void onPreferenceSelected(RidePreference selectedPreference);
}

class RidepreferencesService {
  late RidePreference _ridePref;
  final List<Ridepreferenceslistener> _listeners = [];

  void addListener(Ridepreferenceslistener listener) {
    _listeners.add(listener);
  }

  void setRidePreference(RidePreference newRidePref) {
    _ridePref = newRidePref;
    _notifyListeners();
  }

  void _notifyListeners() {
    for (var listener in _listeners) {
      listener.onPreferencesSelection(_ridePref);
    }
  }
}

class ConsoleLogger implements RidePreferencesListener {
  @override
  void onPreferenceSelected(RidePreference selectedPreference) {
    print("Preference changed: ${selectedPreference}");
  }
}


