import 'package:flutter/material.dart';
import 'package:soro_soke/ui/views/friends/friends_view.dart';
import 'package:soro_soke/ui/views/home/home_view.dart';
import 'package:soro_soke/ui/views/profile/profile_view.dart';
import 'package:soro_soke/ui/views/settings/settings_view.dart';
import 'package:stacked/stacked.dart';

class BottomNavViewModel extends BaseViewModel {
  List<IconData> iconList = const [
    Icons.chat,
    Icons.people,
    Icons.person,
    Icons.settings
  ];

  List<Widget> widgetView = const [
    HomeView(),
    FriendsView(),
    ProfileView(),
    SettingsView()
  ];

  int _selectedIndex = 0;
  int get selectedIndex => _selectedIndex;

  void setIndex(int index) {
    _selectedIndex = index;
    rebuildUi();
  }
}
