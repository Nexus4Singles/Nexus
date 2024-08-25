import 'package:injectable/injectable.dart';
import '../../models/user.dart';
import '../../storage/storage_impl.dart';
import '../usecases.dart';

@lazySingleton
class SaveUserUsecase extends Usecase<void, UserModel> {
  SaveUserUsecase({
    required this.storage,
  });

  final Storage storage;

  @override
  Future<void> call(UserModel params) async => await storage.saveUser(params);
}
