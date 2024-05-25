// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:cloud_firestore/cloud_firestore.dart' as _i6;
import 'package:cloudinary_public/cloudinary_public.dart' as _i4;
import 'package:firebase_auth/firebase_auth.dart' as _i5;
import 'package:flutter_secure_storage/flutter_secure_storage.dart' as _i7;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:internet_connection_checker/internet_connection_checker.dart'
    as _i8;
import 'package:shared_preferences/shared_preferences.dart' as _i10;
import 'package:uuid/uuid.dart' as _i11;

import '../../features/auth/data/data-sources/local-datasource/auth_local.dart'
    as _i3;
import '../../features/auth/data/data-sources/remote-datasource/auth_remote.dart'
    as _i16;
import '../../features/auth/data/repo/auth_repo_impl.dart' as _i25;
import '../../features/auth/domain/repositories/auth_repo.dart' as _i24;
import '../../features/auth/domain/usecases/is_auth.dart' as _i28;
import '../../features/auth/domain/usecases/login.dart' as _i30;
import '../../features/auth/domain/usecases/login_google.dart' as _i29;
import '../../features/auth/domain/usecases/profile.dart' as _i32;
import '../../features/auth/domain/usecases/register.dart' as _i33;
import '../../features/auth/domain/usecases/register_google.dart' as _i34;
import '../../features/auth/domain/usecases/update_profile.dart' as _i35;
import '../../features/auth/presentation/change_notifier/auth_notifier.dart'
    as _i36;
import '../../features/home/data/repositories/repo_imple.dart' as _i21;
import '../../features/home/domain/repositories/repo.dart' as _i20;
import '../../features/home/domain/usecases/get_users.dart' as _i27;
import '../../features/home/domain/usecases/get_users_filterable.dart' as _i26;
import '../../features/home/presentation/change_notifier/home_notifier.dart'
    as _i37;
import '../network/client.dart' as _i14;
import '../network/formatter.dart' as _i13;
import '../network/network_info.dart' as _i9;
import '../network/remote.dart' as _i17;
import '../storage/storage.dart' as _i12;
import '../storage/storage_impl.dart' as _i15;
import '../usecases/core/get_user.dart' as _i18;
import '../usecases/core/has_started.dart' as _i19;
import '../usecases/core/logout.dart' as _i31;
import '../usecases/core/save_user.dart' as _i22;
import '../usecases/core/started.dart' as _i23;
import 'register_module.dart' as _i38;

// initializes the registration of main-scope dependencies inside of GetIt
Future<_i1.GetIt> init(
  _i1.GetIt getIt, {
  String? environment,
  _i2.EnvironmentFilter? environmentFilter,
}) async {
  final gh = _i2.GetItHelper(
    getIt,
    environment,
    environmentFilter,
  );
  final registerModule = _$RegisterModule();
  gh.lazySingleton<_i3.AuthenticationLocalDatasource>(
      () => _i3.AuthenticationLocalDatasourceImpl());
  gh.lazySingleton<_i4.CloudinaryPublic>(() => registerModule.cloudinary);
  gh.lazySingleton<_i5.FirebaseAuth>(() => registerModule.auth);
  gh.lazySingleton<_i6.FirebaseFirestore>(() => registerModule.firestore);
  gh.lazySingleton<_i7.FlutterSecureStorage>(
      () => registerModule.secureStorage);
  gh.lazySingleton<_i8.InternetConnectionChecker>(
      () => registerModule.internetConnectionChecker);
  gh.lazySingleton<_i9.NetworkInfo>(() => _i9.NetworkInfoImpl());
  await gh.factoryAsync<_i10.SharedPreferences>(
    () => registerModule.prefs,
    preResolve: true,
  );
  gh.lazySingleton<_i11.Uuid>(() => registerModule.uuid);
  gh.lazySingleton<_i12.FSS>(() => _i12.FSSImpl(
        secureStorage: gh<_i7.FlutterSecureStorage>(),
        preferences: gh<_i10.SharedPreferences>(),
      ));
  gh.lazySingleton<_i13.MyFormatter>(
      () => _i13.MyFormatterImpl(networkInfo: gh<_i9.NetworkInfo>()));
  gh.lazySingleton<_i14.MyNetwork>(() => _i14.MyNetworkImpl(
        auth: gh<_i5.FirebaseAuth>(),
        uuid: gh<_i11.Uuid>(),
        firestore: gh<_i6.FirebaseFirestore>(),
      ));
  gh.lazySingleton<_i15.Storage>(() => _i15.StorageImpl(fss: gh<_i12.FSS>()));
  gh.lazySingleton<_i16.AuthenticationRemoteDatasource>(
      () => _i16.AuthenticationRemoteDatasourceImpl(
            network: gh<_i14.MyNetwork>(),
            cloudinary: gh<_i4.CloudinaryPublic>(),
          ));
  gh.lazySingleton<_i17.GeneralRemote>(
      () => _i17.GeneralRemoteImpl(network: gh<_i14.MyNetwork>()));
  gh.lazySingleton<_i18.GetUserUsecase>(
      () => _i18.GetUserUsecase(storage: gh<_i15.Storage>()));
  gh.lazySingleton<_i19.HasStratedUsecase>(
      () => _i19.HasStratedUsecase(storage: gh<_i15.Storage>()));
  gh.lazySingleton<_i20.HomeRepository>(() => _i21.HomeRepositoryImpl(
        remote: gh<_i16.AuthenticationRemoteDatasource>(),
        formatter: gh<_i13.MyFormatter>(),
        storage: gh<_i15.Storage>(),
        generalRemote: gh<_i17.GeneralRemote>(),
      ));
  gh.lazySingleton<_i22.SaveUserUsecase>(
      () => _i22.SaveUserUsecase(storage: gh<_i15.Storage>()));
  gh.lazySingleton<_i23.StartedUsecase>(
      () => _i23.StartedUsecase(storage: gh<_i15.Storage>()));
  gh.lazySingleton<_i24.AuthenticationRepository>(
      () => _i25.AuthenticationRepositoryImpl(
            remote: gh<_i16.AuthenticationRemoteDatasource>(),
            formatter: gh<_i13.MyFormatter>(),
            storage: gh<_i15.Storage>(),
            generalRemote: gh<_i17.GeneralRemote>(),
            uuid: gh<_i11.Uuid>(),
          ));
  gh.lazySingleton<_i26.GetUsersFilterableUseCase>(() =>
      _i26.GetUsersFilterableUseCase(repository: gh<_i20.HomeRepository>()));
  gh.lazySingleton<_i27.GetUsersUsecase>(
      () => _i27.GetUsersUsecase(repository: gh<_i20.HomeRepository>()));
  gh.lazySingleton<_i28.IsAuthUsecase>(() =>
      _i28.IsAuthUsecase(repository: gh<_i24.AuthenticationRepository>()));
  gh.lazySingleton<_i29.LoginGoogleUsecase>(() =>
      _i29.LoginGoogleUsecase(repository: gh<_i24.AuthenticationRepository>()));
  gh.lazySingleton<_i30.LoginUsecase>(
      () => _i30.LoginUsecase(repository: gh<_i24.AuthenticationRepository>()));
  gh.lazySingleton<_i31.LogoutUsecase>(() =>
      _i31.LogoutUsecase(repository: gh<_i24.AuthenticationRepository>()));
  gh.lazySingleton<_i32.ReadProfileUsecase>(() =>
      _i32.ReadProfileUsecase(repository: gh<_i24.AuthenticationRepository>()));
  gh.lazySingleton<_i33.RegisterUsecase>(() =>
      _i33.RegisterUsecase(repository: gh<_i24.AuthenticationRepository>()));
  gh.lazySingleton<_i34.RegisterWithGoogleUsecase>(() =>
      _i34.RegisterWithGoogleUsecase(
          repository: gh<_i24.AuthenticationRepository>()));
  gh.lazySingleton<_i35.UpdateProfileUsecase>(() => _i35.UpdateProfileUsecase(
      repository: gh<_i24.AuthenticationRepository>()));
  gh.factory<_i36.AuthNotifier>(() => _i36.AuthNotifier(
        startedUsecase: gh<_i23.StartedUsecase>(),
        hasStratedUsecase: gh<_i19.HasStratedUsecase>(),
        loginUsecase: gh<_i30.LoginUsecase>(),
        registerUsecase: gh<_i33.RegisterUsecase>(),
        isAuthUsecase: gh<_i28.IsAuthUsecase>(),
        logoutUsecase: gh<_i31.LogoutUsecase>(),
        readProfileUsecase: gh<_i32.ReadProfileUsecase>(),
        updateProfileUsecase: gh<_i35.UpdateProfileUsecase>(),
        remote: gh<_i16.AuthenticationRemoteDatasource>(),
        formatter: gh<_i13.MyFormatter>(),
      ));
  gh.factory<_i37.HomeNotifier>(() => _i37.HomeNotifier(
        remote: gh<_i16.AuthenticationRemoteDatasource>(),
        getUsersUsecase: gh<_i27.GetUsersUsecase>(),
        getUsersFilterableUsecase: gh<_i26.GetUsersFilterableUseCase>(),
        readProfileUsecase: gh<_i32.ReadProfileUsecase>(),
      ));
  return getIt;
}

class _$RegisterModule extends _i38.RegisterModule {}
