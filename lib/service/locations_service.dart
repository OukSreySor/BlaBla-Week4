

import '../dummy_data/dummy_data.dart';
import '../model/ride/locations.dart';
import '../repository/mock/locations_repository.dart';

////
///   This service handles:
///   - The list of available rides
///
class LocationsService {
  static LocationsService? _instance;
  final LocationsRepository repository;

  // Private constructor
  LocationsService._internal(this.repository);

  // Singleton instance
  static LocationsService get instance {
    if (_instance == null) {
      throw Exception("You should initialize the service first.");
    }
    return _instance!;
  }

  // Initialize the Singleton
  static void initialize(LocationsRepository repository) {
    if (_instance == null) {
      _instance = LocationsService._internal(repository);
    }
  }

  List<Location> getLocations() {
    return repository.getLocations();
  }
  static const List<Location> availableLocations = fakeLocations; 
 
}