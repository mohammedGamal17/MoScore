import 'package:dartz/dartz.dart';
import 'package:moscore/app/failure/Failure.dart';

abstract class BaseUseCases<Output,Input>{
  Future<Either<Failure,Output>> call(Input input);
}