
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/intl.dart';
import 'package:week_3_blabla_project/service/rides_service.dart';
import 'package:week_3_blabla_project/repository/mock/mock_rides_repository.dart';
import 'package:week_3_blabla_project/model/ride/ride.dart';
import 'package:week_3_blabla_project/model/ride_pref/ride_pref.dart';
import 'package:week_3_blabla_project/model/ride/locations.dart';


void main() {
  // Initialize the RidesService with the MockRidesRepository
  RidesService.initialize(MockRidesRepository());

  test('T1 - Create a ride preference from Battambang to SiemReap for today with 1 passenger', () {
    // Given a RidePreference
    RidePreference preference = RidePreference(
      departure: Location(name: "Battambang", country: Country.cambodia),
      arrival: Location(name: "SiemReap", country: Country.cambodia),
      departureDate: DateTime.now().copyWith(hour: 0, minute: 0, second: 0, millisecond: 0),
      requestedSeats: 1,
    );

    // Fetch the rides for the preference
    List<Ride> rides = RidesService.instance.getRides(preference, null);

    // Assert that 4 rides are found
    expect(rides.length, 4);

    // Check if any ride is full
    bool hasFullRides = rides.any((ride) => ride.availableSeats == 0);
    if (hasFullRides) {
      print("Warning: 1 ride is full!");
    }

    // Print the rides sorted from soonest to latest
    print('For your preference (Battambang -> SiemReap, today ${preference.requestedSeats} passenger) we found ${rides.length} ride(s):');
    rides.sort((a, b) => a.departureDate.compareTo(b.departureDate));
    for (var ride in rides) {
      Duration duration = ride.arrivalDateTime.difference(ride.departureDate);
      String formattedTime = DateFormat('h:mm a').format(ride.departureDate).toLowerCase();
      print('- at $formattedTime      with ${ride.driver.firstName}      (${duration.inHours} hours)');
    }
  });

  test('T2 - Create a ride preference with pet filter from Battambang to SiemReap', () {
    
    RidePreference preference = RidePreference(
      departure: Location(name: "Battambang", country: Country.cambodia),
      departureDate: DateTime.now(),  
      arrival: Location(name: "SiemReap", country: Country.cambodia),
      requestedSeats: 1,
    );

    // Create a filter for pet allowed
    RidesFilter filter = RidesFilter(acceptPets: true);

    List<Ride> rides = RidesService.instance.getRides(preference, filter);

    // Assert the expected result (1 ride with Mengtech)
    expect(rides.length, 1);
    expect(rides[0].driver.firstName, 'Mengtech');  
    print('Found ${rides.length} rides with pet allowed');
    rides.forEach((ride) {
      print('${ride.driver.firstName} at ${ride.departureDate}');
    });
  });
}
