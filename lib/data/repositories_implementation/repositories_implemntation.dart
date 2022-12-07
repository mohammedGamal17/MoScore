import 'package:dartz/dartz.dart';
import 'package:moscore/app/failure/Failure.dart';
import 'package:moscore/domain/entities/entities.dart';
import 'package:moscore/domain/repositories/repositories.dart';
import 'package:moscore/domain/use_cases/auth_use_cases/login_use_case.dart';
import 'package:moscore/domain/use_cases/auth_use_cases/register_use_case.dart';

class RepositoriesImplementation extends Repositories {
  @override
  Future<Either<Failure, User>> login(LoginInputs input) {
    // TODO: implement login
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, User>> register(RegisterInputs input) {
    // TODO: implement register
    throw UnimplementedError();
  }
}
