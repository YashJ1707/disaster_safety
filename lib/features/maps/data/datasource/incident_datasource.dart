import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:disaster_safety/core/error/exception.dart';
import 'package:disaster_safety/features/maps/DTO/register_incident_DTO.dart';
import 'package:disaster_safety/features/maps/data/models/incident_model.dart';
import 'package:disaster_safety/models/map_enums.dart';
import 'package:geoflutterfire_plus/geoflutterfire_plus.dart';

abstract class IncidentDatasource {
  Future<void> createIncident({required RegisterIncidentDTO dto});

  Future<bool> verifyNearbyIncidentAlreadyExists(
      {required IncidentType incidentType,
      required double longitude,
      required double latitude});

  Future<void> confirmIncident(
      {required String userId, required String incidentId});

  Future<void> closeIncident({required String incidentId});

  Future<List<IncidentModel>> getNearbyIncidents(
      {required double longitude,
      required double latitude,
      required double radius});

  Future<List<IncidentModel>> getIncidentsForState({required String state});

  Future<List<IncidentModel>> getPendingIncidentsForState(
      {required String state});

  Future<List<IncidentModel>> getAllPendingIncidents();
}

//implementation
class IncidentDatasourceImpl implements IncidentDatasource {
  final CollectionReference<Map<String, dynamic>> incidentRef =
      FirebaseFirestore.instance.collection("incident");

  @override
  Future<void> closeIncident({required String incidentId}) {
    // TODO: implement closeIncident
    throw UnimplementedError();
  }

  @override
  Future<void> confirmIncident(
      {required String userId, required String incidentId}) async {
    try {
      await incidentRef
          .doc(incidentId)
          .update({'is_approved': true, 'approved_by': userId});
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<void> createIncident({required RegisterIncidentDTO dto}) async {
    try {
      final GeoFirePoint geoFirePoint =
          GeoFirePoint(GeoPoint(dto.latitude, dto.longitude));

      final IncidentModel newIncident = IncidentModel(null,
          geohash: geoFirePoint.data['geohash'],
          id: "id",
          incidentType: dto.incidentType,
          incidentPriority: dto.incidentPriority,
          reportedDate: DateTime.now(),
          longitude: dto.longitude,
          latitude: dto.latitude,
          description: dto.description,
          reportedBy: dto.userId,
          isApproved: false,
          imgpath: dto.imgPath,
          isOpen: true,
          closureDate: null,
          state: dto.state);
      await incidentRef.add(newIncident.toJson()).then((value) => {
            incidentRef.doc(value.id).update({'id': value.id}),
          });
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<List<IncidentModel>> getAllPendingIncidents() async {
    try {
      QuerySnapshot<Object?> snapshot = await incidentRef
          .where('is_approved', isEqualTo: false)
          .where('is_open', isEqualTo: 'true')
          .get();

      if (snapshot.docs.isNotEmpty) {
        return snapshot.docs
            .map(
                (e) => IncidentModel.fromJson(e.data() as Map<String, dynamic>))
            .toList();
      } else {
        return [];
      }
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<List<IncidentModel>> getIncidentsForState(
      {required String state}) async {
    try {
      QuerySnapshot<Object?> snapshot = await incidentRef
          .where('is_approved', isEqualTo: true)
          .where('state', isEqualTo: state)
          .get();

      if (snapshot.docs.isNotEmpty) {
        return snapshot.docs
            .map(
                (e) => IncidentModel.fromJson(e.data() as Map<String, dynamic>))
            .toList();
      } else {
        return [];
      }
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<List<IncidentModel>> getNearbyIncidents(
      {required double longitude,
      required double latitude,
      required double radius}) async {
    try {
      final currentGeoPoint = GeoPoint(latitude, longitude);

      final GeoFirePoint center = GeoFirePoint(currentGeoPoint);

      final Stream<List<DocumentSnapshot<Map<String, dynamic>>>> stream =
          await GeoCollectionReference<Map<String, dynamic>>(incidentRef)
              .subscribeWithin(
        center: center,
        radiusInKm: radius,
        field: 'geohash',
        geopointFrom: geopointFrom,
      );
      stream.first.then((value) {
        if (value.isNotEmpty) {
          return value.map(
              (e) => IncidentModel.fromJson(e.data() as Map<String, dynamic>));
        }
      });
      return [];
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  GeoPoint geopointFrom(Map<String, dynamic> data) =>
      GeoPoint(data['latitude'], data['longitude']);

  @override
  Future<List<IncidentModel>> getPendingIncidentsForState(
      {required String state}) async {
    try {
      QuerySnapshot<Object?> snapshot = await incidentRef
          .where('is_approved', isEqualTo: false)
          .where('is_open', isEqualTo: true)
          .where('state', isEqualTo: state)
          .get();

      if (snapshot.docs.isNotEmpty) {
        return snapshot.docs
            .map(
                (e) => IncidentModel.fromJson(e.data() as Map<String, dynamic>))
            .toList();
      } else {
        return [];
      }
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<bool> verifyNearbyIncidentAlreadyExists(
      {required IncidentType incidentType,
      required double longitude,
      required double latitude}) async {
    try {
      final currentGeoPoint = GeoPoint(latitude, longitude);

      final GeoFirePoint center = GeoFirePoint(currentGeoPoint);

      final Stream<List<DocumentSnapshot<Map<String, dynamic>>>> stream =
          await GeoCollectionReference<Map<String, dynamic>>(incidentRef)
              .subscribeWithin(
        center: center,
        radiusInKm: 2,
        field: 'geohash',
        geopointFrom: geopointFrom,
      );
      stream.first.then((value) {
        if (value.isNotEmpty) {
          return true;
        } else
          return false;
      });
      print("reached wrong side of code in verifynearby incidents");
      return false;
    } catch (e) {
      throw MapException(message: e.toString());
    }
  }
}
