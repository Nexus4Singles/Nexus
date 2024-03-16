import 'package:injectable/injectable.dart';

abstract class AuthenticationLocalDatasource {}

@LazySingleton(as: AuthenticationLocalDatasource)
class AuthenticationLocalDatasourceImpl extends AuthenticationLocalDatasource {
  AuthenticationLocalDatasourceImpl();
}
