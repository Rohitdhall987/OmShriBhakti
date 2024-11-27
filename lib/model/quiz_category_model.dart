class QuizCategoryModel {
  QuizCategoryModel({
    required this.message,
    required this.allQuizCategory,
  });
  late final String message;
  late final List<AllQuizCategory> allQuizCategory;

  QuizCategoryModel.fromJson(Map<String, dynamic> json){
    message = json['message'];
    allQuizCategory = List.from(json['allQuizCategory']).map((e)=>AllQuizCategory.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['message'] = message;
    _data['allQuizCategory'] = allQuizCategory.map((e)=>e.toJson()).toList();
    return _data;
  }
}

class AllQuizCategory {
  AllQuizCategory({
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
  late final int status;
  late final String createdAt;
  late final String updatedAt;

  AllQuizCategory.fromJson(Map<String, dynamic> json){
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