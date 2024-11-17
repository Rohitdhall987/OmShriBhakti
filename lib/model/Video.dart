class VideosModel {
  VideosModel({
    required this.video,
  });
  late final List<Video> video;

  VideosModel.fromJson(Map<String, dynamic> json){
    video = List.from(json['video']).map((e)=>Video.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['video'] = video.map((e)=>e.toJson()).toList();
    return data;
  }
}

class Video {
  Video({
    required this.id,
    required this.title,
    required this.url,
    required this.image,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });
  late final int id;
  late final String title;
  late final String url;
  late final String image;
  late final int status;
  late final String createdAt;
  late final String updatedAt;

  Video.fromJson(Map<String, dynamic> json){
    id = json['id'];
    title = json['title'];
    url = json['url'];
    image = json['image'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['title'] = title;
    _data['url'] = url;
    _data['image'] = image;
    _data['status'] = status;
    _data['created_at'] = createdAt;
    _data['updated_at'] = updatedAt;
    return _data;
  }
}