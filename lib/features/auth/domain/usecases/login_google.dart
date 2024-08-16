import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/models/user.dart';
import '../../../../core/usecases/usecases.dart';
import '../repositories/auth_repo.dart';

@lazySingleton
class LoginGoogleUsecase extends Usecase<void, AuthCredential> {
  LoginGoogleUsecase({
    required this.repository,
  });

  final AuthenticationRepository repository;

  @override
  Future<Either<void, UserModel>> call(AuthCredential credential) async =>
      await repository.loginWithGoogle(credential);
}
