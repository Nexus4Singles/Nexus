// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:cloud_firestore/cloud_firestore.dart' as _i7;
import 'package:cloudinary_public/cloudinary_public.dart' as _i8;
import 'package:firebase_auth/firebase_auth.dart' as _i6;
import 'package:flutter_secure_storage/flutter_secure_storage.dart' as _i5;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:internet_connection_checker/internet_connection_checker.dart'
    as _i4;
import 'package:shared_preferences/shared_preferences.dart' as _i3;
import 'package:uuid/uuid.dart' as _i9;

import '../../features/auth/data/data-sources/local-datasource/auth_local.dart'
    as _i12;
import '../../features/auth/data/data-sources/remote-datasource/auth_remote.dart'
    as _i16;
import '../../features/auth/data/repo/auth_repo_impl.dart' as _i19;
import '../../features/auth/domain/repositories/auth_repo.dart' as _i18;
import '../../features/auth/domain/usecases/is_auth.dart' as _i23;
import '../../features/auth/domain/usecases/login.dart' as _i24;
import '../../features/auth/domain/usecases/login_google.dart' as _i26;
import '../../features/auth/domain/usecases/profile.dart' as _i22;
import '../../features/auth/domain/usecases/register.dart' as _i25;
import '../../features/auth/domain/usecases/register_google.dart' as _i27;
import '../../features/auth/domain/usecases/update_profile.dart' as _i21;
import '../../features/auth/presentation/change_notifier/auth_notifier.dart'
    as _i34;
import '../../features/home/data/repositories/repo_imple.dart' as _i29;
import '../../features/home/domain/repositories/repo.dart' as _i28;
import '../../features/home/domain/usecases/get_users.dart' as _i35;
import '../../features/home/domain/usecases/get_users_filterable.dart' as _i36;
import '../../features/home/presentation/change_notifier/home_notifier.dart'
    as _i37;
import '../network/client.dart' as _i11;
import '../network/formatter.dart' as _i15;
import '../network/network_info.dart' as _i10;
import '../network/remote.dart' as _i13;
import '../storage/storage.dart' as _i14;
import '../storage/storage_impl.dart' as _i17;
import '../usecases/core/get_user.dart' as _i32;
import '../usecases/core/has_started.dart' as _i31;
import '../usecases/core/logout.dart' as _i20;
import '../usecases/core/save_user.dart' as _i33;
import '../usecases/core/started.dart' as _i30;
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
  await gh.factoryAsync<_i3.SharedPreferences>(
    () => registerModule.prefs,
    preResolve: true,
  );
  gh.lazySingleton<_i4.InternetConnectionChecker>(
      () => registerModule.internetConnectionChecker);
  gh.lazySingleton<_i5.FlutterSecureStorage>(
      () => registerModule.secureStorage);
  gh.lazySingleton<_i6.FirebaseAuth>(() => registerModule.auth);
  gh.lazySingleton<_i7.FirebaseFirestore>(() => registerModule.firestore);
  gh.lazySingleton<_i8.CloudinaryPublic>(() => registerModule.cloudinary);
  gh.lazySingleton<_i9.Uuid>(() => registerModule.uuid);
  gh.lazySingleton<_i10.NetworkInfo>(() => _i10.NetworkInfoImpl());
  gh.lazySingleton<_i11.MyNetwork>(() => _i11.MyNetworkImpl(
        auth: gh<_i6.FirebaseAuth>(),
        uuid: gh<_i9.Uuid>(),
        firestore: gh<_i7.FirebaseFirestore>(),
      ));
  gh.lazySingleton<_i12.AuthenticationLocalDatasource>(
      () => _i12.AuthenticationLocalDatasourceImpl());
  gh.lazySingleton<_i13.GeneralRemote>(
      () => _i13.GeneralRemoteImpl(network: gh<_i11.MyNetwork>()));
  gh.lazySingleton<_i14.FSS>(() => _i14.FSSImpl(
        secureStorage: gh<_i5.FlutterSecureStorage>(),
        preferences: gh<_i3.SharedPreferences>(),
      ));
  gh.lazySingleton<_i15.MyFormatter>(
      () => _i15.MyFormatterImpl(networkInfo: gh<_i10.NetworkInfo>()));
  gh.lazySingleton<_i16.AuthenticationRemoteDatasource>(
      () => _i16.AuthenticationRemoteDatasourceImpl(
            network: gh<_i11.MyNetwork>(),
            cloudinary: gh<_i8.CloudinaryPublic>(),
          ));
  gh.lazySingleton<_i17.Storage>(() => _i17.StorageImpl(fss: gh<_i14.FSS>()));
  gh.lazySingleton<_i18.AuthenticationRepository>(
      () => _i19.AuthenticationRepositoryImpl(
            remote: gh<_i16.AuthenticationRemoteDatasource>(),
            formatter: gh<_i15.MyFormatter>(),
            storage: gh<_i17.Storage>(),
            generalRemote: gh<_i13.GeneralRemote>(),
            uuid: gh<_i9.Uuid>(),
          ));
  gh.lazySingleton<_i20.LogoutUsecase>(() =>
      _i20.LogoutUsecase(repository: gh<_i18.AuthenticationRepository>()));
  gh.lazySingleton<_i21.UpdateProfileUsecase>(() => _i21.UpdateProfileUsecase(
      repository: gh<_i18.AuthenticationRepository>()));
  gh.lazySingleton<_i22.ReadProfileUsecase>(() =>
      _i22.ReadProfileUsecase(repository: gh<_i18.AuthenticationRepository>()));
  gh.lazySingleton<_i23.IsAuthUsecase>(() =>
      _i23.IsAuthUsecase(repository: gh<_i18.AuthenticationRepository>()));
  gh.lazySingleton<_i24.LoginUsecase>(
      () => _i24.LoginUsecase(repository: gh<_i18.AuthenticationRepository>()));
  gh.lazySingleton<_i25.RegisterUsecase>(() =>
      _i25.RegisterUsecase(repository: gh<_i18.AuthenticationRepository>()));
  gh.lazySingleton<_i26.LoginGoogleUsecase>(() =>
      _i26.LoginGoogleUsecase(repository: gh<_i18.AuthenticationRepository>()));
  gh.lazySingleton<_i27.RegisterWithGoogleUsecase>(() =>
      _i27.RegisterWithGoogleUsecase(
          repository: gh<_i18.AuthenticationRepository>()));
  gh.lazySingleton<_i28.HomeRepository>(() => _i29.HomeRepositoryImpl(
        remote: gh<_i16.AuthenticationRemoteDatasource>(),
        formatter: gh<_i15.MyFormatter>(),
        storage: gh<_i17.Storage>(),
        generalRemote: gh<_i13.GeneralRemote>(),
      ));
  gh.lazySingleton<_i30.StartedUsecase>(
      () => _i30.StartedUsecase(storage: gh<_i17.Storage>()));
  gh.lazySingleton<_i31.HasStratedUsecase>(
      () => _i31.HasStratedUsecase(storage: gh<_i17.Storage>()));
  gh.lazySingleton<_i32.GetUserUsecase>(
      () => _i32.GetUserUsecase(storage: gh<_i17.Storage>()));
  gh.lazySingleton<_i33.SaveUserUsecase>(
      () => _i33.SaveUserUsecase(storage: gh<_i17.Storage>()));
  gh.factory<_i34.AuthNotifier>(() => _i34.AuthNotifier(
        startedUsecase: gh<_i30.StartedUsecase>(),
        hasStratedUsecase: gh<_i31.HasStratedUsecase>(),
        loginUsecase: gh<_i24.LoginUsecase>(),
        registerUsecase: gh<_i25.RegisterUsecase>(),
        isAuthUsecase: gh<_i23.IsAuthUsecase>(),
        logoutUsecase: gh<_i20.LogoutUsecase>(),
        readProfileUsecase: gh<_i22.ReadProfileUsecase>(),
        updateProfileUsecase: gh<_i21.UpdateProfileUsecase>(),
        remote: gh<_i16.AuthenticationRemoteDatasource>(),
        formatter: gh<_i15.MyFormatter>(),
      ));
  gh.lazySingleton<_i35.GetUsersUsecase>(
      () => _i35.GetUsersUsecase(repository: gh<_i28.HomeRepository>()));
  gh.lazySingleton<_i36.GetUsersFilterableUseCase>(() =>
      _i36.GetUsersFilterableUseCase(repository: gh<_i28.HomeRepository>()));
  gh.factory<_i37.HomeNotifier>(() => _i37.HomeNotifier(
        remote: gh<_i16.AuthenticationRemoteDatasource>(),
        getUsersUsecase: gh<_i35.GetUsersUsecase>(),
        getUsersFilterableUsecase: gh<_i36.GetUsersFilterableUseCase>(),
        readProfileUsecase: gh<_i22.ReadProfileUsecase>(),
      ));
  return getIt;
}

class _$RegisterModule extends _i38.RegisterModule {}
