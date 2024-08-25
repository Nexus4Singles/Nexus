import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:Nexus/core/models/user.dart';
import 'package:Nexus/core/usecases/usecases.dart';
import 'package:Nexus/core/utils/app_logger.dart';
import 'package:Nexus/features/auth/data/data-sources/remote-datasource/auth_remote.dart';
import 'package:Nexus/features/auth/domain/usecases/profile.dart';
import 'package:Nexus/features/home/domain/usecases/get_users.dart';
import 'package:Nexus/features/home/domain/usecases/get_users_filterable.dart';

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
