import 'dart:ffi';
import 'dart:ui' as ui;

import 'package:disaster_safety/models/incident_model.dart';
import 'package:disaster_safety/services/db.dart';
import 'package:disaster_safety/services/geolocator.dart';
import 'package:disaster_safety/shared/dropdown.dart';
import 'package:disaster_safety/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapsScreen extends StatefulWidget {
  const MapsScreen({super.key});
  // final List<Incident> incidents;
  @override
  State<MapsScreen> createState() => MapsScreenState();
}

final List<DisasterType> disasterTypes = [
  DisasterType(name: "All", icon: Icons.info_outline),
  DisasterType(name: 'Earthquake', icon: Icons.location_on),
  DisasterType(name: 'Flood', icon: Icons.water_damage),
  DisasterType(name: 'Wildfire', icon: Icons.fireplace),
  DisasterType(name: "Landslide", icon: Icons.landslide),
  DisasterType(name: 'Tsunami', icon: Icons.water_damage),
];
DisasterType selectedDisasterType = disasterTypes.first;

class MapsScreenState extends State<MapsScreen> {
  List<String> incidentTypes = [
    "all",
    "flood",
    "earthquake",
    "landslide",
    "tsunami"
  ];
  String selectedIncident = "all";
  Set<Marker> markers = {};
  late LatLng location;
  bool loading = true;
  List<Incident> incidents = [];
  @override
  void initState() {
    super.initState();

    LocationServices().getCurrentLocation().then((value) {
      setState(() {
        location = LatLng(value.latitude, value.longitude);
        loading = false;
        Marker marker1 = addYourLocationMarker();
        markers.add(marker1);
      });
    });

    DbMethods().getIncidents().then((value) => {
          print(value),
          setState(
            () {
              incidents = value;
            },
          ),
          getMarkers(incidents, "all").then(
            (value) {
              setState(() {
                markers.addAll(value);
              });
            },
          ),
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
    // _controller.
    return Scaffold(
      body: loading == true
          ? Center(child: Loadings.staticLoader())
          : GoogleMap(
              initialCameraPosition: CameraPosition(
                target: location,
                zoom: 15,
              ),
              markers: markers,
            ),
      floatingActionButton: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          boxShadow: [
            const BoxShadow(
                blurRadius: 10, offset: Offset(0, 3), color: Colors.black45)
          ],
        ),
        width: 155,
        child: DropdownButton<DisasterType>(
          hint: Text(selectedDisasterType.name),
          value: selectedDisasterType,
          onChanged: (DisasterType? newValue) async {
            setState(() {
              selectedDisasterType = newValue!;
            });
            Set<Marker> mrkr =
                await getMarkers(incidents, selectedDisasterType.name);
            mrkr.add(addYourLocationMarker());
            setState(() {
              markers = mrkr;
            });
          },
          items: disasterTypes.map((DisasterType disasterType) {
            return DropdownMenuItem<DisasterType>(
              value: disasterType,
              child: Row(
                children: [
                  Icon(disasterType.icon),
                  const SizedBox(width: 8.0),
                  Text(disasterType.name),
                ],
              ),
            );
          }).toList(),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
    );
  }
}

Future<Uint8List> getBytesFromAsset(String path, int width) async {
  ByteData data = await rootBundle.load(path);
  ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
      targetWidth: width);
  ui.FrameInfo fi = await codec.getNextFrame();
  return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
      .buffer
      .asUint8List();
}

Future<Set<Marker>> getMarkers(
    List<Incident> incidents, String disaster) async {
  Set<Marker> markers = {};
  for (Incident incident in incidents) {
    if (!incident.isApproved ||
        !incident.isOpen ||
        (incident.incidentType != disaster.toLowerCase() &&
            disaster.toLowerCase() != "all")) continue;
    Marker m = Marker(
      icon: await getIcon(incident.incidentType),
      markerId: MarkerId(incident.latitude.toString()),
      position: LatLng(incident.latitude, incident.longitude),
      infoWindow: InfoWindow(
          title: "Test",
          snippet:
              "Reported By: \nReported On: ${incident.reportedDate.toUtc()}",
          onTap: () {}),
    );
    markers.add(m);
  }
  return markers;
}

Future<BitmapDescriptor> getByteIcon(String asset) async {
  return BitmapDescriptor.fromBytes(
      await getBytesFromAsset("assets/$asset", 90));
}

Future<BitmapDescriptor> getIcon(String incident) async {
  switch (incident) {
    case "flood" || "tsunami":
      return await getByteIcon("wave.png");
    case "earthquake":
      return await getByteIcon("earthquake.png");
    case "landslide":
      return await getByteIcon("landslide.png");
    case "forestfire":
      return await getByteIcon("forestfire.png");
    default:
      return BitmapDescriptor.defaultMarker;
  }
}

class DisasterType {
  final String name;
  final IconData icon;

  DisasterType({
    required this.name,
    required this.icon,
  });
}
