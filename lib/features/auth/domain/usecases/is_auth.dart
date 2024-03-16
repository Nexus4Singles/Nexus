import 'package:nexus/features/auth/domain/repositories/auth_repo.dart';
import 'package:injectable/injectable.dart';
import 'package:nexus/core/usecases/usecases.dart';

@lazySingleton
class IsAuthUsecase extends Usecase<void, NoParams> {
  IsAuthUsecase({
    required this.repository,
  });

  final AuthenticationRepository repository;

  @override
  Future<bool> call(NoParams params) async => await repository.isAuth();
}
