import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';
import 'package:dartz/dartz.dart';
import 'package:nexus/core/constant.dart';
import 'package:nexus/core/network/formatter.dart';
import 'package:nexus/core/network/remote.dart';
import 'package:nexus/core/storage/storage_impl.dart';
import 'package:nexus/features/auth/data/data-sources/remote-datasource/auth_remote.dart';
import 'package:nexus/features/home/domain/repositories/repo.dart';
import '../../../../core/models/user.dart';

@LazySingleton(as: HomeRepository)
class HomeRepositoryImpl implements HomeRepository {
  HomeRepositoryImpl({
    required this.remote,
    required this.formatter,
    required this.storage,
    required this.generalRemote,
  });

  final AuthenticationRemoteDatasource remote;
  final GeneralRemote generalRemote;
  final MyFormatter formatter;
  final Storage storage;

  @override
  Future<Either<void, List<UserModel>>> getUsers() async {
    var res = await formatter.firestorFmt(() async {
      var firestore = await generalRemote.firebaseFirestore();
      var curUser = FirebaseAuth.instance.currentUser;
      return await firestore
          .collection(kUSER_KEY)
          .where('id', isNotEqualTo: curUser!.uid)
          .get();
    });

    return res.fold((l) => Left(l), (r) {
      var data = r as QuerySnapshot<Map<String, dynamic>>;
      var list = <UserModel>[];

      for (var dm in data.docChanges) {
        list.add(UserModel.fromJson(dm.doc.data()!));
      }

      return Right(list);
    });
  }
}
