class LiveDarshanModel {
  LiveDarshanModel({
    required this.liveDarshan,
  });
  late final List<LiveDarshan> liveDarshan;

  LiveDarshanModel.fromJson(Map<String, dynamic> json){
    liveDarshan = List.from(json['liveDarshan']).map((e)=>LiveDarshan.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['liveDarshan'] = liveDarshan.map((e)=>e.toJson()).toList();
    return _data;
  }
}

class LiveDarshan {
  LiveDarshan({
    required this.id,
    required this.image,
    required this.url,
    required this.title,
  });
  late final int id;
  late final String image;
  late final String url;
  late final String title;

  LiveDarshan.fromJson(Map<String, dynamic> json){
    id = json['id'];
    image = json['image'];
    url = json['url'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['image'] = image;
    _data['url'] = url;
    _data['title'] = title;
    return _data;
  }
}