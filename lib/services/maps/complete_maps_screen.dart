import 'dart:ui' as ui;

import 'package:disaster_safety/models/incident_model.dart';
import 'package:disaster_safety/services/db.dart';
import 'package:disaster_safety/services/geolocator.dart';
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

class MapsScreenState extends State<MapsScreen> {
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
          getMarkers(incidents).then(
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

Future<Set<Marker>> getMarkers(List<Incident> incidents) async {
  Set<Marker> markers = {};
  for (Incident incident in incidents) {
    if (!incident.isApproved || !incident.isOpen) continue;
    Marker m = Marker(
      icon: await getIcon(incident.incidentType),
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

Future<BitmapDescriptor> getByteIcon(String asset) async {
  return BitmapDescriptor.fromBytes(
      await getBytesFromAsset("assets/" + asset, 90));
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
