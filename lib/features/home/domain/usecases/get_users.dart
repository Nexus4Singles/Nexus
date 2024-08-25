import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/models/user.dart';
import '../../../../core/usecases/usecases.dart';
import '../repositories/repo.dart';

@lazySingleton
class GetUsersUsecase extends Usecase<void, NoParams> {
  GetUsersUsecase({
    required this.repository,
  });

  final HomeRepository repository;

  @override
  Future<Either<void, List<UserModel>>> call(NoParams params) async =>
      await repository.getUsers();
}
