import 'package:moscore/domain/entities/entities.dart';

class UsersModel extends Users {
  const UsersModel({
    required super.name,
    required super.email,
    required super.image,
    required super.uId,
  });
  factory UsersModel.fromJson(Map<String, dynamic> json) {
    return UsersModel(
      name: json['name'],
      email: json['email'],
      uId: json['uId'],
      image: json['image'],
    );
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['email'] = email;
    data['image'] = image;
    data['uId'] = uId;
    return data;
  }
}
