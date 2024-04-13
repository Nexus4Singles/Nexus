import 'package:dartz/dartz.dart';
import 'package:nexus/core/models/user.dart';

abstract class HomeRepository {
  Future<Either<void, List<UserModel>>> getUsers();
}
