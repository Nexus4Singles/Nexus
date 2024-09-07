import 'package:flutter/material.dart';

import '../../../core/models/user.dart';

class SubscriptionProvider extends ChangeNotifier {
  UserModel? _currentUser;

  set currentUser(UserModel? userModel) {
    _currentUser = userModel;
    notifyListeners();
  }

  UserModel? get currentUser => _currentUser;

  bool _onPremium = false;

  set onPremium(bool onPremium) {
    _onPremium = onPremium;
    notifyListeners();
  }

  bool get onPremium => _onPremium;

  bool _usedOneFreeText = false;

  set usedOneFreeText(bool usedOneFreeText) {
    _usedOneFreeText = usedOneFreeText;
    notifyListeners();
  }

  bool get usedOneFreeText => _usedOneFreeText;

  String? _entitledUser;

  set entitledUser(String? entitledUser) {
    _entitledUser = entitledUser;
    notifyListeners();
  }

  String? get entitledUser => _entitledUser;

  bool _prevSubscribed = false;

  set prevSubscribed(bool prevSubscribed) {
    _prevSubscribed = prevSubscribed;
    notifyListeners();
  }

  bool get prevSubscribed => _prevSubscribed;

  String? _subExpDate;

  set subExpDate(String? subExpDate) {
    _subExpDate = subExpDate;
    notifyListeners();
  }

  String? get subExpDate => _subExpDate;

  String? _subscriberId;

  set subscriberId(String? subscriberId) {
    _subscriberId = subscriberId;
    notifyListeners();
  }

  String? get subscriberId => _subscriberId;

  bool _isRestricted = false;

  set isRestricted(bool isRestricted) {
    _isRestricted = isRestricted;
    notifyListeners();
  }

  bool get isRestricted => _isRestricted;

  void initSubDet(UserModel? user) {
    _currentUser = user;
    _onPremium = user?.onPremium ?? false;
    _prevSubscribed = user?.prevSubscribed ?? false;
    _usedOneFreeText = user?.usedOneFreeText ?? false;
    _subExpDate = user?.subExpDate;
    _entitledUser = user?.entitledUser;
    _subscriberId = user?.subscriberId;
  }

  bool _isLoading = false;

  set isLoading(bool isLoading) {
    _isLoading = isLoading;
    notifyListeners();
  }

  bool get isLoading => _isLoading;

  bool _subLoading = false;

  set subLoading(bool subLoading) {
    _subLoading = subLoading;
    notifyListeners();
  }

  bool get subLoading => _subLoading;
}
