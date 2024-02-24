import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:disaster_safety/core/error/exception.dart';
import 'package:disaster_safety/features/maps/DTO/register_resource_DTO.dart';
import 'package:disaster_safety/features/maps/data/models/resource_model.dart';
import 'package:disaster_safety/models/map_enums.dart';
import 'package:geoflutterfire_plus/geoflutterfire_plus.dart';

abstract class ResourceDatasource {
  Future<void> createResource({required RegisterResourceDTO dto});

  Future<bool> verifyNearbyResourceAlreadyExists(
      {required ResourceType resourceType,
      required double latitude,
      required double longitude});

  Future<List<ResourceModel>> getNearbyResource(
      {required double longitude,
      required double latitude,
      required double radius});

  Future<List<ResourceModel>> getResourcesForState({required String state});

  Future<void> removeResource({required String resourceId});

  Future<List<ResourceModel>> getAllResources();
}

class ResourceDatasourceImpl implements ResourceDatasource {
  final CollectionReference<Map<String, dynamic>> resourceRef =
      FirebaseFirestore.instance.collection("resource");

  @override
  Future<void> createResource({required RegisterResourceDTO dto}) async {
    try {
      final GeoFirePoint geoFirePoint =
          GeoFirePoint(GeoPoint(dto.latitude, dto.longitude));

      final ResourceModel resource = ResourceModel(
          name: dto.name,
          latitude: dto.latitude,
          longitude: dto.longitude,
          id: "id",
          resourceType: dto.resourceType,
          description: dto.description,
          geohash: geoFirePoint.data['geohash']);
      await resourceRef.add(resource.toJson()).then((value) => {
            resourceRef.doc(value.id).update({'id': value.id}),
          });
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<List<ResourceModel>> getAllResources() async {
    try {
      QuerySnapshot<Object?> snapshot = await resourceRef.get();

      if (snapshot.docs.isNotEmpty) {
        return snapshot.docs
            .map(
                (e) => ResourceModel.fromJson(e.data() as Map<String, dynamic>))
            .toList();
      } else {
        return [];
      }
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<List<ResourceModel>> getNearbyResource(
      {required double longitude,
      required double latitude,
      required double radius}) async {
    try {
      final currentGeoPoint = GeoPoint(latitude, longitude);

      final GeoFirePoint center = GeoFirePoint(currentGeoPoint);

      final Stream<List<DocumentSnapshot<Map<String, dynamic>>>> stream =
          await GeoCollectionReference<Map<String, dynamic>>(resourceRef)
              .subscribeWithin(
        center: center,
        radiusInKm: radius,
        field: 'geohash',
        geopointFrom: geopointFrom,
      );
      stream.first.then((value) {
        if (value.isNotEmpty) {
          return value.map(
              (e) => ResourceModel.fromJson(e.data() as Map<String, dynamic>));
        }
      });
      return [];
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<List<ResourceModel>> getResourcesForState(
      {required String state}) async {
    try {
      QuerySnapshot<Object?> snapshot =
          await resourceRef.where('state', isEqualTo: state).get();

      if (snapshot.docs.isNotEmpty) {
        return snapshot.docs
            .map(
                (e) => ResourceModel.fromJson(e.data() as Map<String, dynamic>))
            .toList();
      } else {
        return [];
      }
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<void> removeResource({required String resourceId}) async {
    try {
      final response =
          await resourceRef.where('id', isEqualTo: resourceId).get();

      if (response.docs.first.exists) {
        await response.docs.first.reference.delete();
      } else {
        throw DatabaseException("Resource does not exist");
      }
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<bool> verifyNearbyResourceAlreadyExists(
      {required ResourceType resourceType,
      required double latitude,
      required double longitude}) async {
    try {
      final currentGeoPoint = GeoPoint(latitude, longitude);

      final GeoFirePoint center = GeoFirePoint(currentGeoPoint);

      final Stream<List<DocumentSnapshot<Map<String, dynamic>>>> stream =
          await GeoCollectionReference<Map<String, dynamic>>(resourceRef)
              .subscribeWithin(
        center: center,
        radiusInKm: 1,
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

  GeoPoint geopointFrom(Map<String, dynamic> data) =>
      GeoPoint(data['latitude'], data['longitude']);
}
