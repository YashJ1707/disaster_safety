import 'package:dartz/dartz.dart';
import 'package:disaster_safety/core/error/exception.dart';
import 'package:disaster_safety/core/error/failure.dart';
import 'package:disaster_safety/features/maps/DTO/register_resource_DTO.dart';
import 'package:disaster_safety/features/maps/data/datasource/resource_datasource.dart';
import 'package:disaster_safety/features/maps/data/models/resource_model.dart';
import 'package:disaster_safety/features/maps/domain/repository/resource_repository.dart';

class ResourceRepositoryImpl implements ResourceRepository {
  final ResourceDatasourceImpl datasource = ResourceDatasourceImpl();

  @override
  Future<Either<Failure, void>> createResource(
      {required RegisterResourceDTO dto}) async {
    try {
      final nearbyIncidentVerify =
          await datasource.verifyNearbyResourceAlreadyExists(
              resourceType: dto.resourceType,
              latitude: dto.latitude,
              longitude: dto.longitude);
      if (nearbyIncidentVerify) {
        return Left(
            MapsFailure(message: "Similar Incident already registered nearby"));
      }
      await datasource.createResource(dto: dto);
      return const Right(());
    } catch (e) {
      return Left(ServerFailure(message: "Something went wrong"));
    }
  }

  @override
  Future<Either<Failure, List<ResourceModel>>> getAllResources() async {
    try {
      final response = await datasource.getAllResources();
      return Right(response);
    } catch (e) {
      return Left(DatabaseFailure(message: (e as DatabaseException).message));
    }
  }

  @override
  Future<Either<Failure, List<ResourceModel>>> getNearbyResources(
      {required double longitude,
      required double latitude,
      required double radius}) async {
    try {
      final incidents = await datasource.getNearbyResource(
          longitude: longitude, latitude: latitude, radius: radius);
      return Right(incidents);
    } catch (e) {
      return Left(MapsFailure(message: (e as MapException).message));
    }
  }

  @override
  Future<Either<Failure, List<ResourceModel>>> getResourcesForState(
      {required String state}) async {
    try {
      final response = await datasource.getResourcesForState(state: state);
      return Right(response);
    } catch (e) {
      return Left(DatabaseFailure(message: (e as DatabaseException).message));
    }
  }

  @override
  Future<Either<Failure, void>> removeResource(
      {required String resourceId}) async {
    try {
      final response = await datasource.removeResource(resourceId: resourceId);
      return Right(response);
    } catch (e) {
      return Left(DatabaseFailure(message: (e as DatabaseException).message));
    }
  }
}
