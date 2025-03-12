import 'package:week_3_blabla_project/EXERCISE-1/model/ride/ride_pref.dart';

abstract class RidePreferencesListener {
  void onPreferenceSelected(RidePreference selectedPreference);
}

class ConsoleLogger implements RidePreferencesListener {
  @override
  void onPreferenceSelected(RidePreference selectedPreference) {
    print("Preference changed: ${selectedPreference}");
  }
}


