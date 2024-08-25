import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';
import 'package:dartz/dartz.dart';
import 'package:Nexus/core/constant.dart';
import 'package:Nexus/core/network/formatter.dart';
import 'package:Nexus/core/network/remote.dart';
import 'package:Nexus/core/storage/storage_impl.dart';
import 'package:Nexus/features/auth/data/data-sources/remote-datasource/auth_remote.dart';
import 'package:Nexus/features/home/domain/repositories/repo.dart';
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

  @override
  Future<Either<void, List<UserModel>>> getUsersFilterable(
      {required UserModel user}) async {
    var curUser = FirebaseAuth.instance.currentUser;

    var gender = user.gender;
    var country = user.country;
    var similarHobbies = user.hobbies;
    var similarDesiredQualities = user.desiredQualities;
    var city = user.location!.city;
    var churchName = user.churchName;
    var oppositeGender = gender == 'Male' ? 'Female' : 'Male';
    int maxAge = user.age + (user.gender == 'Male' ? 3 : 8);
    int minAge = user.age - (user.gender == 'Male' ? 10 : 3);

    // female -> 3
    // male -> 8

    var res = await formatter.firestorFmt(() async {
      var firestore = await generalRemote.firebaseFirestore();
      var query = firestore
          .collection(kUSER_KEY)
          // .where('id', isNotEqualTo: curUser!.uid);
          .where('registration_progress', isEqualTo: 'completed')
          .where('age', isGreaterThanOrEqualTo: minAge)
          .where('age', isLessThanOrEqualTo: maxAge);

      if (country != null) {
        query = query.where('country', isEqualTo: country);
      }
      // if (minAge != null) {
      //   query = query.where('age', isGreaterThanOrEqualTo: minAge);
      // }
      // query = query.where('age', isLessThanOrEqualTo: maxAge);
      query = query.where('gender', isEqualTo: oppositeGender);

      var result = await query.get();
      return result;
    });

    return res.fold((l) => Left(l), (r) {
      var data = r as QuerySnapshot<Map<String, dynamic>>;
      var list = <UserModel>[];

      for (var doc in data.docs) {
        var user = UserModel.fromJson(doc.data());
        if (user.id == curUser!.uid) {
          continue;
        }
        // minAge
        // var matchesHobbies = similarHobbies == null ||
        //     similarHobbies.isEmpty ||
        //     user.hobbies!.any((hobby) => similarHobbies.contains(hobby));
        // var matchesQualities = similarDesiredQualities == null ||
        //     similarDesiredQualities.isEmpty ||
        //     user.desiredQualities!
        //         .any((quality) => similarDesiredQualities.contains(quality));

        // if (matchesHobbies && matchesQualities) {
        //   list.add(user);
        // }

        list.add(user);
      }

      // Sorting logic (based on the priority mentioned)
      list.sort((a, b) {
        int compareCity =
            (a.city == city ? 0 : 1).compareTo(b.city == city ? 0 : 1);
        int compareAge = a.age.compareTo(b.age);
        int compareChurch = (a.churchName == churchName ? 0 : 1)
            .compareTo(b.churchName == churchName ? 0 : 1);
        int compareHobbies = (a.hobbies != null &&
                    similarHobbies != null &&
                    a.hobbies!.any((hobby) => similarHobbies.contains(hobby))
                ? 0
                : 1)
            .compareTo(b.hobbies != null &&
                    similarHobbies != null &&
                    b.hobbies!.any((hobby) => similarHobbies.contains(hobby))
                ? 0
                : 1);
        int compareQualities = (a.desiredQualities != null &&
                    similarDesiredQualities != null &&
                    a.desiredQualities!.any(
                        (quality) => similarDesiredQualities.contains(quality))
                ? 0
                : 1)
            .compareTo(b.desiredQualities != null &&
                    similarDesiredQualities != null &&
                    b.desiredQualities!.any(
                        (quality) => similarDesiredQualities.contains(quality))
                ? 0
                : 1);

        return compareCity != 0
            ? compareCity
            : compareAge != 0
                ? compareAge
                : compareChurch != 0
                    ? compareChurch
                    : compareHobbies != 0
                        ? compareHobbies
                        : compareQualities;
      });

      return Right(list);
    });
  }
}
