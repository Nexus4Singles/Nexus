import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
// import 'package:logger/logger.dart';
import 'package:nexus/core/models/user.dart';
import 'package:nexus/core/usecases/usecases.dart';
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
    // getUsersUsecase.call(const NoParams()).then((value) {
    //   value.fold((l) => l, (r) {
    //     allUsers = users = r
    //         .where((e) => e.gender != currentUser!.gender)
    //         .where((el) => el.registrationProgress == 'completed')
    //         .toList();

    //     notifyListeners();
    //     // Logger().d(allUsers);
    //   });
    // });

    final filterParams = UserFilterParams(
      user: currentUser!,
    );

    final result = await getUsersFilterableUsecase.call(filterParams);

    result.fold(
      (error) {
        // Handle the error case
        print('Error occurred');
      },
      (userList) {
        allUsers = users = userList.toList();
        print(allUsers);
        notifyListeners();
      },
    );
  }

  UserModel? currentUser;

  Future<void> getProfile() async {
    var data = await readProfileUsecase.call(const NoParams());
    data.fold(
      (l) => l,
      (r) {
        currentUser = r;
        getUsers();
        notifyListeners();
      },
    );
  }

  UserModel? selectedUser;
}
