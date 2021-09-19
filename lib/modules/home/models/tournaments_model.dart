class TournamentsModel {
  late String cursor;
  late List<Tournament> tournaments;

  TournamentsModel({required this.cursor, required this.tournaments});

  TournamentsModel.fromJson(Map<String, dynamic> json) {
    cursor = json['cursor'];
    if (json['tournaments'] != null) {
      tournaments = <Tournament>[];
      json['tournaments'].forEach((v) {
        tournaments.add(Tournament.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['cursor'] = cursor;
    data['tournaments'] = tournaments.map((v) => v.toJson()).toList();
    return data;
  }
}

class Tournament {
  String? name;
  String? coverUrl;
  String? gameName;

  Tournament({this.name, this.coverUrl, this.gameName});

  Tournament.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    coverUrl = json['cover_url'];
    gameName = json['game_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['cover_url'] = coverUrl;
    data['game_name'] = gameName;
    return data;
  }
}
