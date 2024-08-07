import 'package:injectable/injectable.dart';
import 'package:Nexus/core/storage/storage_impl.dart';
import 'package:Nexus/core/usecases/usecases.dart';

import '../../models/user.dart';

@lazySingleton
class SaveUserUsecase extends Usecase<void, UserModel> {
  SaveUserUsecase({
    required this.storage,
  });

  final Storage storage;

  @override
  Future<void> call(UserModel params) async => await storage.saveUser(params);
}
