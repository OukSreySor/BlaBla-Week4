import 'package:flutter/material.dart';
import 'model/ride/locations.dart';
import 'model/ride/ride.dart';
import 'model/ride_pref/ride_pref.dart';
import 'repository/mock/mock_locations_repository.dart';
import 'repository/mock/mock_ride_preferences_repository.dart';
import 'repository/mock/mock_rides_repository.dart';
import 'screens/ride_pref/ride_pref_screen.dart';
import 'service/locations_service.dart';
import 'service/ride_prefs_service.dart';
import 'service/rides_service.dart';
import 'theme/theme.dart';

void main() {

  // 1 - Initialize the services
  RidePrefService.initialize(MockRidePreferencesRepository());

  // Initialize the LocationsService with MockLocationsRepository
  LocationsService.initialize(MockLocationsRepository());
  
  LocationsService service = LocationsService.instance;

  // Fetch locations
  List<Location> locations = service.getLocations();

  // Print the locations
  for (var location in locations) {
    print("City: ${location.name}, Country: ${location.country.name}");
  }

  // Initialize the RidesService with MockRidesRepository
  RidesService.initialize(MockRidesRepository());

  // Access the service instance
  RidesService service1 = RidesService.instance;

  // Define a RidePreference and a RidesFilter
  RidePreference preference = RidePreference(
    departure: Location(name: "Battambang", country: Country.cambodia),
    departureDate: DateTime.now().add(Duration(hours: 1)),
    arrival: Location(name: "SiemReap", country: Country.cambodia),
    requestedSeats: 1,
  );
  RidesFilter filter = RidesFilter(acceptPets: true);  

  // Fetch rides
  List<Ride> rides = service1.getRides(preference, filter);

  // Print the rides
  for (var ride in rides) {
    print(ride);
  }

  // 2- Run the UI
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: appTheme,
      home: Scaffold(body: RidePrefScreen()),
    );
  }
}
