/// status : true
/// message : "Added Successfully"
/// data : {"id":109107,"product":{"id":53,"price":5599,"old_price":10230,"discount":45,"image":"https://student.valuxapps.com/storage/uploads/products/1615440689wYMHV.item_XXL_36330138_142814934.jpeg"}}

class FavouriteModel {
  FavouriteModel({
    bool? status,
    String? message,
    Data? data,
  }) {
    _status = status;
    _message = message;
    _data = data;
  }

  FavouriteModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  bool? _status;
  String? _message;
  Data? _data;

  FavouriteModel copyWith({
    bool? status,
    String? message,
    Data? data,
  }) =>
      FavouriteModel(
        status: status ?? _status,
        message: message ?? _message,
        data: data ?? _data,
      );

  bool? get status => _status;

  String? get message => _message;

  Data? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    if (_data != null) {
      map['data'] = _data?.toJson();
    }
    return map;
  }
}

/// id : 109107
/// product : {"id":53,"price":5599,"old_price":10230,"discount":45,"image":"https://student.valuxapps.com/storage/uploads/products/1615440689wYMHV.item_XXL_36330138_142814934.jpeg"}

class Data {
  Data({
    num? id,
    Product? product,
  }) {
    _id = id;
    _product = product;
  }

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _product =
        json['product'] != null ? Product.fromJson(json['product']) : null;
  }

  num? _id;
  Product? _product;

  Data copyWith({
    num? id,
    Product? product,
  }) =>
      Data(
        id: id ?? _id,
        product: product ?? _product,
      );

  num? get id => _id;

  Product? get product => _product;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    if (_product != null) {
      map['product'] = _product?.toJson();
    }
    return map;
  }
}

/// id : 53
/// price : 5599
/// old_price : 10230
/// discount : 45
/// image : "https://student.valuxapps.com/storage/uploads/products/1615440689wYMHV.item_XXL_36330138_142814934.jpeg"

class Product {
  Product({
    num? id,
    num? price,
    num? oldPrice,
    num? discount,
    String? image,
  }) {
    _id = id;
    _price = price;
    _oldPrice = oldPrice;
    _discount = discount;
    _image = image;
  }

  Product.fromJson(dynamic json) {
    _id = json['id'];
    _price = json['price'];
    _oldPrice = json['old_price'];
    _discount = json['discount'];
    _image = json['image'];
  }

  num? _id;
  num? _price;
  num? _oldPrice;
  num? _discount;
  String? _image;

  Product copyWith({
    num? id,
    num? price,
    num? oldPrice,
    num? discount,
    String? image,
  }) =>
      Product(
        id: id ?? _id,
        price: price ?? _price,
        oldPrice: oldPrice ?? _oldPrice,
        discount: discount ?? _discount,
        image: image ?? _image,
      );

  num? get id => _id;

  num? get price => _price;

  num? get oldPrice => _oldPrice;

  num? get discount => _discount;

  String? get image => _image;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['price'] = _price;
    map['old_price'] = _oldPrice;
    map['discount'] = _discount;
    map['image'] = _image;
    return map;
  }
}
