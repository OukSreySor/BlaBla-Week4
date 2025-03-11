
import 'package:week_3_blabla_project/model/ride/ride_filter.dart';
import '../model/ride/ride.dart';
import '../model/ride_pref/ride_pref.dart';
import '../repository/mock/rides_repository.dart';


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
    } else {
      throw Exception("Rides Service is already initialized.");
    }
  }

  List<Ride> getRidesFor(RidePreference pref, RideFilter? filter) {
    return repository.getRidesFor(pref, filter);
  }

}

