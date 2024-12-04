class HomeYogaListModel {
  HomeYogaListModel({
    required this.yogaList,
    required this.status,
    required this.message,
  });
  late final List<YogaList> yogaList;
  late final int status;
  late final String message;

  HomeYogaListModel.fromJson(Map<String, dynamic> json){
    yogaList = List.from(json['yogaList']).map((e)=>YogaList.fromJson(e)).toList();
    status = json['status'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['yogaList'] = yogaList.map((e)=>e.toJson()).toList();
    _data['status'] = status;
    _data['message'] = message;
    return _data;
  }
}

class YogaList {
  YogaList({
    required this.id,
    required this.title,
    required this.image,
    required this.vedioUrl,
  });
  late final int id;
  late final String title;
  late final String image;
  late final String vedioUrl;

  YogaList.fromJson(Map<String, dynamic> json){
    id = json['id'];
    title = json['title'];
    image = json['image'];
    vedioUrl = json['vedio_url'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['title'] = title;
    _data['image'] = image;
    _data['vedio_url'] = vedioUrl;
    return _data;
  }
}