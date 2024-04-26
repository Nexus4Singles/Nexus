import 'package:nexus/core/models/user.dart';
import 'package:nexus/core/network/remote.dart';
import 'package:injectable/injectable.dart';
import 'package:nexus/core/constant.dart';

import 'package:firebase_auth/firebase_auth.dart';

import 'package:dartz/dartz.dart';
import 'package:nexus/core/network/formatter.dart';
import 'package:nexus/core/storage/storage_impl.dart';
import 'package:logger/logger.dart';
import 'package:nexus/features/auth/domain/repositories/auth_repo.dart';
import 'package:uuid/uuid.dart';

import '../data-sources/remote-datasource/auth_remote.dart';

@LazySingleton(as: AuthenticationRepository)
class AuthenticationRepositoryImpl implements AuthenticationRepository {
  AuthenticationRepositoryImpl({
    required this.remote,
    required this.formatter,
    required this.storage,
    required this.generalRemote,
    required this.uuid,
  });

  final AuthenticationRemoteDatasource remote;
  final GeneralRemote generalRemote;
  final MyFormatter formatter;
  final Storage storage;
  final Uuid uuid;

  @override
  Future<Either<void, UserModel>> login(Map<String, dynamic> map) async {
    var res = await formatter.firebaseAuthFmt(() async {
      var user = (await remote.login(map)) as User;

      // call firestore collections
      var data = await remote.read(kUSER_KEY, user.uid);

      await storage.saveUser(UserModel.fromJson(data));

      return UserModel.fromJson(data);
    });

    return res.fold((l) => Left(l), (r) => Right(r));
  }

  @override
  Future<Either<void, UserModel>> loginWithGoogle(
      AuthCredential credential) async {
    var res = await formatter.googleFmt(() async {
      var user = (await remote.loginWithGoogle(credential)) as User;

      // call firestore collections
      var data = await remote.read(kUSER_KEY, user.uid);
      await storage.saveUser(UserModel.fromJson(data));

      return UserModel.fromJson(data);
    });

    return res.fold((l) => Left(l), (r) => Right(r));
  }

  @override
  Future<Either<void, UserModel>> register(Map<String, dynamic> map) async {
    var res = await formatter.firebaseAuthFmt(() async {
      var user = (await remote.register(map)) as User;

      map.putIfAbsent(kID, () => user.uid);
      map.remove(kPASSWORD);

      // write the user data to firestore
      await remote.write(kUSER_KEY, user.uid, map);

      await storage.saveUser(UserModel.fromJson(map));

      return UserModel.fromJson(map);
    });

    return res.fold((l) => Left(l), (r) => Right(r));
  }

  @override
  Future<Either<void, bool>> updateProfile(Map<String, dynamic> map) async {
    var res = await formatter.firestorFmt(() async {
      FirebaseAuth auth = FirebaseAuth.instance;

      // write the user data to firestore
      await remote.update(kUSER_KEY, map);
      var user = remote.read(kUSER_KEY, auth.currentUser!.uid);
      // await storage.saveUser(UserModel.fromJson(user));
      Logger().d(user);
      return true;
    });

    return res.fold((l) => Left(l), (r) => Right(r));
  }

  @override
  Future<Either<void, UserModel>> registerWithGoogle(
      AuthCredential credential, Map<String, dynamic> map) async {
    var res = await formatter.firebaseAuthFmt(() async {
      var user = (await remote.registerWithGoogle(credential)) as User;

      // if (map[kLICENSE].toString().isNotEmpty) {
      //   var url = await remote.upload(File(map[kLICENSE]));
      //   map.update(kLICENSE, (_) => url);
      // }

      map.putIfAbsent(kID, () => user.uid);
      map.remove(kPASSWORD);

      // write the user data to firestore
      await remote.write(kUSER_KEY, user.uid, map);

      await storage.saveUser(UserModel.fromJson(map));

      return UserModel.fromJson(map);
    });

    return res.fold((l) => Left(l), (r) => Right(r));
  }

  @override
  Future<void> logout() async {
    await storage.logout();
    await remote.logout();
  }

  @override
  Future<bool> isAuth() async => await storage.isAuth();

  @override
  Future<Either<void, UserModel>> readProfile() async {
    var res = await formatter.firebaseAuthFmt(() async {
      return await remote.read('', '');
    });

    return res.fold((l) => Left(l), (r) {
      return Right(UserModel.fromJson(r));
    });
  }
}
