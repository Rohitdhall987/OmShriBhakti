class GodDataModel {
  GodDataModel({
    required this.godImage,
    required this.aarti,
    required this.bhajan,
    required this.song,
    required this.paath,
    required this.chalisa,
  });
  late final GodImage godImage;
  late final List<Aarti> aarti;
  late final List<Bhajan> bhajan;
  late final List<Song> song;
  late final List<Paath> paath;
  late final List<Chalisa> chalisa;

  GodDataModel.fromJson(Map<String, dynamic> json){
    godImage = GodImage.fromJson(json['godImage']);
    aarti = List.from(json['aarti']).map((e)=>Aarti.fromJson(e)).toList();
    bhajan = List.from(json['bhajan']).map((e)=>Bhajan.fromJson(e)).toList();
    song = List.from(json['song']).map((e)=>Song.fromJson(e)).toList();
    paath = List.from(json['paath']).map((e)=>Paath.fromJson(e)).toList();
    chalisa = List.from(json['chalisa']).map((e)=>Chalisa.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['godImage'] = godImage.toJson();
    _data['aarti'] = aarti.map((e)=>e.toJson()).toList();
    _data['bhajan'] = bhajan.map((e)=>e.toJson()).toList();
    _data['song'] = song.map((e)=>e.toJson()).toList();
    _data['paath'] = paath.map((e)=>e.toJson()).toList();
    _data['chalisa'] = chalisa.map((e)=>e.toJson()).toList();
    return _data;
  }
}

class GodImage {
  GodImage({
    required this.image,
  });
  late final String image;

  GodImage.fromJson(Map<String, dynamic> json){
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['image'] = image;
    return _data;
  }
}

class Aarti {
  Aarti({
    required this.id,
    required this.image,
    required this.audio,
    required this.title,
    required this.singer,
  });
  late final int id;
  late final String image;
  late final String audio;
  late final String title;
  late final String singer;

  Aarti.fromJson(Map<String, dynamic> json){
    id = json['id'];
    image = json['image'];
    audio = json['audio'];
    title = json['title'];
    singer = json['singer'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['image'] = image;
    _data['audio'] = audio;
    _data['title'] = title;
    _data['singer'] = singer;
    return _data;
  }
}

class Bhajan {
  Bhajan({
    required this.id,
    required this.image,
    required this.audio,
    required this.title,
    required this.singer,
  });
  late final int id;
  late final String image;
  late final String audio;
  late final String title;
  late final String singer;

  Bhajan.fromJson(Map<String, dynamic> json){
    id = json['id'];
    image = json['image'];
    audio = json['audio'];
    title = json['title'];
    singer = json['singer'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['image'] = image;
    _data['audio'] = audio;
    _data['title'] = title;
    _data['singer'] = singer;
    return _data;
  }
}

class Song {
  Song({
    required this.id,
    required this.image,
    required this.audio,
    required this.title,
    required this.singer,
  });
  late final int id;
  late final String image;
  late final String audio;
  late final String title;
  late final String singer;

  Song.fromJson(Map<String, dynamic> json){
    id = json['id'];
    image = json['image'];
    audio = json['audio'];
    title = json['title'];
    singer = json['singer'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['image'] = image;
    _data['audio'] = audio;
    _data['title'] = title;
    _data['singer'] = singer;
    return _data;
  }
}

class Paath {
  Paath({
    required this.id,
    required this.image,
    required this.audio,
    required this.title,
    required this.singer,
  });
  late final int id;
  late final String image;
  late final String audio;
  late final String title;
  late final String singer;

  Paath.fromJson(Map<String, dynamic> json){
    id = json['id'];
    image = json['image'];
    audio = json['audio'];
    title = json['title'];
    singer = json['singer'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['image'] = image;
    _data['audio'] = audio;
    _data['title'] = title;
    _data['singer'] = singer;
    return _data;
  }
}

class Chalisa {
  Chalisa({
    required this.id,
    required this.image,
    required this.audio,
    required this.title,
    required this.singer,
  });
  late final int id;
  late final String image;
  late final String audio;
  late final String title;
  late final String singer;

  Chalisa.fromJson(Map<String, dynamic> json){
    id = json['id'];
    image = json['image'];
    audio = json['audio'];
    title = json['title'];
    singer = json['singer'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['image'] = image;
    _data['audio'] = audio;
    _data['title'] = title;
    _data['singer'] = singer;
    return _data;
  }
}