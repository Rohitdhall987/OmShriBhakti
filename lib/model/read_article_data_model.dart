class ReadArticleDataModel {
  ReadArticleDataModel({
    required this.message,
    required this.data,
  });
  late final String message;
  late final Data data;

  ReadArticleDataModel.fromJson(Map<String, dynamic> json){
    message = json['message'];
    data = Data.fromJson(json['data']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['message'] = message;
    _data['data'] = data.toJson();
    return _data;
  }
}

class Data {
  Data({
    required this.id,
    required this.categoryId,
    required this.monthCategoryId,
    required this.title,
    required this.image,
    this.audio,
    required this.description,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });
  late final int id;
  late final int categoryId;
  late final int monthCategoryId;
  late final String title;
  late final String image;
  late final Null audio;
  late final String description;
  late final int status;
  late final String createdAt;
  late final String updatedAt;

  Data.fromJson(Map<String, dynamic> json){
    id = json['id'];
    categoryId = json['category_id'];
    monthCategoryId = json['month_category_id'];
    title = json['title'];
    image = json['image'];
    audio = null;
    description = json['description'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['category_id'] = categoryId;
    _data['month_category_id'] = monthCategoryId;
    _data['title'] = title;
    _data['image'] = image;
    _data['audio'] = audio;
    _data['description'] = description;
    _data['status'] = status;
    _data['created_at'] = createdAt;
    _data['updated_at'] = updatedAt;
    return _data;
  }
}