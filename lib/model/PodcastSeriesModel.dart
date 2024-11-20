class PodcastSeriesModel {
  PodcastSeriesModel({
    required this.audio,
    required this.audioSeason,
  });
  late final Audio audio;
  late final List<AudioSeason> audioSeason;

  PodcastSeriesModel.fromJson(Map<String, dynamic> json){
    audio = Audio.fromJson(json['audio']);
    audioSeason = List.from(json['audioSeason']).map((e)=>AudioSeason.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['audio'] = audio.toJson();
    _data['audioSeason'] = audioSeason.map((e)=>e.toJson()).toList();
    return _data;
  }
}

class Audio {
  Audio({
    required this.title,
    required this.image,
  });
  late final String title;
  late final String image;

  Audio.fromJson(Map<String, dynamic> json){
    title = json['title'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['title'] = title;
    _data['image'] = image;
    return _data;
  }
}

class AudioSeason {
  AudioSeason({
    required this.id,
    required this.title,
    required this.description,
    required this.season,
    required this.image,
    required this.audio,
    required this.audioseries,
    required this.audioSeriesId,
  });
  late final int id;
  late final String title;
  late final String description;
  late final String season;
  late final String image;
  late final String audio;
  late final String audioseries;
  late final int audioSeriesId;

  AudioSeason.fromJson(Map<String, dynamic> json){
    id = json['id'];
    title = json['title'];
    description = json['description'];
    season = json['season'];
    image = json['image'];
    audio = json['audio'];
    audioseries = json['audioseries'];
    audioSeriesId = json['audio_series_id'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['title'] = title;
    _data['description'] = description;
    _data['season'] = season;
    _data['image'] = image;
    _data['audio'] = audio;
    _data['audioseries'] = audioseries;
    _data['audio_series_id'] = audioSeriesId;
    return _data;
  }
}