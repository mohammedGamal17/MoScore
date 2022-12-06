import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:moscore/app/failure/Failure.dart';
import 'package:moscore/domain/repositories/repositories.dart';
import 'package:moscore/domain/use_cases/base_use_cases.dart';

import '../../entities/entities.dart';

class RegisterUseCase extends BaseUseCases<User, RegisterInputs> {
  final Repositories _repositories;

  RegisterUseCase(this._repositories);

  @override
  Future<Either<Failure, User>> call(RegisterInputs input) async {
    return await _repositories.register(input);
  }
}

class RegisterInputs extends Equatable {
  final String name;
  final String email;
  final String password;
  final String image;

  const RegisterInputs(this.name, this.email, this.password, this.image);

  @override
  List<Object> get props => [name, email, password, image];
}
