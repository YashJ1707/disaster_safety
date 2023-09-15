import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapsScreen extends StatefulWidget {
  const MapsScreen({super.key});

  @override
  State<MapsScreen> createState() => _MapsScreenState();
}

class _MapsScreenState extends State<MapsScreen> {
  @override
  final Set<Marker> markers = Set();
  late GoogleMapController mapController;

  @override
  void initState() {
    super.initState();

    markers.add(
      Marker(
        markerId: MarkerId('customMarker'),
        position: LatLng(37.7749,
            -122.4194), // Replace with your custom longitude and latitude
        infoWindow: InfoWindow(
          title: 'Custom Marker Title',
          snippet: 'Custom Marker Snippet',
        ),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(37.7749, -122.4194), // Set initial map center
          zoom: 12.0, // Adjust the initial zoom level
        ),
        markers: markers,
        // markers: markers,
        onMapCreated: (GoogleMapController controller) {
          mapController = controller;
        },
      ),
    );
  }
}
