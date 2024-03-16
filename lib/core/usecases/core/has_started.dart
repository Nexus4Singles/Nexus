import 'package:injectable/injectable.dart';
import 'package:nexus/core/storage/storage_impl.dart';
import 'package:nexus/core/usecases/usecases.dart';

@lazySingleton
class HasStratedUsecase extends Usecase<void, NoParams> {
  HasStratedUsecase({
    required this.storage,
  });

  final Storage storage;

  @override
  Future<bool> call(NoParams params) async => await storage.hasStarted();
}
