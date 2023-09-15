import 'package:disaster_safety/models/incident_model.dart';
import 'package:disaster_safety/services/geolocator.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapsScreen extends StatefulWidget {
  const MapsScreen({super.key, required this.incidents});
  final List<Incident> incidents;
  @override
  State<MapsScreen> createState() => MapsScreenState();
}

class MapsScreenState extends State<MapsScreen> {
  Set<Marker> markers = {};
  late LatLng location;
  bool loading = true;
  @override
  void initState() {
    super.initState();
    setState(() {
      markers.addAll(getMarkers(widget.incidents));
    });
    LocationServices().getCurrentLocation().then((value) {
      setState(() {
        location = LatLng(value.latitude, value.longitude);
        loading = false;
        Marker marker1 = addYourLocationMarker();
        markers.add(marker1);
      });
    });
    // print(markers.length);
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
                target: location,
                zoom: 15,
              ),
              markers: markers,
            ),
    );
  }
}

Set<Marker> getMarkers(List<Incident> incidents) {
  Set<Marker> markers = {};
  for (Incident incident in incidents) {
    if (!incident.isApproved || !incident.isOpen) continue;
    Marker m = Marker(
      icon: BitmapDescriptor.defaultMarker,
      markerId: MarkerId(incident.latitude.toString()),
      position: LatLng(incident.latitude, incident.longitude),
      infoWindow: InfoWindow(
          title: "Test",
          snippet: "Reported By: \n" +
              "Reported On: " +
              incident.reportedDate.toUtc().toString(),
          onTap: () {}
          //TODO: Complete info window
          ),
    );
    markers.add(m);
  }
  return markers;
}
