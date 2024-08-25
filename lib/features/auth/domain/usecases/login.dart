import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/models/user.dart';
import '../../../../core/usecases/usecases.dart';
import '../repositories/auth_repo.dart';

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
