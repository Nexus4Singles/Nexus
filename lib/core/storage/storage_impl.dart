import 'dart:convert';
import 'package:injectable/injectable.dart';
import '../constant.dart';
import '../models/user.dart';
import 'storage.dart';

abstract class Storage {
  Future<void> started();
  Future<bool> hasStarted();
  Future<void> saveUser(UserModel um);
  Future<UserModel> getUser();
  Future<void> logout();
  Future<void> init();
  Future<bool> isAuth();
}

@LazySingleton(as: Storage)
class StorageImpl extends Storage {
  StorageImpl({
    required this.fss,
  });

  final FSS fss;

  @override
  Future<UserModel> getUser() async {
    var data = await fss.read(key: kUSER);

    return UserModel.fromJson(jsonDecode(data));
  }

  @override
  Future<bool> hasStarted() async => await fss.contains(key: kGS);

  @override
  Future<void> saveUser(UserModel um) async =>
      await fss.write(key: kUSER, value: jsonEncode(um.toJson()));

  @override
  Future<void> started() async {
    await init();

    await fss.write(key: kGS, value: 'true');
  }

  @override
  Future<void> logout() async {
    await fss.delete(key: kUSER);
  }

  @override
  Future<bool> isAuth() async {
    await init();

    return await fss.contains(key: kUSER);
  }

  @override
  Future<void> init() async {
    await fss.init();
  }
}
