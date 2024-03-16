import 'package:injectable/injectable.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

abstract class NetworkInfo {
  Future<bool> isConnected();
}

@LazySingleton(as: NetworkInfo)
class NetworkInfoImpl implements NetworkInfo {
  @override
  Future<bool> isConnected() async {
    return await InternetConnectionChecker().hasConnection;
  }
}
