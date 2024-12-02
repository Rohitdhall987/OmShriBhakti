class SingleMonthArticle {
  SingleMonthArticle({
    required this.monthCategory,
    required this.status,
    required this.message,
    required this.singleArticles,
  });
  late final SMonthCategory monthCategory;
  late final int status;
  late final String message;
  late final List<SingleArticles> singleArticles;

  SingleMonthArticle.fromJson(Map<String, dynamic> json){
    monthCategory = SMonthCategory.fromJson(json['monthCategory']);
    status = json['status'];
    message = json['message'];
    singleArticles = List.from(json['SingleArticles']).map((e)=>SingleArticles.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['monthCategory'] = monthCategory.toJson();
    _data['status'] = status;
    _data['message'] = message;
    _data['SingleArticles'] = singleArticles.map((e)=>e.toJson()).toList();
    return _data;
  }
}

class SMonthCategory {
  SMonthCategory({
    required this.id,
    required this.title,
    required this.image,
    required this.month,
    required this.year,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });
  late final int id;
  late final String title;
  late final String image;
  late final String month;
  late final String year;
  late final int status;
  late final String createdAt;
  late final String updatedAt;

  SMonthCategory.fromJson(Map<String, dynamic> json){
    id = json['id'];
    title = json['title'];
    image = json['image'];
    month = json['month'];
    year = json['year'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['title'] = title;
    _data['image'] = image;
    _data['month'] = month;
    _data['year'] = year;
    _data['status'] = status;
    _data['created_at'] = createdAt;
    _data['updated_at'] = updatedAt;
    return _data;
  }
}

class SingleArticles {
  SingleArticles({
    required this.id,
    required this.title,
    required this.image,
  });
  late final int id;
  late final String title;
  late final String image;

  SingleArticles.fromJson(Map<String, dynamic> json){
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