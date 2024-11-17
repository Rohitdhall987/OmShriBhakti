class ShalokModel {
  ShalokModel({
    required this.message,
    required this.shalok,
  });
  late final String message;
  late final Shalok shalok;

  ShalokModel.fromJson(Map<String, dynamic> json){
    message = json['message'];
    shalok = Shalok.fromJson(json['shalok']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['message'] = message;
    _data['shalok'] = shalok.toJson();
    return _data;
  }
}

class Shalok {
  Shalok({
    required this.id,
    required this.hindiTitle,
    required this.englishTitle,
    required this.sanskritTitle,
  });
  late final int id;
  late final String hindiTitle;
  late final String englishTitle;
  late final String sanskritTitle;

  Shalok.fromJson(Map<String, dynamic> json){
    id = json['id'];
    hindiTitle = json['hindi_title'];
    englishTitle = json['english_title'];
    sanskritTitle = json['sanskrit_title'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['hindi_title'] = hindiTitle;
    _data['english_title'] = englishTitle;
    _data['sanskrit_title'] = sanskritTitle;
    return _data;
  }
}