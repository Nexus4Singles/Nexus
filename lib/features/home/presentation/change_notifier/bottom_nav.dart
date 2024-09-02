import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:Nexus/features/chat/views/chats.dart';
import 'package:Nexus/features/explore/presentation/views/explore.dart';
import 'package:Nexus/features/home/presentation/views/home.dart';
import 'package:Nexus/features/match/presentation/views/matches.dart';
import 'package:Nexus/features/profile/presentation/views/profile.dart';

class BottomNavModel extends ChangeNotifier {
  BottomNavModel() {
    _pageController = PageController(initialPage: _currentIndex);
  }
  //Current index of the bottom nav-bar
  int _currentIndex = 0;
  int get currentIndex => _currentIndex;
  late PageController _pageController;
  PageController get controller => _pageController;

  int _tab = 0;
  int get tab => _tab;

  //personnal children of the bottom Nav
  final List<Widget> _navs = [
    const HomeScreen(),
    const ExploreScreen(),
    const MatchScreen(),
    const ChatsScreen(),
    const ProfileScreen(),
  ];

  List<Widget> get navs => _navs;

  ///updates the current index of the bottom nav
  updateIndex(int index) {
    _currentIndex = index;
    notifyListeners();
  }

  void setInitialPage(int index) {
    _pageController = PageController(initialPage: index);
    updateIndex(index);
    // notifyListeners();
  }

  void jumpToNavPage(int page) {
    _pageController.jumpToPage(page);
    // notifyListeners();
  }

  setActiveTab(int tab) {
    _tab = tab;
    notifyListeners();
  }
}
