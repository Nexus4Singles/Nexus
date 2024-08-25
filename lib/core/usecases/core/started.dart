import 'package:injectable/injectable.dart';
import '../../storage/storage_impl.dart';
import '../usecases.dart';

@lazySingleton
class StartedUsecase extends Usecase<void, NoParams> {
  StartedUsecase({
    required this.storage,
  });

  final Storage storage;

  @override
  Future<void> call(NoParams params) async => await storage.started();
}
