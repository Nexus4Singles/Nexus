import 'package:injectable/injectable.dart';

import '../../models/user.dart';
import '../../storage/storage_impl.dart';
import '../usecases.dart';

@lazySingleton
class GetUserUsecase extends Usecase<void, NoParams> {
  GetUserUsecase({
    required this.storage,
  });

  final Storage storage;

  @override
  Future<UserModel> call(NoParams params) async => await storage.getUser();
}
