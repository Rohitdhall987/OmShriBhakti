class PodcastModel {
  PodcastModel({
    required this.sanatanpodcat,
  });
  late final List<Sanatanpodcat> sanatanpodcat;

  PodcastModel.fromJson(Map<String, dynamic> json){
    sanatanpodcat = List.from(json['sanatanpodcat']).map((e)=>Sanatanpodcat.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['sanatanpodcat'] = sanatanpodcat.map((e)=>e.toJson()).toList();
    return _data;
  }
}

class Sanatanpodcat {
  Sanatanpodcat({
    required this.id,
    required this.title,
    required this.image,
    required this.description,
  });
  late final int id;
  late final String title;
  late final String image;
  late final String description;

  Sanatanpodcat.fromJson(Map<String, dynamic> json){
    id = json['id'];
    title = json['title'];
    image = json['image'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['title'] = title;
    _data['image'] = image;
    _data['description'] = description;
    return _data;
  }
}