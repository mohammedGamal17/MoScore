import 'package:dartz/dartz.dart';

import '../../app/failure/Failure.dart';
import '../../domain/entities/entities.dart';
import '../../domain/repositories/repositories.dart';

class RepositoriesImplementation implements Repositories {
  RepositoriesImplementation();

  @override
  Future<Either<Failure, List<FixtureResponse>>> getLiveFixture() {
    // TODO: implement getLiveFixture
    throw UnimplementedError();
  }
}
