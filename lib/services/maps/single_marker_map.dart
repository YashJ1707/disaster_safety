import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class SingleMarkerMap extends StatefulWidget {
  const SingleMarkerMap({super.key, required this.location});
  final LatLng location;

  @override
  State<SingleMarkerMap> createState() => _SingleMarkerMapState();
}

class _SingleMarkerMapState extends State<SingleMarkerMap> {
  Set<Marker> marker = {};
  @override
  void initState() {
    super.initState();
    marker.add(Marker(
        markerId: const MarkerId("Id"),
        position: widget.location,
        icon: BitmapDescriptor.defaultMarker));
  }

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      zoomControlsEnabled: false,
      initialCameraPosition: CameraPosition(
        target: widget.location,
        zoom: 15,
      ),
      markers: marker,
    );
  }
}
