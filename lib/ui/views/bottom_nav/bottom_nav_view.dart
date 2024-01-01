import 'package:flutter/material.dart';
import 'package:soro_soke/utils/app_colors.dart';
import 'package:stacked/stacked.dart';
import 'package:flashy_tab_bar2/flashy_tab_bar2.dart';
import 'bottom_nav_viewmodel.dart';

class BottomNavView extends StackedView<BottomNavViewModel> {
  const BottomNavView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    BottomNavViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      body: viewModel.widgetView[viewModel.selectedIndex],

      bottomNavigationBar: FlashyTabBar(
          selectedIndex: viewModel.selectedIndex,
          backgroundColor: AppColors.primaryColor,
          showElevation: true,
          height: 65,
          animationCurve: Curves.linear,
          animationDuration: const Duration(milliseconds: 500),
          onItemSelected: (index) => viewModel.setIndex(index),
          items: List.generate(
              viewModel.navItems.length,
              (index) => FlashyTabBarItem(
                    activeColor: Colors.white,
                    icon: Icon(viewModel.navItems[index].icon),
                    title: Text(
                      viewModel.navItems[index].identifier,
                      style: const TextStyle(fontWeight: FontWeight.w700),
                    ),
                  ))),
      //other params
    );
  }

  @override
  BottomNavViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      BottomNavViewModel();
}
