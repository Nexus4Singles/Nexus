import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';
import 'package:nexus/core/network/network_info.dart';
import 'package:nexus/core/utils/toast.dart';

abstract class MyFormatter {
  Future<Either<void, dynamic>> firebaseAuthFmt(Function func);
  Future<Either<void, dynamic>> firestorFmt(Function func);
  Future<Either<void, dynamic>> googleFmt(Function func);
}

@LazySingleton(as: MyFormatter)
class MyFormatterImpl extends MyFormatter {
  MyFormatterImpl({
    required this.networkInfo,
  });

  final NetworkInfo networkInfo;

  @override
  Future<Either<void, dynamic>> firebaseAuthFmt(Function func) async {
    if (await networkInfo.isConnected()) {
      try {
        return Right(await func.call());
      } on FirebaseAuthException catch (e) {
        AppToast().showErrorToast(e.message ?? 'Something went wrong');

        return const Left(null);
      } catch (e, s) {
        // Logger().e(e, s.toString());
        Logger().d(s.toString());
        AppToast().showErrorToast(e.toString());

        return const Left(null);
      }
    } else {
      AppToast().showErrorToast('Please check your network connection');

      return const Left(null);
    }
  }

  @override
  Future<Either<void, dynamic>> googleFmt(Function func) async {
    if (await networkInfo.isConnected()) {
      try {
        return Right(await func.call());
      } catch (e, s) {
        FirebaseCrashlytics.instance.recordError(
          e,
          s,
          reason: 'a fatal error on google fmt',
          fatal: true,
        );

        AppToast().showErrorToast(
            'You don not have account please create an account');

        return const Left(null);
      }
      // }
    } else {
      AppToast().showErrorToast('Please check your network connection');

      return const Left(null);
    }
  }

  @override
  Future<Either<void, dynamic>> firestorFmt(Function func) async {
    if (await networkInfo.isConnected()) {
      try {
        return Right(await func.call());
      } on FirebaseException catch (e, s) {
        FirebaseCrashlytics.instance.recordError(
          e,
          s,
          reason: 'a fatal error on firestore',
          fatal: true,
        );

        AppToast().showErrorToast(e.message ?? 'Something went wrong');

        return const Left(null);
      } catch (e, s) {
        Logger().e(e);
        Logger().e(s);

        AppToast().showErrorToast(e.toString());

        return const Left(null);
      }
    } else {
      AppToast().showErrorToast('Please check your network connection');

      return const Left(null);
    }
  }
}
