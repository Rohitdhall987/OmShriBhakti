class ShareQuotesCategoryModel {
  ShareQuotesCategoryModel({
    required this.shareQuotesCategory,
    required this.status,
    required this.message,
  });
  late final List<ShareQuotesCategory> shareQuotesCategory;
  late final int status;
  late final String message;

  ShareQuotesCategoryModel.fromJson(Map<String, dynamic> json){
    shareQuotesCategory = List.from(json['ShareQuotesCategory']).map((e)=>ShareQuotesCategory.fromJson(e)).toList();
    status = json['status'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['ShareQuotesCategory'] = shareQuotesCategory.map((e)=>e.toJson()).toList();
    _data['status'] = status;
    _data['message'] = message;
    return _data;
  }
}

class ShareQuotesCategory {
  ShareQuotesCategory({
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

  ShareQuotesCategory.fromJson(Map<String, dynamic> json){
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