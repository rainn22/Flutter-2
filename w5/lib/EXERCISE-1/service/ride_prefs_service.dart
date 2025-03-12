import 'package:week_3_blabla_project/EXERCISE-1/RidePreferencesListener.dart';
import 'package:week_3_blabla_project/EXERCISE-1/model/ride/ride_pref.dart';
import 'package:week_3_blabla_project/EXERCISE-1/service/repository/ride_preferences_repository.dart';

class RidePrefService {
  static RidePrefService? _instance;
  final RidePreferencesRepository repository;
  RidePreference? _currentPreference;
  final List<RidePreferencesListener> _listeners = [];

  RidePrefService._internal(this.repository);

  static void initialize(RidePreferencesRepository repository) {
    if (_instance == null) {
      _instance = RidePrefService._internal(repository);
    } else {
      throw Exception("RidePreferencesService is already initialized.");
    }
  }

  static RidePrefService get instance {
    if (_instance == null) {
      throw Exception("RidePreferencesService is not initialized. Call initialize() first.");
    }
    return _instance!;
  }

  void addListener(RidePreferencesListener listener) {
    _listeners.add(listener);
  }

  void removeListener(RidePreferencesListener listener) {
    _listeners.remove(listener);
  }

  void _notifyListeners(RidePreference preference) {
    for (var listener in _listeners) {
      listener.onPreferenceSelected(preference);
    }
  }

  void setCurrentPreference(RidePreference preference) {
    _currentPreference = preference;
    print('Set current pref to $_currentPreference');
    _notifyListeners(preference);
  }

  RidePreference? get currentPreference => _currentPreference;
}
