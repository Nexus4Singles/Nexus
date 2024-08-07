import 'package:injectable/injectable.dart';
import 'package:Nexus/core/storage/storage_impl.dart';
import 'package:Nexus/core/usecases/usecases.dart';

import '../../models/user.dart';

@lazySingleton
class GetUserUsecase extends Usecase<void, NoParams> {
  GetUserUsecase({
    required this.storage,
  });

  final Storage storage;

  @override
  Future<UserModel> call(NoParams params) async => await storage.getUser();
}
