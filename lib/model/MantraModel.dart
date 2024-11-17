class MantraModel {
  MantraModel({
    required this.mantras,
  });
  late final List<Mantras> mantras;

  MantraModel.fromJson(Map<String, dynamic> json){
    mantras = List.from(json['mantras']).map((e)=>Mantras.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['mantras'] = mantras.map((e)=>e.toJson()).toList();
    return _data;
  }
}

class Mantras {
  Mantras({
    required this.category,
    required this.catId,
    required this.mantra,
  });
  late final String category;
  late final int catId;
  late final List<Mantra> mantra;

  Mantras.fromJson(Map<String, dynamic> json){
    category = json['category'];
    catId = json['cat_id'];
    mantra = List.from(json['mantra']).map((e)=>Mantra.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['category'] = category;
    _data['cat_id'] = catId;
    _data['mantra'] = mantra.map((e)=>e.toJson()).toList();
    return _data;
  }
}

class Mantra {
  Mantra({
    required this.id,
    required this.title,
    required this.audio,
    required this.description,
  });
  late final int id;
  late final String title;
  late final String audio;
  late final String description;

  Mantra.fromJson(Map<String, dynamic> json){
    id = json['id'];
    title = json['title'];
    audio = json['audio'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['title'] = title;
    _data['audio'] = audio;
    _data['description'] = description;
    return _data;
  }
}