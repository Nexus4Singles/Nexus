import 'package:injectable/injectable.dart';

import '../../../../core/usecases/usecases.dart';
import '../repositories/auth_repo.dart';

@lazySingleton
class IsAuthUsecase extends Usecase<void, NoParams> {
  IsAuthUsecase({
    required this.repository,
  });

  final AuthenticationRepository repository;

  @override
  Future<bool> call(NoParams params) async => await repository.isAuth();
}
