class TrendingProductModel {
  TrendingProductModel({
    required this.trendingProducts,
  });
  late final List<TrendingProducts> trendingProducts;

  TrendingProductModel.fromJson(Map<String, dynamic> json){
    trendingProducts = List.from(json['TrendingProducts']).map((e)=>TrendingProducts.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['TrendingProducts'] = trendingProducts.map((e)=>e.toJson()).toList();
    return _data;
  }
}

class TrendingProducts {
  TrendingProducts({
    required this.id,
    required this.categoryId,
    required this.title,
    required this.image_1,
    this.image_2,
    this.image_3,
    required this.description,
    required this.price,
    required this.unit,
    this.skuNumber,
    required this.discount,
    required this.quantity,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.productId,
    required this.trendingProductId,
    required this.image,
  });
  late final int id;
  late final int categoryId;
  late final String title;
  late final String image_1;
  late final Null image_2;
  late final Null image_3;
  late final String description;
  late final String price;
  late final String unit;
  late final Null skuNumber;
  late final String discount;
  late final String quantity;
  late final int status;
  late final String createdAt;
  late final String updatedAt;
  late final int productId;
  late final int trendingProductId;
  late final String image;

  TrendingProducts.fromJson(Map<String, dynamic> json){
    id = json['id'];
    categoryId = json['category_id'];
    title = json['title'];
    image_1 = json['image_1'];
    image_2 = null;
    image_3 = null;
    description = json['description'];
    price = json['price'];
    unit = json['unit'];
    skuNumber = null;
    discount = json['discount'];
    quantity = json['quantity'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    productId = json['product_id'];
    trendingProductId = json['trendingProduct_id'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['category_id'] = categoryId;
    _data['title'] = title;
    _data['image_1'] = image_1;
    _data['image_2'] = image_2;
    _data['image_3'] = image_3;
    _data['description'] = description;
    _data['price'] = price;
    _data['unit'] = unit;
    _data['sku_number'] = skuNumber;
    _data['discount'] = discount;
    _data['quantity'] = quantity;
    _data['status'] = status;
    _data['created_at'] = createdAt;
    _data['updated_at'] = updatedAt;
    _data['product_id'] = productId;
    _data['trendingProduct_id'] = trendingProductId;
    _data['image'] = image;
    return _data;
  }
}