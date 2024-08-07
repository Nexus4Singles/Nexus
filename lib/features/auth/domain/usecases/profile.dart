import 'package:dartz/dartz.dart';
import 'package:Nexus/core/models/user.dart';
import 'package:Nexus/features/auth/domain/repositories/auth_repo.dart';
import 'package:injectable/injectable.dart';
import 'package:Nexus/core/usecases/usecases.dart';

@lazySingleton
class ReadProfileUsecase extends Usecase<void, NoParams> {
  ReadProfileUsecase({
    required this.repository,
  });

  final AuthenticationRepository repository;

  @override
  Future<Either<void, UserModel>> call(NoParams params) async =>
      await repository.readProfile();
}
