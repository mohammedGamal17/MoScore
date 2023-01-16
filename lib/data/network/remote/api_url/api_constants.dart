import 'package:intl/intl.dart';

DateTime _now = DateTime.now();
String formattedDate = DateFormat('yyyy-MM-dd').format(_now);

class APIConstants {
  static const String _token =
      'PUT YOUR TOKEN HERE';
  static const String _token1 = 'PUT YOUR TOKEN HERE';

  static const Map<String, dynamic> header = {
    'X-RapidAPI-Key': _token1,
  };
  static const String baseUrl = 'https://api-football-v1.p.rapidapi.com/v3';
  static const String baseUrl1 = 'https://v3.football.api-sports.io';
  static const String fixturesLive = '$baseUrl1/fixtures?live=all';

  static String getFixturesByID({required int id}) =>
      '$baseUrl1/fixtures?id=$id';

  static String getTodayMatch = '$baseUrl1/fixtures?date=$formattedDate';
  static const String leagues = '$baseUrl1/leagues';

  static String getLeagueByIdAndSeason({
    required int season,
    required int leagueId,
  }) =>
      '$baseUrl1/standings?season=$season&league=$leagueId';

  static String getTeamInfo({required int id}) => '$baseUrl1/teams?id=$id';

  static String getPlayerInfo({required int id, required int season}) =>
      '$baseUrl1/players?id=$id&season=$season';
}
