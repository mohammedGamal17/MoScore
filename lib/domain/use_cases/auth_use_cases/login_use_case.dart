import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:moscore/app/failure/Failure.dart';
import 'package:moscore/domain/repositories/repositories.dart';
import 'package:moscore/domain/use_cases/base_use_cases.dart';

import '../../entities/entities.dart';

class LoginUseCase extends BaseUseCases<User, LoginInputs> {
  final Repositories _repositories;

  LoginUseCase(this._repositories);

  @override
  Future<Either<Failure, User>> call(LoginInputs input) async {
    return await _repositories.login(input);
  }
}

class LoginInputs extends Equatable {
  final String email;
  final String password;

  const LoginInputs(this.email, this.password);

  @override
  List<Object> get props => [email, password];
}
