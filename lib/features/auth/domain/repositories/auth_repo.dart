import 'package:dartz/dartz.dart';
import 'package:nexus/core/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthenticationRepository {
  Future<Either<void, UserModel>> login(Map<String, dynamic> map);
  Future<Either<void, UserModel>> register(Map<String, dynamic> map);
  Future<Either<void, UserModel>> loginWithGoogle(AuthCredential credential);
  Future<Either<void, UserModel>> registerWithGoogle(
      AuthCredential credential, Map<String, dynamic> map);
  Future<void> logout();
  Future<bool> isAuth();
  Future<Either<void, UserModel>> readProfile();
  Future<Either<void, bool>> updateProfile(Map<String, dynamic> map);
}
