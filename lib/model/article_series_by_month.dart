class SingleMonthArticleSeries {
  SingleMonthArticleSeries({
    required this.monthCategory,
    required this.status,
    required this.message,
    required this.articleSeries,
  });
  late final MonthCategorySeries monthCategory;
  late final int status;
  late final String message;
  late final List<ArticleSeries> articleSeries;

  SingleMonthArticleSeries.fromJson(Map<String, dynamic> json){
    monthCategory = MonthCategorySeries.fromJson(json['monthCategory']);
    status = json['status'];
    message = json['message'];
    articleSeries = List.from(json['ArticleSeries']).map((e)=>ArticleSeries.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['monthCategory'] = monthCategory.toJson();
    _data['status'] = status;
    _data['message'] = message;
    _data['ArticleSeries'] = articleSeries.map((e)=>e.toJson()).toList();
    return _data;
  }
}

class MonthCategorySeries {
  MonthCategorySeries({
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

  MonthCategorySeries.fromJson(Map<String, dynamic> json){
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

class ArticleSeries {
  ArticleSeries({
    required this.id,
    required this.title,
    required this.image,
  });
  late final int id;
  late final String title;
  late final String image;

  ArticleSeries.fromJson(Map<String, dynamic> json){
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