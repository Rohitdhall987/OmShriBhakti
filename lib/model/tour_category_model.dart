class TourCategoryModel {
  TourCategoryModel({
    required this.message,
    required this.tripCategories,
  });
  late final String message;
  late final List<TripCategories> tripCategories;

  TourCategoryModel.fromJson(Map<String, dynamic> json){
    message = json['message'];
    tripCategories = List.from(json['tripCategories']).map((e)=>TripCategories.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['message'] = message;
    _data['tripCategories'] = tripCategories.map((e)=>e.toJson()).toList();
    return _data;
  }
}

class TripCategories {
  TripCategories({
    required this.id,
    required this.title,
    required this.serialNo,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });
  late final int id;
  late final String title;
  late final int serialNo;
  late final int status;
  late final String createdAt;
  late final String updatedAt;

  TripCategories.fromJson(Map<String, dynamic> json){
    id = json['id'];
    title = json['title'];
    serialNo = json['serial_no'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['title'] = title;
    _data['serial_no'] = serialNo;
    _data['status'] = status;
    _data['created_at'] = createdAt;
    _data['updated_at'] = updatedAt;
    return _data;
  }
}