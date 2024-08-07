import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:Nexus/core/models/user.dart';
import 'package:Nexus/core/usecases/usecases.dart';
import 'package:Nexus/features/home/domain/repositories/repo.dart';

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
