import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
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
  bool isLoading = false;

  UserModel? currentUser;

  Future<void> getProfile() async {
    // const cacheKey = 'userProfile';
    // final fileInfo =
    //     await CustomCacheManager.instance.getFileFromCache(cacheKey);
    // if (fileInfo != null) {
    //   final fileContent = await fileInfo.file.readAsString();
    //   return jsonDecode(fileContent);
    // }
    var data = await readProfileUsecase.call(const NoParams());
    data.fold(
      (l) => l,
      (r) {
        currentUser = r;
        appLog("user", currentUser);
        notifyListeners();
      },
    );
  }

  UserModel? selectedUser;
}
