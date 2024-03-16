import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
// import 'package:flutter_stripe/flutter_stripe.dart
import 'package:get/get.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';
import 'package:nexus/core/constant.dart';
import 'package:nexus/core/models/user.dart';
import 'package:nexus/core/network/formatter.dart';
import 'package:nexus/core/usecases/core/has_started.dart';
import 'package:nexus/core/usecases/core/logout.dart';
import 'package:nexus/core/usecases/core/started.dart';
import 'package:nexus/core/usecases/usecases.dart';
import 'package:nexus/features/auth/data/data-sources/remote-datasource/auth_remote.dart';
import 'package:nexus/features/auth/domain/usecases/is_auth.dart';
import 'package:nexus/features/auth/domain/usecases/login.dart';
import 'package:nexus/features/auth/domain/usecases/profile.dart';
import 'package:nexus/features/auth/domain/usecases/register.dart';
import 'package:nexus/features/auth/domain/usecases/update_profile.dart';
import 'package:nexus/router.dart';

@injectable
class AuthNotifier with ChangeNotifier {
  AuthNotifier({
    required this.startedUsecase,
    required this.hasStratedUsecase,
    required this.loginUsecase,
    required this.registerUsecase,
    required this.isAuthUsecase,
    required this.logoutUsecase,
    required this.readProfileUsecase,
    required this.updateProfileUsecase,
    required this.remote,
    required this.formatter,
  });
  final StartedUsecase startedUsecase;
  final HasStratedUsecase hasStratedUsecase;
  final LoginUsecase loginUsecase;
  final RegisterUsecase registerUsecase;
  final IsAuthUsecase isAuthUsecase;
  final LogoutUsecase logoutUsecase;
  final ReadProfileUsecase readProfileUsecase;
  final UpdateProfileUsecase updateProfileUsecase;
  final AuthenticationRemoteDatasource remote;
  final MyFormatter formatter;
  late String _code;

  bool _showPassword = true;
  bool _editProfile = false;

  String get verificationCode {
    return _code;
  }

  bool get editProfile => _editProfile;

  void setEditProfile() {
    _editProfile = !_editProfile;
    notifyListeners();
  }

  Map<String, dynamic> _credential = {
    kEMAIL: '',
    kPASSWORD: '',
    kPHONENUMBER: '',
    kUSERNAME: '',
    kADDRESS: '',
    kNAME: '',
    KNOTIFICATIONTOKEN: '',
    KPROFILEURL: '',
    kISVERIFIED: false,
    kGENDER: '',
    kAGE: 18,
    kCITY: '',
    kSTATEOFORIGIN: '',
    kEDULEVEL: '',
    kPROFESSION: '',
    kHOBBIES: [],
    kDESIREDQUALITIES: [],
    kPHOTOS: [],
    kRELATIONSHIPWITHGOD: '',
    kROLEOFHUSBAND: '',
    kBESTQUALITIESORTRAITS: '',
    kREGPROGRESS: 'auth',
  };

  Map<String, dynamic> get credential => _credential;

  void setData(key, value) {
    _credential.update(key, (_) => value);
    notifyListeners();
  }

  void clearCredential() {
    _credential = {
      kEMAIL: '',
      kPASSWORD: '',
      kPHONENUMBER: '',
      kUSERNAME: '',
      kADDRESS: '',
      kNAME: '',
      KNOTIFICATIONTOKEN: '',
      KPROFILEURL: '',
      kISVERIFIED: false,
      kGENDER: '',
      kAGE: 18,
      kCITY: '',
      kSTATEOFORIGIN: '',
      kEDULEVEL: '',
      kPROFESSION: '',
      kHOBBIES: [],
      kDESIREDQUALITIES: [],
      kPHOTOS: [],
      kRELATIONSHIPWITHGOD: '',
      kROLEOFHUSBAND: '',
      kBESTQUALITIESORTRAITS: '',
      kREGPROGRESS: 'auth',
    };
    notifyListeners();
  }

  bool get showPassword {
    return _showPassword;
  }

  void setShowPassword() {
    _showPassword = !_showPassword;
    notifyListeners();
  }

  String registerWith = 'normal';
  void setRegistrationType(String type) {
    registerWith = type;
    notifyListeners();
  }

  Future<void> started() async => await startedUsecase.call(const NoParams());

  Future<bool> hasStarted() async =>
      await hasStratedUsecase.call(const NoParams());

  Future<void> resendResetLink({required String email}) async {
    try {
      FirebaseAuth.instance.sendPasswordResetEmail(email: email).then((value) {
        EasyLoading.showSuccess('Password reset link sent');
      });
    } catch (e) {
      EasyLoading.showError('An error occured');
    }
  }

  Future<void> login({
    required BuildContext context,
  }) async {
    EasyLoading.show();
    var response = await loginUsecase.call(_credential);
    response.fold((l) {
      Logger().d('Erroor');
      EasyLoading.dismiss();
    }, (r) {
      EasyLoading.dismiss();
      // updateProfile(
      //   map: {
      //     kNotificationToken: _credential[kNotificationToken],
      //   },
      // );

      Get.toNamed(AppRoutes.mainNav);
    });
  }

  String filename(String path) {
    if (path.isEmpty) {
      return '';
    } else {
      return (path.split('/').last);
    }
  }

  Future<void> register({
    required BuildContext context,
  }) async {
    EasyLoading.show();
    registerUsecase.call(_credential).then((value) {
      value.fold((l) {
        EasyLoading.dismiss();
      }, (r) {
        EasyLoading.showSuccess('Accoount created');
        Get.toNamed(AppRoutes.verifyAccount);
        EasyLoading.dismiss();
      });
    });
  }

  Future<bool> isAuth() async => await isAuthUsecase.call(const NoParams());

  Future<void> logout() async => await logoutUsecase.call(const NoParams());
  final curUser = FirebaseAuth.instance.currentUser;

  UserModel? user;

  Future<void> getProfile() async {
    var data = await readProfileUsecase.call(const NoParams());
    data.fold(
      (l) => l,
      (r) {
        user = r;
        notifyListeners();
      },
    );
  }

  Future<String> uploadFile({required File image}) async {
    EasyLoading.show();
    try {
      var url = await remote.upload(image);
      return url;
    } catch (e) {
      return '';
    }
  }

  bool isLoading = false;

  void setIsLoading(bool val) {
    isLoading = val;
    notifyListeners();
  }

  Future<void> updateProfile(
      {required Map<String, dynamic> map,
      required VoidCallback onCompleted}) async {
    EasyLoading.show();
    var response = await updateProfileUsecase.call(map);
    response.fold((l) {
      EasyLoading.dismiss();
    }, (r) {
      EasyLoading.dismiss();
      onCompleted();
      setIsLoading(false);
    });
  }
}
