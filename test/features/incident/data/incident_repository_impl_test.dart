import 'package:dartz/dartz.dart';
import 'package:disaster_safety/core/error/exception.dart';
import 'package:disaster_safety/core/error/failure.dart';
import 'package:disaster_safety/features/maps/DTO/register_incident_DTO.dart';
import 'package:disaster_safety/features/maps/data/datasource/incident_datasource.dart';
import 'package:disaster_safety/features/maps/data/datasource/maps_datasource.dart';
import 'package:disaster_safety/features/maps/data/repository/incident_repository_impl.dart';
import 'package:disaster_safety/models/map_enums.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'incident_repository_impl_test.mocks.dart';

@GenerateMocks([IncidentDatasource, MapsDatasource])
void main() {
  late IncidentRepositoryImpl repositoryImpl;
  late MockIncidentDatasource datasource;
  late MockMapsDatasource mapsDatasource;
  setUp(() {
    datasource = MockIncidentDatasource();
    mapsDatasource = MockMapsDatasource();
    repositoryImpl = IncidentRepositoryImpl(
        datasource: datasource, mapsDatasource: mapsDatasource);
  });

  group("Regsiter Incident", () async {
    final RegisterIncidentDTO dto = RegisterIncidentDTO(
        userId: "test",
        longitude: 234,
        latitude: 234,
        incidentType: IncidentType.flood,
        incidentPriority: IncidentPriority.high,
        description: "description",
        imgPath: "imgPath",
        state: '');
    //should throw an error if similar incident exists around it
    test("should throw error if similar incident exists nearby", () async {
      when(datasource.verifyNearbyIncidentAlreadyExists(
              incidentType: dto.incidentType,
              latitude: dto.latitude,
              longitude: dto.longitude))
          .thenAnswer((realInvocation) => Future.value(true));

      final response = await repositoryImpl.registerIncident(dto: dto);

      verify(datasource.verifyNearbyIncidentAlreadyExists(
          incidentType: dto.incidentType,
          latitude: dto.latitude,
          longitude: dto.longitude));

      expect(
          response,
          Left(MapsFailure(
              message: "Similar Incident already registered nearby")));

      verifyNoMoreInteractions(datasource);
    });
    //should register incident successfuly
    test("test for succesfull registration of incident", () async {
      when(
        datasource.verifyNearbyIncidentAlreadyExists(
          incidentType: dto.incidentType,
          longitude: dto.longitude,
          latitude: dto.latitude,
        ),
      ).thenAnswer((realInvocation) => Future.value(false));

      final response = await repositoryImpl.registerIncident(dto: dto);

      verify(datasource.createIncident(dto: dto));
      verify(datasource.verifyNearbyIncidentAlreadyExists(
          incidentType: dto.incidentType,
          latitude: dto.latitude,
          longitude: dto.longitude));

      expect(response, const Right(()));
      verifyNoMoreInteractions(datasource);
    });

    //should throw error for server failure
    test("test for google maps api exception", () async {
      when(datasource.createIncident(dto: dto))
          .thenThrow(ServerException("Server not reachable"));

      final response = await repositoryImpl.registerIncident(dto: dto);

      verify(datasource.createIncident(dto: dto));
      verify(datasource.verifyNearbyIncidentAlreadyExists(
          incidentType: dto.incidentType,
          latitude: dto.latitude,
          longitude: dto.longitude));

      expect(response, Left(ServerFailure(message: "Something went wrong")));
      verifyNoMoreInteractions(datasource);
    });
  });
}
