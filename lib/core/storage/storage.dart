import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class FSS {
  Future write({required String key, required dynamic value});
  Future read({required String key});
  Future<void> delete({required String key});
  Future<bool> contains({required String key});
  Future<void> init();
}

@LazySingleton(as: FSS)
class FSSImpl extends FSS {
  FSSImpl({
    required this.secureStorage,
    required this.preferences,
  });

  final FlutterSecureStorage secureStorage;
  final SharedPreferences preferences;

  @override
  Future<bool> contains({required String key}) async {
    var dta = await secureStorage.read(key: key);

    return dta != null;
  }

  @override
  Future<void> delete({required String key}) async {
    await secureStorage.delete(key: key);
  }

  @override
  Future read({required String key}) async {
    return await secureStorage.read(key: key);
  }

  @override
  Future write({required String key, required value}) async {
    return await secureStorage.write(key: key, value: value);
  }

  @override
  Future<void> init() async {
    if (!preferences.containsKey('DRUGMAP')) {
      secureStorage.deleteAll();

      preferences.setString('DRUGMAP', 'DRUGMAP');
    }
  }
}
