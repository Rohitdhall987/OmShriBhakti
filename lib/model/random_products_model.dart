class RandomProductsModel {
  RandomProductsModel({
    required this.randomProducts,
  });
  late final List<RandomProducts> randomProducts;

  RandomProductsModel.fromJson(Map<String, dynamic> json){
    randomProducts = List.from(json['randomProducts']).map((e)=>RandomProducts.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['randomProducts'] = randomProducts.map((e)=>e.toJson()).toList();
    return _data;
  }
}

class RandomProducts {
  RandomProducts({
    required this.productId,
    required this.title,
    required this.image_1,
    required this.categoryName,
  });
  late final int productId;
  late final String title;
  late final String image_1;
  late final String categoryName;

  RandomProducts.fromJson(Map<String, dynamic> json){
    productId = json['product_id'];
    title = json['title'];
    image_1 = json['image_1'];
    categoryName = json['category_name'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['product_id'] = productId;
    _data['title'] = title;
    _data['image_1'] = image_1;
    _data['category_name'] = categoryName;
    return _data;
  }
}