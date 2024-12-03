class ProductCategories {
  ProductCategories({
    required this.catgeory,
    required this.status,
    required this.message,
  });
  late final List<Catgeory> catgeory;
  late final int status;
  late final String message;

  ProductCategories.fromJson(Map<String, dynamic> json){
    catgeory = List.from(json['Catgeory']).map((e)=>Catgeory.fromJson(e)).toList();
    status = json['status'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['Catgeory'] = catgeory.map((e)=>e.toJson()).toList();
    _data['status'] = status;
    _data['message'] = message;
    return _data;
  }
}

class Catgeory {
  Catgeory({
    required this.id,
    required this.categoryName,
    required this.categoryImg,
    required this.status,
    required this.serialNo,
    required this.createdAt,
    required this.updatedAt,
  });
  late final int id;
  late final String categoryName;
  late final String categoryImg;
  late final int status;
  late final int serialNo;
  late final String createdAt;
  late final String updatedAt;

  Catgeory.fromJson(Map<String, dynamic> json){
    id = json['id'];
    categoryName = json['category_name'];
    categoryImg = json['category_img'];
    status = json['status'];
    serialNo = json['serial_no'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['category_name'] = categoryName;
    _data['category_img'] = categoryImg;
    _data['status'] = status;
    _data['serial_no'] = serialNo;
    _data['created_at'] = createdAt;
    _data['updated_at'] = updatedAt;
    return _data;
  }
}