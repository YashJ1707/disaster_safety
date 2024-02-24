import 'package:dartz/dartz.dart';
import 'package:disaster_safety/core/error/exception.dart';
import 'package:disaster_safety/core/error/failure.dart';
import 'package:disaster_safety/features/maps/DTO/register_incident_DTO.dart';
import 'package:disaster_safety/features/maps/data/datasource/incident_datasource.dart';
import 'package:disaster_safety/features/maps/data/datasource/maps_datasource.dart';
import 'package:disaster_safety/features/maps/data/models/incident_model.dart';
import 'package:disaster_safety/features/maps/domain/repository/incident_repository.dart';

class IncidentRepositoryImpl implements IncidentRepository {
  final IncidentDatasource datasource;
  final MapsDatasource mapsDatasource;

  IncidentRepositoryImpl(
      {required this.datasource, required this.mapsDatasource});

  @override
  Future<Either<Failure, void>> closeIncident(
      {required String incidentId}) async {
    try {
      await datasource.closeIncident(incidentId: incidentId);
      // ignore: void_checks
      return const Right(());
    } catch (e) {
      return Left(DatabaseFailure(message: (e as DatabaseFailure).message));
    }
  }

  @override
  Future<Either<Failure, void>> confirmIncident(
      {required String userId, required String incidentId}) async {
    try {
      await datasource.confirmIncident(userId: userId, incidentId: incidentId);
      return const Right(());
    } catch (e) {
      return Left(DatabaseFailure(message: (e as DatabaseFailure).message));
    }
  }

  @override
  Future<Either<Failure, void>> deleteIncident({required String incidentId}) {
    // TODO: implement deleteIncident
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<IncidentModel>>> getAllIncidentsForState(
      {required String state}) async {
    try {
      final response = await datasource.getIncidentsForState(state: state);
      return Right(response);
    } catch (e) {
      return Left(DatabaseFailure(message: (e as DatabaseException).message));
    }
  }

  @override
  Future<Either<Failure, List<IncidentModel>>> getAllPendingIncidents() async {
    try {
      final response = await datasource.getAllPendingIncidents();
      return Right(response);
    } catch (e) {
      return Left(DatabaseFailure(message: (e as DatabaseException).message));
    }
  }

  @override
  Future<Either<Failure, List<IncidentModel>>> getAllPendingIncidentsForState(
      {required String state}) async {
    try {
      final response = await datasource.getIncidentsForState(state: state);
      return Right(response);
    } catch (e) {
      return Left(DatabaseFailure(message: (e as DatabaseException).message));
    }
  }

  @override
  Future<Either<Failure, List<IncidentModel>>> getIncidentsForUser(
      {required double longitude,
      required double latitude,
      required double radius}) async {
    try {
      final incidents = await datasource.getNearbyIncidents(
          longitude: longitude, latitude: latitude, radius: radius);
      return Right(incidents);
    } catch (e) {
      return Left(MapsFailure(message: (e as MapException).message));
    }
  }

  @override
  Future<Either<Failure, void>> registerIncident(
      {required RegisterIncidentDTO dto}) async {
    try {
      final nearbyIncidentVerify =
          await datasource.verifyNearbyIncidentAlreadyExists(
              incidentType: dto.incidentType,
              longitude: dto.longitude,
              latitude: dto.latitude);
      if (nearbyIncidentVerify) {
        return Left(
            MapsFailure(message: "Similar Incident already registered nearby"));
      }
      await datasource.createIncident(dto: dto);
      return const Right(());
    } catch (e) {
      return Left(ServerFailure(message: "Something went wrong"));
    }
  }
}
