class APIConstants {
  static const String _token =
      '19a76979eemshb0337f0256d5a90p1f164bjsn9593cf47fa11';
  static const Map<String, dynamic> header = {
    'X-RapidAPI-Key': _token,
  };
  static const String baseUrl = 'https://api-football-v1.p.rapidapi.com/v3';
  static const String fixturesLive = '$baseUrl/fixtures?live=all';

  static String getFixturesByID({required int id}) =>
      '$baseUrl/fixtures?id=$id';
}
