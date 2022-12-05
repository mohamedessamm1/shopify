class RegisterModel {
  RegisterModel({
    bool? status,
    String? message,
    Data? data,
  }) {
    _status = status;
    _message = message;
    _data = data;
  }

  RegisterModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  bool? _status;
  String? _message;
  Data? _data;

  RegisterModel copyWith({
    bool? status,
    String? message,
    Data? data,
  }) =>
      RegisterModel(
        status: status ?? _status,
        message: message ?? _message,
        data: data ?? _data,
      );

  bool? get status => _status;

  String? get message => _message;

  Data? get data => _data;
}

class Data {
  Data({
    String? name,
    String? email,
    String? phone,
    num? id,
    String? image,
    String? token,
  }) {
    _name = name;
    _email = email;
    _phone = phone;
    _id = id;
    _image = image;
    _token = token;
  }

  Data.fromJson(dynamic json) {
    _name = json['name'];
    _email = json['email'];
    _phone = json['phone'];
    _id = json['id'];
    _image = json['image'];
    _token = json['token'];
  }

  String? _name;
  String? _email;
  String? _phone;
  num? _id;
  String? _image;
  String? _token;

  Data copyWith({
    String? name,
    String? email,
    String? phone,
    num? id,
    String? image,
    String? token,
  }) =>
      Data(
        name: name ?? _name,
        email: email ?? _email,
        phone: phone ?? _phone,
        id: id ?? _id,
        image: image ?? _image,
        token: token ?? _token,
      );

  String? get name => _name;

  String? get email => _email;

  String? get phone => _phone;

  num? get id => _id;

  String? get image => _image;

  String? get token => _token;
}
