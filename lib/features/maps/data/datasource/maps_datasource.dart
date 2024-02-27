import 'package:disaster_safety/features/maps/data/models/incident_model.dart';
import 'package:disaster_safety/features/maps/data/models/resource_model.dart';
import 'package:disaster_safety/models/map_enums.dart';
import 'package:disaster_safety/services/maps/complete_maps_screen.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

abstract class MapsDatasource {
  Future<String> getState(
      {required double longitude, required double latitude});

  Future<Position> determinePosition();

  Future<Set<Marker>> getMarkers(
      List<IncidentModel> incidents,
      List<ResourceModel> resources,
      IncidentType incidentType,
      IncidentPriority priority,
      ResourceType resourceType);
}

class MapsDatasourceImpl implements MapsDatasource {
  @override
  Future<String> getState(
      {required double longitude, required double latitude}) {
    // TODO: implement getState
    throw UnimplementedError();
  }

  Future<Position> determinePosition() async {
    LocationPermission permission;
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        await Geolocator.openLocationSettings();
        return Future.error('Location permissions are denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      await Geolocator.openAppSettings();
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }

  @override
  Future<Set<Marker>> getMarkers(
      List<IncidentModel> incidents,
      List<ResourceModel> resources,
      IncidentType incidentType,
      IncidentPriority priority,
      ResourceType resourceType) async {
    Set<Marker> markers = {};

    //filter incidents
    incidents
        .where((element) =>
            (element.incidentType == incidentType ||
                element.incidentType == IncidentType.all) &&
            (element.incidentPriority == priority ||
                element.incidentPriority == IncidentPriority.all))
        .toList()
        .forEach((incident) async {
      final marker = await getMarker(
          latLng: LatLng(incident.latitude, incident.longitude),
          name: incident.incidentType.name);
      markers.add(marker);
    });

    //filter resources
    resources
        .where((element) =>
            element.resourceType == resourceType ||
            element.resourceType == ResourceType.all)
        .toList()
        .forEach((resource) async {
      final marker = await getMarker(
          latLng: LatLng(resource.latitude, resource.longitude),
          name: resource.resourceType.name);
      markers.add(marker);
    });

    return markers;
  }

  Future<BitmapDescriptor> getIcon(String incident) async {
    switch (incident) {
      case "flood":
      case "tsunami":
        return await getByteIcon("wave.png");
      case "earthquake":
        return await getByteIcon("earthquake.png");
      case "landslide":
        return await getByteIcon("landslide.png");
      case "wildfire":
        return await getByteIcon("wildfire.png");
      default:
        return BitmapDescriptor.defaultMarker;
    }
  }

  Future<Marker> getMarker(
      {required String name, required LatLng latLng}) async {
    return Marker(
      icon: await getIcon(name),
      markerId: MarkerId(latLng.latitude.toString()),
      position: LatLng(latLng.latitude, latLng.longitude),
      infoWindow: InfoWindow(
          title: name,
          onTap: () {
            //TODO: add navigation
            // Routes.push(context, IncidentInfo(incident: incident));
          }),
    );
  }
}
