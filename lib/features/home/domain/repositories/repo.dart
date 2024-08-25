import 'package:dartz/dartz.dart';

import '../../../../core/models/user.dart';

abstract class HomeRepository {
  Future<Either<void, List<UserModel>>> getUsers();
  Future<Either<void, List<UserModel>>> getUsersFilterable({
    required UserModel user,
  });
}
