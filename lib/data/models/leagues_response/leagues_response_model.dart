import '../../../domain/entities/entities.dart';
import '../fixture_response/fixture_response_model.dart';

class LeagueResponseModel extends LeagueResponse {
  const LeagueResponseModel({
    required super.league,
    required super.country,
    required super.seasons,
  });

  factory LeagueResponseModel.fromJson(Map<String, dynamic> json) {
    return LeagueResponseModel(
      league: LeagueModel.fromJson(json['league']),
      country: CountryModel.fromJson(json['country']),
      seasons: List.from(json['seasons'])
          .map((e) => SeasonsModel.fromJson(e))
          .toList(),
    );
  }
}

class CountryModel extends Country {
  const CountryModel({
    required super.name,
    required super.flag,
  });

  factory CountryModel.fromJson(Map<String, dynamic> json) {
    return CountryModel(
      name: json['name'],
      flag: json['flag'] ?? '',
    );
  }
}

class SeasonsModel extends Seasons {
  const SeasonsModel({
    required super.year,
    required super.start,
    required super.end,
    required super.current,
  });

  factory SeasonsModel.fromJson(Map<String, dynamic> json) {
    return SeasonsModel(
      year: json['year'],
      start: json['start'],
      end: json['end'],
      current: json['current'],
    );
  }
}
