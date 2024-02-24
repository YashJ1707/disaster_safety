abstract class MapsDatasource {
  Future<String> getState(
      {required double longitude, required double latitude});
}
