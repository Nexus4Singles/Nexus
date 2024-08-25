import 'package:injectable/injectable.dart';
import '../../../features/auth/domain/repositories/auth_repo.dart';
import '../usecases.dart';

@lazySingleton
class LogoutUsecase extends Usecase<void, NoParams> {
  LogoutUsecase({
    required this.repository,
  });

  final AuthenticationRepository repository;

  @override
  Future<void> call(NoParams params) async => await repository.logout();
}
