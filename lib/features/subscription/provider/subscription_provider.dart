import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../core/models/user.dart';

class SubscriptionProvider extends ChangeNotifier {
  UserModel? _currentUser;
  set currentUser (UserModel? userModel){
    _currentUser = userModel;
    notifyListeners();
  }
  UserModel? get currentUser=> _currentUser;


  bool _onPremium = false;
  set onPremium(bool onPremium) {
    _onPremium = onPremium;
    notifyListeners();
  }
  bool get onPremium => _onPremium;

  bool _usedOneFreeText = false;
  set usedOneFreeText(bool usedOneFreeText){
    _usedOneFreeText = usedOneFreeText;
    notifyListeners();
  }
  bool get usedOneFreeText => _usedOneFreeText;

  bool _prevSubscribed = false;
  set prevSubscribed(bool prevSubscribed) {
    _prevSubscribed = prevSubscribed;
    notifyListeners();
  }
  bool get prevSubscribed => _prevSubscribed;

  String?  _subExpDate;
  set subExpDate(String?  subExpDate) {
    _subExpDate = subExpDate;
    notifyListeners();
  }
  String? get subExpDate => _subExpDate;


  void initSubDet(UserModel? user){
    _currentUser = user;
    _onPremium = user?.onPremium ?? false;
    _prevSubscribed = user?.prevSubscribed ?? false ;
    _usedOneFreeText = user?.usedOneFreeText ?? false;
    _subExpDate = user?.subExpDate;
  }

  bool _isLoading = false;
  set isLoading(bool isLoading) {
    _isLoading = isLoading;
    notifyListeners();
  }
  bool get isLoading => _isLoading;

}
