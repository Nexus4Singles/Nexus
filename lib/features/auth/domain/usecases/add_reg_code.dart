import 'package:dartz/dartz.dart';
import 'package:nexus/features/auth/domain/repositories/auth_repo.dart';
import 'package:injectable/injectable.dart';
import 'package:nexus/core/usecases/usecases.dart';

@lazySingleton
class AddRegCodeUsecase extends Usecase<void, Map<String, dynamic>> {
  AddRegCodeUsecase({
    required this.repository,
  });

  final AuthenticationRepository repository;

  @override
  Future<Either<void, bool>> call(Map<String, dynamic> params) async =>
      await repository.addRegistrationCode(params);
}
