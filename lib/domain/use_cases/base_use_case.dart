import 'package:dartz/dartz.dart';
import 'package:moscore/app/failure/Failure.dart';

abstract class BaseUseCases<Output, Inputs> {
  Future<Either<Failure, Output>> call(Inputs inputs);
}
