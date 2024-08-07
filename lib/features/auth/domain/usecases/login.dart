import 'package:dartz/dartz.dart';
import 'package:Nexus/core/models/user.dart';
import 'package:Nexus/features/auth/domain/repositories/auth_repo.dart';
import 'package:injectable/injectable.dart';
import 'package:Nexus/core/usecases/usecases.dart';

@lazySingleton
class LoginUsecase extends Usecase<void, Map<String, dynamic>> {
  LoginUsecase({
    required this.repository,
  });

  final AuthenticationRepository repository;

  @override
  Future<Either<void, UserModel>> call(Map<String, dynamic> params) async =>
      await repository.login(params);
}
