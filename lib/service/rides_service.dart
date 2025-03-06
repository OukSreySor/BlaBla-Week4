

import '../dummy_data/dummy_data.dart';
import '../model/ride/ride.dart';
import '../model/ride_pref/ride_pref.dart';
import '../repository/mock/rides_repository.dart';
import 'ride_prefs_service.dart';

////
///   This service handles:
///   - The list of available rides
///
class RidesService {

  static RidesService? _instance;
  final RidesRepository repository;

  // Private constructor
  RidesService._internal(this.repository);

  // Singleton instance
  static RidesService get instance {
    if (_instance == null) {
      throw Exception("You should initialize the service first.");
    }
    return _instance!;
  }

  // Initialize the Singleton with any RidesRepository
  static void initialize(RidesRepository repository) {
    if (_instance == null) {
      _instance = RidesService._internal(repository);
    }
  }

  // Fetch rides with filter for pet acceptance
  List<Ride> getRides(RidePreference preference, RidesFilter? filter) {
    List<Ride> rides = repository.getRides(preference, filter);
    return rides;
  }

  
  // Update RidesService to use RidePrefService
  static List<Ride> availableRides = fakeRides;  
  static List<Ride> getRidesForCurrentPreference() {
    // Get the current preference from RidePrefService
    RidePreference? preferences = RidePrefService.instance.currentPreference;
    if (preferences == null) return [];

    return availableRides.where((ride) =>
        ride.departureLocation == preferences.departure &&
        ride.arrivalLocation == preferences.arrival).toList();
  }


}

class RidesFilter {
  final bool acceptPets;

  RidesFilter({required this.acceptPets});
}