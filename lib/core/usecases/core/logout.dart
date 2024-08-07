import 'package:Nexus/features/auth/domain/repositories/auth_repo.dart';
import 'package:injectable/injectable.dart';
import 'package:Nexus/core/usecases/usecases.dart';

@lazySingleton
class LogoutUsecase extends Usecase<void, NoParams> {
  LogoutUsecase({
    required this.repository,
  });

  final AuthenticationRepository repository;

  @override
  Future<void> call(NoParams params) async => await repository.logout();
}
