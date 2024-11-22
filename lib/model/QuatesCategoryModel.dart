class QuotesCategory {
  QuotesCategory({
    required this.category,
    required this.status,
    required this.message,
  });
  late final List<Category> category;
  late final int status;
  late final String message;

  QuotesCategory.fromJson(Map<String, dynamic> json){
    category = List.from(json['mantraswithCategory']).map((e)=>Category.fromJson(e)).toList();
    status = json['status'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['mantraswithCategory'] = category.map((e)=>e.toJson()).toList();
    _data['status'] = status;
    _data['message'] = message;
    return _data;
  }
}

class Category {
  Category({
    required this.id,
    required this.Title,
    required this.hindiTitle,
    required this.image,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });
  late final int id;
  late final String Title;
  late final String hindiTitle;
  late final String image;
  late final int status;
  late final String createdAt;
  late final String updatedAt;

  Category.fromJson(Map<String, dynamic> json){
    id = json['id'];
    Title = json['Title'];
    hindiTitle = json['hindi_title'];
    image = json['image'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['Title'] = Title;
    _data['hindi_title'] = hindiTitle;
    _data['image'] = image;
    _data['status'] = status;
    _data['created_at'] = createdAt;
    _data['updated_at'] = updatedAt;
    return _data;
  }
}