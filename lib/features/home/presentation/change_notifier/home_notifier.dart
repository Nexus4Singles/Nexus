import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:injectable/injectable.dart';
// import 'package:logger/logger.dart';
import 'package:nexus/core/models/user.dart';
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
        unrecommendedUsers.assignAll(currentUser!.unrecommendedUsers ?? []);
        allUsers = users = r
            .where((e) => e.gender != currentUser!.gender)
            .where((el) => el.registrationProgress == 'completed')
            .where((u) => !unrecommendedUsers.contains(u.id))
            .toList();
        allUsers.shuffle();
        notifyListeners();
      });
    });
  }

  UserModel? currentUser;

  Future<void> getProfile() async {
    print("called again");
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

  Future<UserModel?> getUser() async {
    var data = await readProfileUsecase.call(const NoParams());
    data.fold(
      (l) => l,
      (r) {
        currentUser = r;
        notifyListeners();
      },
    );

    return currentUser;
  }

  UserModel? selectedUser;
}
