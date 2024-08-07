import 'package:dartz/dartz.dart';
import 'package:Nexus/core/models/user.dart';
import 'package:Nexus/features/auth/domain/repositories/auth_repo.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';
import 'package:Nexus/core/usecases/core/google.dart';

@lazySingleton
class RegisterWithGoogleUsecase
    extends GoogleUsecase<void, Map<String, dynamic>, AuthCredential> {
  RegisterWithGoogleUsecase({
    required this.repository,
  });

  final AuthenticationRepository repository;

  @override
  Future<Either<void, UserModel>> call(
          Map<String, dynamic> params, AuthCredential credential) async =>
      await repository.registerWithGoogle(credential, params);
}
