import 'package:intl/intl.dart';

DateTime _now = DateTime.now();
String formattedDate = DateFormat('yyyy-MM-dd').format(_now);

class APIConstants {
  static const String _token =
      '19a76979eemshb0337f0256d5a90p1f164bjsn9593cf47fa11';
  static const String _token1 = 'ed307c6f236bd2c88d2c2f6b325281c8';

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
}
