import 'dart:convert';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';
import 'package:nexus/core/constant.dart';
import 'package:nexus/core/models/location.dart';
import 'package:nexus/core/models/locationIQModel.dart';
import 'package:nexus/core/models/user.dart';
import 'package:nexus/core/network/formatter.dart';
import 'package:nexus/core/usecases/core/has_started.dart';
import 'package:nexus/core/usecases/core/logout.dart';
import 'package:nexus/core/usecases/core/started.dart';
import 'package:nexus/core/usecases/usecases.dart';
import 'package:nexus/core/utils/toast.dart';
import 'package:nexus/features/auth/data/data-sources/remote-datasource/auth_remote.dart';
import 'package:nexus/features/auth/domain/usecases/is_auth.dart';
import 'package:nexus/features/auth/domain/usecases/login.dart';
import 'package:nexus/features/auth/domain/usecases/profile.dart';
import 'package:nexus/features/auth/domain/usecases/register.dart';
import 'package:nexus/features/auth/domain/usecases/update_profile.dart';
import 'package:nexus/router.dart';
import 'package:http/http.dart' as http;

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
  var username = "";

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
    kCHURCHNAME: '',
    kCOUNTRY: '',
  };

  String audioPath1 = '';
  String audioPath2 = '';
  String audioPath3 = '';

  void setAudio1(String path) {
    audioPath1 = path;
    notifyListeners();
  }

  void setAudio2(String path) {
    audioPath2 = path;
    notifyListeners();
  }

  void setAudio3(String path) {
    audioPath3 = path;
    notifyListeners();
  }

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
      kISVERIFIED: true,
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
      kCHURCHNAME: '',
      kCOUNTRY: 'Nigeria', //todo default country
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
    EasyLoading.show();
    try {
      FirebaseAuth.instance.sendPasswordResetEmail(email: email).then((value) {
        AppToast().showToast('Password reset link sent');
        EasyLoading.dismiss();
        Get.offAndToNamed(AppRoutes.login);
      });
    } catch (e) {
      EasyLoading.dismiss();
      EasyLoading.showError('An error occured');
    }
  }

  Future<void> login(
      {required BuildContext context,
      required Map<String, dynamic> map}) async {
    EasyLoading.show();
    var response = await loginUsecase.call(map);
    response.fold((l) {
      EasyLoading.dismiss();
    }, (r) {
      EasyLoading.dismiss();
      user = r;
      notifyListeners();

      bool isVerified = FirebaseAuth.instance.currentUser!.emailVerified;
      if (isVerified) {
        switch (r.registrationProgress) {
          case 'auth':
            Get.toNamed(AppRoutes.gender);
            break;
          case 'gender':
            Get.toNamed(AppRoutes.age);
            break;
          case 'age':
            Get.toNamed(AppRoutes.extraInfo);
            break;
          case 'extra':
            Get.toNamed(AppRoutes.hobbies);
            break;
          case 'hobbies':
            Get.toNamed(AppRoutes.desiredQuality);
            break;
          case 'desired':
            Get.toNamed(AppRoutes.uploadPhoto);
            break;
          case 'upload':
            Get.toNamed(AppRoutes.audioRecording);
            break;
          case 'completed':
            Get.offAllNamed(
              AppRoutes.mainNav,
              arguments: {'fromSignUp': false},
            );
            break;
          default:
            Get.toNamed(AppRoutes.gender);
            break;
        }
      } else {
        Get.offAndToNamed(AppRoutes.congratulations, arguments: "");
      }
    });
  }

  String filename(String path) {
    if (path.isEmpty) {
      return '';
    } else {
      return (path.split('/').last);
    }
  }

  Future<void> register(
      {required BuildContext context,
      required String username,
      required Map<String, dynamic> map}) async {
    EasyLoading.show();
    registerUsecase.call(_credential).then((value) {
      value.fold((l) {
        EasyLoading.dismiss();
      }, (r) {
        const FlutterSecureStorage().write(key: "username", value: username);
        FirebaseAuth.instance.currentUser!.sendEmailVerification();
        Get.toNamed(AppRoutes.congratulations, arguments: username);
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

  Future<String> uploadFile({required File file}) async {
    EasyLoading.show();
    try {
      var url = await remote.upload(file);
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

  Future<void> updateProfile({
    required Map<String, dynamic> map,
    required VoidCallback onCompleted,
    bool load = true,
  }) async {
    if (load) EasyLoading.show();
    var response = await updateProfileUsecase.call(map);
    response.fold((l) {
      if (load) EasyLoading.dismiss();
    }, (r) {
      if (load) EasyLoading.dismiss();
      onCompleted();
      setIsLoading(false);
    });
  }

  String country = '';
  void setCountry(String name) {
    country = name;
    notifyListeners();
  }

  void resendVerificatioLink() async {
    EasyLoading.show();
    try {
      await FirebaseAuth.instance.currentUser!
          .sendEmailVerification()
          .then((value) {
        AppToast().showToast('Email verification link has been sent');
        EasyLoading.dismiss();
      });
    } catch (e) {
      AppToast().showErrorToast('Something went wrong');
      EasyLoading.dismiss();
    }
  }

  LocationIqModel? locationIQModel;

  TextEditingController search = TextEditingController();
  String _city = '';
  String get city => _city;

  int recordingEndSecs = 60;
}
