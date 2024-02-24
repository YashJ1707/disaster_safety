import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:disaster_safety/core/error/exception.dart';
import 'package:disaster_safety/features/maps/DTO/create_alert_DTO.dart';
import 'package:disaster_safety/features/maps/data/models/alert_model.dart';

abstract class AlertDatasource {
  Future<void> createAlert({required CreateAlertDTO dto});
  Future<List<AlertModel>> getNearbyAlertsForUser({required String state});
  Future<List<AlertModel>> getAllAlerts();
}

class AlertDatasourceImpl implements AlertDatasource {
  final CollectionReference<Map<String, dynamic>> alertRef =
      FirebaseFirestore.instance.collection("alerts");

  @override
  Future<void> createAlert({required CreateAlertDTO dto}) async {
    try {
      final AlertModel alert = AlertModel(
          id: "id",
          title: dto.title,
          subtitle: dto.subtitle,
          tag: dto.tag,
          latitude: dto.latitude,
          longitude: dto.longitude);
      await alertRef.add(alert.toJson()).then((value) => {
            alertRef.doc(value.id).update({'id': value.id}),
          });
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<List<AlertModel>> getAllAlerts() async {
    try {
      QuerySnapshot<Object?> snapshot = await alertRef.get();

      if (snapshot.docs.isNotEmpty) {
        return snapshot.docs
            .map((e) => AlertModel.fromJson(e.data() as Map<String, dynamic>))
            .toList();
      } else {
        return [];
      }
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<List<AlertModel>> getNearbyAlertsForUser(
      {required String state}) async {
    try {
      QuerySnapshot<Object?> snapshot =
          await alertRef.where('state', isEqualTo: state).get();

      if (snapshot.docs.isNotEmpty) {
        return snapshot.docs
            .map((e) => AlertModel.fromJson(e.data() as Map<String, dynamic>))
            .toList();
      } else {
        return [];
      }
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }
}
