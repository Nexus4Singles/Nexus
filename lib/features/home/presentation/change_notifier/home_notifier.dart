import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:injectable/injectable.dart';
// import 'package:logger/logger.dart';
import 'package:nexus/core/models/user.dart';
import 'package:nexus/core/storage/cache_service.dart';
import 'package:nexus/core/usecases/usecases.dart';
import 'package:nexus/core/utils/app_logger.dart';
import 'package:nexus/features/auth/data/data-sources/remote-datasource/auth_remote.dart';
import 'package:nexus/features/auth/domain/usecases/profile.dart';
import 'package:nexus/features/home/domain/usecases/get_users.dart';
import 'package:nexus/features/home/domain/usecases/get_users_filterable.dart';

@injectable
class HomeNotifier with ChangeNotifier {
  HomeNotifier({
    required this.remote,
    required this.getUsersUsecase,
    required this.getUsersFilterableUsecase,
    required this.readProfileUsecase,
  });

  final GetUsersUsecase getUsersUsecase;
  final GetUsersFilterableUseCase getUsersFilterableUsecase;
  final AuthenticationRemoteDatasource remote;
  final ReadProfileUsecase readProfileUsecase;

  List<UserModel> users = [];
  List<UserModel> allUsers = [];
  List<UserModel> filteredUsers = [];

  Future<void> getUsers() async {
    getUsersUsecase.call(const NoParams()).then((value) {
      value.fold((l) => l, (r) {
        var unrecommendedUsers = <String>[];
        var matchedUsers = <String>[];
        var savedUsers = <String>[];
        var likedUsers = <String>[];
        unrecommendedUsers.assignAll(currentUser!.unrecommendedUsers ?? []);
        matchedUsers.assignAll(currentUser!.matchedUsers ?? []);
        savedUsers.assignAll(currentUser!.mySaves ?? []);
        likedUsers.assignAll(currentUser!.myLikes ?? []);
        allUsers = users = r
            .where((e) => e.gender != currentUser!.gender)
            .where((el) => el.registrationProgress == 'completed')
            .where((data) => !matchedUsers.contains(data.id))
            .where((data) => !savedUsers.contains(data.id))
            .where((data) => !likedUsers.contains(data.id))
            .where((u) => !unrecommendedUsers.contains(u.id))
            .toList();
        allUsers.shuffle();
        print("THis is the lenght of all users ${allUsers.length}");
        notifyListeners();
      });
    });
  }

  UserModel? currentUser;

  Future<void> getProfile() async {
    const cacheKey = 'userProfile';
    final fileInfo =
        await CustomCacheManager.instance.getFileFromCache(cacheKey);
    if (fileInfo != null) {
      final fileContent = await fileInfo.file.readAsString();
      return jsonDecode(fileContent);
    }
    var data = await readProfileUsecase.call(const NoParams());
    data.fold(
      (l) => l,
      (r) {
        currentUser = r;
        appLog("user", currentUser);
        getUsers();
        notifyListeners();
      },
    );
  }

  UserModel? selectedUser;
}
