import 'package:disaster_safety/screens/user/raise_incident.dart';
import 'package:disaster_safety/services/geolocator.dart';
import 'package:disaster_safety/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart' as places;

class RegisterDisasterScreen extends StatefulWidget {
  const RegisterDisasterScreen({super.key});

  @override
  State<RegisterDisasterScreen> createState() => RegisterDisasterScreenState();
}

class RegisterDisasterScreenState extends State<RegisterDisasterScreen> {
  final places.GoogleMapsPlaces _places =
      places.GoogleMapsPlaces(apiKey: "kGoogleApiKey");

  bool disabled = true;
  Set<Marker> markers = {};
  late Position _position;
  late LatLng location;
  bool loading = true;
  @override
  void initState() {
    super.initState();
    LocationServices().getCurrentLocation().then((value) {
      setState(() {
        _position = value;
        loading = false;
      });
      location = LatLng(_position.latitude, _position.longitude);
      Marker marker1 = addYourLocationMarker();
      markers.add(marker1);
    });
  }

  Marker addYourLocationMarker() {
    return Marker(
      markerId: const MarkerId("Register disaster"),
      position: location,
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
      draggable: true,
      onDragEnd: (value) {
        setState(() {
          location = LatLng(value.latitude, value.longitude);
          disabled = false;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController searchController = TextEditingController();
    return Scaffold(
      body: loading == true
          ? Center(child: Loadings.staticLoader())
          : Stack(
              // alignment: Alignment.bottomCenter,
              children: [
                GoogleMap(
                  initialCameraPosition: CameraPosition(
                    target: LatLng(_position.latitude, _position.longitude),
                    zoom: 15,
                  ),
                  markers: markers,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 60, horizontal: 20),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            boxShadow: const [
                              BoxShadow(
                                  color: Colors.black38,
                                  offset: Offset(0, 3),
                                  blurRadius: 10)
                            ],
                            color: Colors.white),
                        child: PlacesAutocompleteField(
                          apiKey: "AIzaSyAKfLk1_5MZWMTugH__e2u2YB-g6P8lgRQ",
                          controller: TextEditingController(),
                          onSelected: (place) {
                            print('Selected place: ${place.description}');
                          },
                          onChanged: (value) {
                            // Handle changes in the text field and perform search as the user types
                            if (value != null && value.length > 3) {
                              _performSearch(value);
                            }
                          },
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 70, vertical: 10),
                            shadowColor: Colors.black,
                            elevation: 6,
                            disabledForegroundColor: Colors.black,
                            disabledBackgroundColor:
                                const Color.fromARGB(255, 188, 184, 184),
                          ),
                          onPressed: disabled == true
                              ? null
                              : () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => RaiseIncidentPage(
                                          latitude: location.latitude,
                                          longitude: location.longitude)));
                                },
                          child: const Text("Confirm")),
                    ),
                  ],
                ),
              ],
            ),
    );
  }

  void _performSearch(String query) async {
    if (query.isNotEmpty) {
      final response = await _places.autocomplete(
        query,
        language: 'en', // Adjust as needed
      );

      if (response.isOkay) {
        // Handle the autocomplete suggestions (response.predictions)
      } else {
        // Handle error
      }
    }
  }
}
