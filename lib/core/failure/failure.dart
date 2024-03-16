import '../constant.dart';

abstract class Failure {}

class SomethingWentWrong extends Failure {
  SomethingWentWrong({
    required this.message,
  });

  final String message;
}

class TimeOutError extends Failure {}

class ServerException extends Failure {}

class FailureToString {
  static String mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerException:
        return kSERVER_EXCEPTION_MESSAGE;
      case SomethingWentWrong:
        return (failure as SomethingWentWrong).message;
      case TimeOutError:
        return kTIME_OUT_MESSAGE;
      default:
        return kUNEXPECTED_ERROR_MESSAGE;
    }
  }
}
