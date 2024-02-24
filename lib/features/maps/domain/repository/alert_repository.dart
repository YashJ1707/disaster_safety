import 'package:dartz/dartz.dart';
import 'package:disaster_safety/core/error/failure.dart';
import 'package:disaster_safety/features/maps/DTO/create_alert_DTO.dart';
import 'package:disaster_safety/features/maps/data/models/alert_model.dart';

abstract class AlertRepository {
  Future<Either<Failure, List<AlertModel>>> getAlertsForUser(
      {required String state});
  Future<Either<Failure, void>> createAlert({required CreateAlertDTO dto});
  Future<Either<Failure, List<AlertModel>>> getAllAlerts({required});
}
