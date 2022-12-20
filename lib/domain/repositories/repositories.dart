import 'package:dartz/dartz.dart';

import '../../app/failure/Failure.dart';
import '../entities/entities.dart';

abstract class Repositories {
  Future<Either<Failure,List<FixtureResponse>>> getLiveFixture();
}
