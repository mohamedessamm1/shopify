class ShopLoginModel {
  bool? status;
  String? message;
  UserData? data;

  ShopLoginModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? UserData.fromJson(json['data']) : null;
  }
}

class UserData {
  dynamic id;
  dynamic name;
  dynamic email;
  dynamic phone;
  String? token;
  String? image;
  int? points;
  int? credit;

  UserData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    name = json['name'];
    token = json['token'];
    image = json['image'];
    credit = json['credit'];
    phone = json['phone'];
    points = json['points'];
  }
}
