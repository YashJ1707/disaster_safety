import 'package:dartz/dartz.dart';
import 'package:disaster_safety/core/error/failure.dart';
import 'package:disaster_safety/features/maps/DTO/create_alert_DTO.dart';
import 'package:disaster_safety/features/maps/data/datasource/alert_datasource.dart';
import 'package:disaster_safety/features/maps/data/models/alert_model.dart';
import 'package:disaster_safety/features/maps/domain/repository/alert_repository.dart';

class AlertRepositoryImpl implements AlertRepository {
  final AlertDatasourceImpl datasource = AlertDatasourceImpl();

  @override
  Future<Either<Failure, void>> createAlert(
      {required CreateAlertDTO dto}) async {
    try {
      await datasource.createAlert(dto: dto);
      return Right(());
    } catch (e) {
      return Left(DatabaseFailure(message: "Could not create alert"));
    }
  }

  @override
  Future<Either<Failure, List<AlertModel>>> getAlertsForUser(
      {required String state}) async {
    try {
      final alerts = await datasource.getNearbyAlertsForUser(state: state);
      return Right(alerts);
    } catch (e) {
      return Left(DatabaseFailure(message: "Could not get alerts"));
    }
  }

  @override
  Future<Either<Failure, List<AlertModel>>> getAllAlerts({required}) async {
    try {
      final alerts = await datasource.getAllAlerts();
      return Right(alerts);
    } catch (e) {
      return Left(DatabaseFailure(message: "Could not get alerts"));
    }
  }
}
