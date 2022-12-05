class GetUserData {
  GetUserData({
    bool? status,
    dynamic message,
    Data? data,
  }) {
    _status = status;
    _message = message;
    _data = data;
  }

  GetUserData.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  bool? _status;
  dynamic _message;
  Data? _data;

  GetUserData copyWith({
    bool? status,
    dynamic message,
    Data? data,
  }) =>
      GetUserData(
        status: status ?? _status,
        message: message ?? _message,
        data: data ?? _data,
      );

  bool? get status => _status;

  dynamic get message => _message;

  Data? get data => _data;
}

class Data {
  Data({
    num? id,
    String? name,
    String? email,
    String? phone,
    String? image,
    num? points,
    num? credit,
    String? token,
  }) {
    _id = id;
    _name = name;
    _email = email;
    _phone = phone;
    _image = image;
    _points = points;
    _credit = credit;
    _token = token;
  }

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _email = json['email'];
    _phone = json['phone'];
    _image = json['image'];
    _points = json['points'];
    _credit = json['credit'];
    _token = json['token'];
  }

  num? _id;
  String? _name;
  String? _email;
  String? _phone;
  String? _image;
  num? _points;
  num? _credit;
  String? _token;

  Data copyWith({
    num? id,
    String? name,
    String? email,
    String? phone,
    String? image,
    num? points,
    num? credit,
    String? token,
  }) =>
      Data(
        id: id ?? _id,
        name: name ?? _name,
        email: email ?? _email,
        phone: phone ?? _phone,
        image: image ?? _image,
        points: points ?? _points,
        credit: credit ?? _credit,
        token: token ?? _token,
      );

  num? get id => _id;

  String? get name => _name;

  String? get email => _email;

  String? get phone => _phone;

  String? get image => _image;

  num? get points => _points;

  num? get credit => _credit;

  String? get token => _token;
}
