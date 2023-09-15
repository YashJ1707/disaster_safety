import 'package:disaster_safety/screens/user/raise_incident.dart';
import 'package:disaster_safety/services/geolocator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class RegisterDisasterScreen extends StatefulWidget {
  const RegisterDisasterScreen({super.key});

  @override
  State<RegisterDisasterScreen> createState() => RegisterDisasterScreenState();
}

class RegisterDisasterScreenState extends State<RegisterDisasterScreen> {
  // GoogleMapsPlaces _places = GoogleMapsPlaces(apiKey: kGoogleApiKey);

  bool disabled = true;
  Set<Marker> markers = Set();
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
          ? const Center(child: CircularProgressIndicator())
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
                            // border: Border.all(color: Colors.black),
                            color: Colors.white),
                        // child: PlacesAutocompleteField(
                        //   apiKey: "AIzaSyAKfLk1_5MZWMTugH__e2u2YB-g6P8lgRQ",
                        //   language: "en",
                        //   // leading: Icon(Icons.search),
                        //   hint: "Search Here",

                        //   controller: searchController,
                        //   inputDecoration: const InputDecoration(
                        //     prefixIcon: Icon(Icons.search),
                        //     border: InputBorder.none,
                        //     // hintText: "Search Here",
                        //     // contentPadding: EdgeInsets.all(10),
                        //   ),
                        // ),
                        child: TextField(
                          controller: searchController,
                          decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.search),
                            border: InputBorder.none,
                            hintText: "Search Here",
                            // contentPadding: EdgeInsets.all(10),
                          ),
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
}
