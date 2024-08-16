import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/models/user.dart';
import '../../../../core/usecases/usecases.dart';
import '../repositories/auth_repo.dart';

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
