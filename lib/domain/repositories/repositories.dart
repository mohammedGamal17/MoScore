import 'package:dartz/dartz.dart';
import 'package:moscore/app/failure/Failure.dart';

import '../entities/entities.dart';
import '../use_cases/auth_use_cases/login_use_case.dart';
import '../use_cases/auth_use_cases/register_use_case.dart';

abstract class Repositories {
  Future<Either<Failure, User>> register(RegisterInputs input);

  Future<Either<Failure, User>> login(LoginInputs input);
}
