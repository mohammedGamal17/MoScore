import 'package:equatable/equatable.dart';

class Countries {
  int results;
  List<Response> response;

  Countries(this.results, this.response);
}

class Response {
  String name;
  String code;
  String flag;

  Response(this.name, this.code, this.flag);
}

class Users extends Equatable {
  String? name;
  String? email;
  String? image;
  late String uId;

  Users({
    required this.name,
    required this.email,
    required this.image,
    required this.uId,
  });

  @override
  List<Object?> get props => [name, email, image, uId];
}
