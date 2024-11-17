class GodsModel {
  GodsModel({
    required this.allGod,
  });
  late final List<AllGod> allGod;

  GodsModel.fromJson(Map<String, dynamic> json){
    allGod = List.from(json['allGod']).map((e)=>AllGod.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['allGod'] = allGod.map((e)=>e.toJson()).toList();
    return _data;
  }
}

class AllGod {
  AllGod({
    required this.id,
    required this.image,
    required this.name,
  });
  late final int id;
  late final String image;
  late final String name;

  AllGod.fromJson(Map<String, dynamic> json){
    id = json['id'];
    image = json['image'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['image'] = image;
    _data['name'] = name;
    return _data;
  }
}