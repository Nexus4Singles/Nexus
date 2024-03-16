import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:nexus/core/usecases/usecases.dart';
import 'package:nexus/core/models/user.dart';
import 'package:nexus/features/auth/domain/repositories/auth_repo.dart';

@lazySingleton
class RegisterUsecase extends Usecase<void, Map<String, dynamic>> {
  RegisterUsecase({
    required this.repository,
  });

  final AuthenticationRepository repository;

  @override
  Future<Either<void, UserModel>> call(Map<String, dynamic> params) async =>
      await repository.register(params);
}
