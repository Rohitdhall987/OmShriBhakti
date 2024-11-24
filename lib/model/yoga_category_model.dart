class YogaCategory {
  YogaCategory({
    required this.allYogaCategories,
    required this.status,
    required this.message,
  });
  late final List<AllYogaCategories> allYogaCategories;
  late final int status;
  late final String message;

  YogaCategory.fromJson(Map<String, dynamic> json){
    allYogaCategories = List.from(json['AllYogaCategories']).map((e)=>AllYogaCategories.fromJson(e)).toList();
    status = json['status'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['AllYogaCategories'] = allYogaCategories.map((e)=>e.toJson()).toList();
    _data['status'] = status;
    _data['message'] = message;
    return _data;
  }
}

class AllYogaCategories {
  AllYogaCategories({
    required this.id,
    required this.title,
    required this.image,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });
  late final int id;
  late final String title;
  late final String image;
  late final String status;
  late final String createdAt;
  late final String updatedAt;

  AllYogaCategories.fromJson(Map<String, dynamic> json){
    id = json['id'];
    title = json['title'];
    image = json['image'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['title'] = title;
    _data['image'] = image;
    _data['status'] = status;
    _data['created_at'] = createdAt;
    _data['updated_at'] = updatedAt;
    return _data;
  }
}