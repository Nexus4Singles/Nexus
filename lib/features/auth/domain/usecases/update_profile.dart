import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/usecases/usecases.dart';
import '../repositories/auth_repo.dart';

@lazySingleton
class UpdateProfileUsecase extends Usecase<void, Map<String, dynamic>> {
  UpdateProfileUsecase({
    required this.repository,
  });

  final AuthenticationRepository repository;

  @override
  Future<Either<void, bool>> call(Map<String, dynamic> params) async =>
      await repository.updateProfile(params);
}
