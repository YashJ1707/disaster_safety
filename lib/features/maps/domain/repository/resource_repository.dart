import 'package:dartz/dartz.dart';
import 'package:disaster_safety/features/maps/DTO/register_resource_DTO.dart';
import 'package:disaster_safety/features/maps/data/models/resource_model.dart';

import '../../../../core/error/failure.dart';

abstract class ResourceRepository {
  Future<Either<Failure, List<ResourceModel>>> getNearbyResources(
      {required double longitude,
      required double latitude,
      required double radius});

  Future<Either<Failure, List<ResourceModel>>> getAllResources();

  Future<Either<Failure, List<ResourceModel>>> getResourcesForState(
      {required String state});

  Future<Either<Failure, void>> createResource(
      {required RegisterResourceDTO dto});

  Future<Either<Failure, void>> removeResource({required String resourceId});
}
