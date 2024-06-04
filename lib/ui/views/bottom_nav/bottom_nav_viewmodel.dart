import 'package:flutter/material.dart';
import 'package:soro_soke/app/app.router.dart';
import 'package:soro_soke/ui/views/friends/friends_view.dart';
import 'package:soro_soke/ui/views/home/home_view.dart';
import 'package:soro_soke/ui/views/profile/profile_view.dart';
import 'package:soro_soke/ui/views/search/search_view.dart';
import 'package:soro_soke/ui/views/settings/settings_view.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../app/app.locator.dart';

class BottomNavViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();

  List<NavItem> navItems = [
    NavItem.home,
    NavItem.friends,
    NavItem.search,
    NavItem.profile,
  ];

  List<Widget> widgetView = const [
    HomeView(),
    FriendsView(),
    SearchView(),
    ProfileView(),
  ];

  int _selectedIndex = 0;

  int get selectedIndex => _selectedIndex;

  void setIndex(int index) {
    _selectedIndex = index;
    rebuildUi();
  }

  void navigateToSearch() {
    _navigationService.navigateToSearchView();
  }
}

class NavItem {
  final String identifier;
  final IconData icon;

  NavItem({
    required this.identifier,
    required this.icon,
  });

  static NavItem home = NavItem(
    identifier: "Chats",
    icon: Icons.chat,
  );
  static NavItem friends = NavItem(
    identifier: "Friends",
    icon: Icons.people,
  );
  static NavItem search = NavItem(
    identifier: "Search",
    icon: Icons.search,
  );
  static NavItem profile = NavItem(
    identifier: "Profile",
    icon: Icons.person,
  );
}
