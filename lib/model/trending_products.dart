class TrendingProductModel {
  TrendingProductModel({
    required this.trendingProducts,
  });
  late final List<TrendingProducts> trendingProducts;

  TrendingProductModel.fromJson(Map<String, dynamic> json){
    trendingProducts = List.from(json['trendingProducts']).map((e)=>TrendingProducts.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['trendingProducts'] = trendingProducts.map((e)=>e.toJson()).toList();
    return _data;
  }
}

class TrendingProducts {
  TrendingProducts({
    required this.title,
    required this.image_1,
    required this.productId,
    required this.trendingProductId,
    required this.image,
  });
  late final String title;
  late final String image_1;
  late final int productId;
  late final int trendingProductId;
  late final String image;

  TrendingProducts.fromJson(Map<String, dynamic> json){
    title = json['title'];
    image_1 = json['image_1'];
    productId = json['product_id'];
    trendingProductId = json['trendingProduct_id'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['title'] = title;
    _data['image_1'] = image_1;
    _data['product_id'] = productId;
    _data['trendingProduct_id'] = trendingProductId;
    _data['image'] = image;
    return _data;
  }
}