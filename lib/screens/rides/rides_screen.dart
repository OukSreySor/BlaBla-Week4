import 'package:flutter/material.dart';
import '../../dummy_data/dummy_data.dart';
import '../../model/ride/ride.dart';
import '../../model/ride_pref/ride_pref.dart';
import '../../service/ride_prefs_service.dart';
import '../../service/rides_service.dart';
import '../../theme/theme.dart';
import 'widgets/ride_pref_bar.dart';
import 'widgets/ride_pref_modal.dart';
import 'widgets/rides_tile.dart';

///
///  The Ride Selection screen allow user to select a ride, once ride preferences have been defined.
///  The screen also allow user to re-define the ride preferences and to activate some filters.
///
class RidesScreen extends StatefulWidget {
  const RidesScreen({super.key});

  @override
  State<RidesScreen> createState() => _RidesScreenState();
}

class _RidesScreenState extends State<RidesScreen> {
  late RidePreference currentPreference;
  @override
  void initState() {
    super.initState();

   // Get the latest preference from RidePrefService
    currentPreference = RidePrefService.instance.currentPreference ?? fakeRidePrefs[0]; 
  }

  //RidePreference currentPreference  = fakeRidePrefs[0];   // TODO 1 :  We should get it from the service

  List<Ride> get matchingRides => RidesService.getRidesForCurrentPreference();

  void onBackPressed() {
    Navigator.of(context).pop();     //  Back to the previous view
  } 

  void onPreferencePressed() async {
        // TODO  6 : we should push the modal with the current pref

        // TODO 9 :  After pop, we should get the new current pref from the modal 

        // TODO 10 :  Then we should update the service current pref,   and update the view

    // Show the RidePrefModal and pass the current preference
    RidePreference? updatedPreference = await showDialog<RidePreference>(
      context: context,
      builder: (BuildContext context) {
        return RidePrefModal(currentPreference: currentPreference); 
      },
    );

    if (updatedPreference != null) {
      // Update the state with the new preference 
      setState(() {
        currentPreference = updatedPreference;
        // Ensure the service is updated so other screens also get the correct data
        RidePrefService.instance.setCurrentPreference(updatedPreference);
      });
    }
  }
   
  void onFilterPressed() {
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.only(
          left: BlaSpacings.m, right: BlaSpacings.m, top: BlaSpacings.s),
      child: Column(
        children: [
          // Top search Search bar
          RidePrefBar(
              ridePreference: currentPreference,
              onBackPressed: onBackPressed,
              onPreferencePressed: onPreferencePressed,
              onFilterPressed: onFilterPressed),

          Expanded(
            child: ListView.builder(
              itemCount: matchingRides.length,
              itemBuilder: (ctx, index) => RideTile(
                ride: matchingRides[index],
                onPressed: () {},
              ),
            ),
          ),
        ],
      ),
    ));
  }
}
