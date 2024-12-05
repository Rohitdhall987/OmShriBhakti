class RandomToursModel {
  RandomToursModel({
    required this.message,
    required this.randomTrip,
  });
  late final String message;
  late final List<RandomTrip> randomTrip;

  RandomToursModel.fromJson(Map<String, dynamic> json){
    message = json['message'];
    randomTrip = List.from(json['randomTrip']).map((e)=>RandomTrip.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['message'] = message;
    _data['randomTrip'] = randomTrip.map((e)=>e.toJson()).toList();
    return _data;
  }
}

class RandomTrip {
  RandomTrip({
    required this.id,
    required this.title,
    required this.image,
  });
  late final int id;
  late final String title;
  late final String image;

  RandomTrip.fromJson(Map<String, dynamic> json){
    id = json['id'];
    title = json['title'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['title'] = title;
    _data['image'] = image;
    return _data;
  }
}