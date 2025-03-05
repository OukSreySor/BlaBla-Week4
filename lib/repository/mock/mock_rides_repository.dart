import 'package:week_3_blabla_project/repository/mock/rides_repository.dart';

import '../../model/ride/locations.dart';
import '../../model/ride/ride.dart';
import '../../model/ride_pref/ride_pref.dart';
import '../../model/user/user.dart';
import '../../service/rides_service.dart';

class MockRidesRepository extends RidesRepository{

  final List<Ride> _rides = [
    Ride(
      departureLocation: Location(name: "Battambang", country: Country.cambodia),
      departureDate: DateTime.now(),
      arrivalLocation: Location(name: "SiemReap", country: Country.cambodia),
      arrivalDateTime: DateTime.now().add(Duration(hours: 2)),
      driver: User(firstName: "Kannika", lastName: "Phat", email: "kannika@bla.com", phone: "1234567890", profilePicture: "", verifiedProfile: true),
      availableSeats: 2,
      pricePerSeat: 20.0,
      acceptPets: false,  // Added pet acceptance
    ),
    Ride(
      departureLocation: Location(name: "Battambang", country: Country.cambodia),
      departureDate: DateTime.now().add(Duration(hours: 12)),
      arrivalLocation: Location(name: "SiemReap", country: Country.cambodia),
      arrivalDateTime: DateTime.now().add(Duration(hours: 14)),
      driver: User(firstName: "Chaylim", lastName: "Lim", email: "chaylim@bla.com", phone: "1234567890", profilePicture: "", verifiedProfile: true),
      availableSeats: 0,
      pricePerSeat: 20.0,
      acceptPets: false,
    ),
    Ride(
      departureLocation: Location(name: "Battambang", country: Country.cambodia),
      departureDate: DateTime.now().subtract(Duration(hours: 1)),
      arrivalLocation: Location(name: "SiemReap", country: Country.cambodia),
      arrivalDateTime: DateTime.now().add(Duration(hours: 2)),
      driver: User(firstName: "Mengtech", lastName: "Sok", email: "mengtech@bla.com", phone: "1234567890", profilePicture: "", verifiedProfile: true),
      availableSeats: 1,
      pricePerSeat: 20.0,
      acceptPets: false,
    ),
    Ride(
      departureLocation: Location(name: "Battambang", country: Country.cambodia),
      departureDate: DateTime.now().add(Duration(hours: 12)),
      arrivalLocation: Location(name: "SiemReap", country: Country.cambodia),
      arrivalDateTime: DateTime.now().add(Duration(hours: 14)),
      driver: User(firstName: "Limhao", lastName: "Phan", email: "limhao@bla.com", phone: "1234567890", profilePicture: "", verifiedProfile: true),
      availableSeats: 2,
      pricePerSeat: 20.0,
      acceptPets: true,  // Added pet acceptance
    ),
    Ride(
      departureLocation: Location(name: "Battambang", country: Country.cambodia),
      departureDate: DateTime.now().subtract(Duration(hours: 1)),
      arrivalLocation: Location(name: "SiemReap", country: Country.cambodia),
      arrivalDateTime: DateTime.now().add(Duration(hours: 2)),
      driver: User(firstName: "Sovanda", lastName: "Vann", email: "sovanda@bla.com", phone: "1234567890", profilePicture: "", verifiedProfile: true),
      availableSeats: 1,
      pricePerSeat: 20.0,
      acceptPets: false,
    ),
  ];

   @override
  List<Ride> getRides(RidePreference preference, RidesFilter? filter) {
    List<Ride> filteredRides = _rides;

    // Apply filtering by departure location, arrival location, and requested seats
    filteredRides = filteredRides.where((ride) {
      return ride.departureLocation.name == preference.departure.name &&
          ride.arrivalLocation.name == preference.arrival.name &&
          ride.departureDate.isAfter(preference.departureDate) &&  
          ride.availableSeats >= preference.requestedSeats;
    }).toList();

    // Apply filtering by pet acceptance
    if (filter != null) {
      filteredRides = filteredRides.where((ride) => ride.acceptPets == filter.acceptPets).toList();
    }

    return filteredRides;
  }
}