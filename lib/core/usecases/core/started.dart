import 'package:injectable/injectable.dart';
import 'package:nexus/core/storage/storage_impl.dart';
import 'package:nexus/core/usecases/usecases.dart';

@lazySingleton
class StartedUsecase extends Usecase<void, NoParams> {
  StartedUsecase({
    required this.storage,
  });

  final Storage storage;

  @override
  Future<void> call(NoParams params) async => await storage.started();
}
