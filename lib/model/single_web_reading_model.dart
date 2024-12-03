class SingleWebReadingModel {
  SingleWebReadingModel({
    required this.singleWebReading,
    required this.seasons,
  });
  late final SingleWebReading singleWebReading;
  late final List<Seasons> seasons;

  SingleWebReadingModel.fromJson(Map<String, dynamic> json){
    singleWebReading = SingleWebReading.fromJson(json['singleWebReading']);
    seasons = List.from(json['seasons']).map((e)=>Seasons.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['singleWebReading'] = singleWebReading.toJson();
    _data['seasons'] = seasons.map((e)=>e.toJson()).toList();
    return _data;
  }
}

class SingleWebReading {
  SingleWebReading({
    required this.id,
    required this.title,
    required this.image,
    required this.description,
    required this.cattitle,
  });
  late final int id;
  late final String title;
  late final String image;
  late final String description;
  late final String cattitle;

  SingleWebReading.fromJson(Map<String, dynamic> json){
    id = json['id'];
    title = json['title'];
    image = json['image'];
    description = json['description'];
    cattitle = json['cattitle'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['title'] = title;
    _data['image'] = image;
    _data['description'] = description;
    _data['cattitle'] = cattitle;
    return _data;
  }
}

class Seasons {
  Seasons({
    required this.title,
    required this.image,
    required this.id,
    required this.audio,
  });
  late final String title;
  late final String image;
  late final int id;
  late final String audio;

  Seasons.fromJson(Map<String, dynamic> json){
    title = json['title'];
    image = json['image'];
    id = json['id'];
    audio = json['audio'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['title'] = title;
    _data['image'] = image;
    _data['id'] = id;
    _data['audio'] = audio;
    return _data;
  }
}