import 'package:dartz/dartz.dart';
import 'package:disaster_safety/core/error/failure.dart';
import 'package:disaster_safety/features/maps/DTO/register_incident_DTO.dart';
import 'package:disaster_safety/features/maps/data/models/incident_model.dart';

abstract class IncidentRepository {
  //get incident for user
  ///Gets all the nearby incident user according to the [radius] set in the settings
  Future<Either<Failure, List<IncidentModel>>> getIncidentsForUser(
      {required double longitude,
      required double latitude,
      required double radius});

  //register incident
  Future<Either<Failure, void>> registerIncident(
      {required RegisterIncidentDTO dto});

  //delete incident
  Future<Either<Failure, void>> deleteIncident({required String incidentId});

  //confirm incident
  Future<Either<Failure, void>> confirmIncident(
      {required String userId, required String incidentId});

  //get all incidents for state
  Future<Either<Failure, List<IncidentModel>>> getAllIncidentsForState(
      {required String state});

  ///Gets all pending incidents for the admin to review based on state
  Future<Either<Failure, List<IncidentModel>>> getAllPendingIncidentsForState(
      {required String state});

  ///Gets all pending incidents for the super admin
  Future<Either<Failure, List<IncidentModel>>> getAllPendingIncidents();

  ///Close Incident
  Future<Either<Failure, void>> closeIncident({required String incidentId});
}
