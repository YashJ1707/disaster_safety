import 'package:disaster_safety/services/geolocator.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class RegisterDisasterScreen extends StatefulWidget {
  const RegisterDisasterScreen({super.key});

  @override
  State<RegisterDisasterScreen> createState() => RegisterDisasterScreenState();
}

class RegisterDisasterScreenState extends State<RegisterDisasterScreen> {
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
    return Scaffold(
      body: loading == true
          ? const Center(child: CircularProgressIndicator())
          : Stack(
              alignment: Alignment.bottomCenter,
              children: [
                GoogleMap(
                  initialCameraPosition: CameraPosition(
                    target: LatLng(_position.latitude, _position.longitude),
                    zoom: 15,
                  ),
                  markers: markers,
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
                            Color.fromARGB(255, 188, 184, 184),
                      ),
                      onPressed: disabled == true
                          ? null
                          : () {
                              //TODO: Navigate to disaster registration page
                            },
                      child: const Text("Confirm")),
                ),
              ],
            ),
    );
  }
}
