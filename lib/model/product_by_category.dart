class ProductByCategoryModel {
  ProductByCategoryModel({
    required this.singleCategoryProducts,
  });
  late final List<SingleCategoryProducts> singleCategoryProducts;

  ProductByCategoryModel.fromJson(Map<String, dynamic> json){
    singleCategoryProducts = List.from(json['singleCategoryProducts']).map((e)=>SingleCategoryProducts.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['singleCategoryProducts'] = singleCategoryProducts.map((e)=>e.toJson()).toList();
    return _data;
  }
}

class SingleCategoryProducts {
  SingleCategoryProducts({
    required this.title,
    required this.image_1,
    required this.productId,
  });
  late final String title;
  late final String image_1;
  late final int productId;

  SingleCategoryProducts.fromJson(Map<String, dynamic> json){
    title = json['title'];
    image_1 = json['image_1'];
    productId = json['product_id'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['title'] = title;
    _data['image_1'] = image_1;
    _data['product_id'] = productId;
    return _data;
  }
}