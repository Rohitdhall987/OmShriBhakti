class AllYogaByCategory {
  AllYogaByCategory({
    required this.allYoga,
    required this.status,
    required this.message,
  });
  late final List<AllYoga> allYoga;
  late final int status;
  late final String message;

  AllYogaByCategory.fromJson(Map<String, dynamic> json){
    allYoga = List.from(json['AllYoga']).map((e)=>AllYoga.fromJson(e)).toList();
    status = json['status'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['AllYoga'] = allYoga.map((e)=>e.toJson()).toList();
    _data['status'] = status;
    _data['message'] = message;
    return _data;
  }
}

class AllYoga {
  AllYoga({
    required this.id,
    required this.yogaCategoryId,
    required this.title,
    required this.image,
    required this.vedioUrl,
    required this.description,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.CategoryName,
  });
  late final int id;
  late final int yogaCategoryId;
  late final String title;
  late final String image;
  late final String vedioUrl;
  late final String description;
  late final String status;
  late final String createdAt;
  late final String updatedAt;
  late final String CategoryName;

  AllYoga.fromJson(Map<String, dynamic> json){
    id = json['id'];
    yogaCategoryId = json['yoga_category_id'];
    title = json['title'];
    image = json['image'];
    vedioUrl = json['vedio_url'];
    description = json['description'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    CategoryName = json['CategoryName'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['yoga_category_id'] = yogaCategoryId;
    _data['title'] = title;
    _data['image'] = image;
    _data['vedio_url'] = vedioUrl;
    _data['description'] = description;
    _data['status'] = status;
    _data['created_at'] = createdAt;
    _data['updated_at'] = updatedAt;
    _data['CategoryName'] = CategoryName;
    return _data;
  }
}