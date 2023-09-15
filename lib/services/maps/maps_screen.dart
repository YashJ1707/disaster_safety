import 'package:disaster_safety/services/geolocator.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapsScreen extends StatefulWidget {
  const MapsScreen({super.key});

  @override
  State<MapsScreen> createState() => MapsScreenState();
}

class MapsScreenState extends State<MapsScreen> {
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
      markerId: const MarkerId("Your Location"),
      position: location,
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueCyan),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: loading == true
          ? const Center(child: CircularProgressIndicator())
          : GoogleMap(
              initialCameraPosition: CameraPosition(
                target: LatLng(_position.latitude, _position.longitude),
                zoom: 15,
              ),
              markers: markers,
            ),
    );
  }
}
