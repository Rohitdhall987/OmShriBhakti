class MonthlyArticlesModel {
  MonthlyArticlesModel({
    required this.monthCategory,
    required this.status,
    required this.message,
  });
  late final List<MonthCategory> monthCategory;
  late final int status;
  late final String message;

  MonthlyArticlesModel.fromJson(Map<String, dynamic> json){
    monthCategory = List.from(json['monthCategory']).map((e)=>MonthCategory.fromJson(e)).toList();
    status = json['status'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['monthCategory'] = monthCategory.map((e)=>e.toJson()).toList();
    _data['status'] = status;
    _data['message'] = message;
    return _data;
  }
}

class MonthCategory {
  MonthCategory({
    required this.id,
    required this.name,
    required this.image,
    required this.singleArticles,
    required this.articleSeries,
  });
  late final int id;
  late final String name;
  late final String image;
  late final int singleArticles;
  late final int articleSeries;

  MonthCategory.fromJson(Map<String, dynamic> json){
    id = json['id'];
    name = json['name'];
    image = json['image'];
    singleArticles = json['singleArticles'];
    articleSeries = json['articleSeries'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    _data['image'] = image;
    _data['singleArticles'] = singleArticles;
    _data['articleSeries'] = articleSeries;
    return _data;
  }
}