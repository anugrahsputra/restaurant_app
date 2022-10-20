import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/constant/style.dart';
import 'package:restaurant_app/provider/bottom_navbar_provider.dart';

class Mainpage extends StatelessWidget {
  Mainpage({Key? key}) : super(key: key);
  static const routeName = '/main_page';

  final List<BottomNavyBarItem> _navyBarItems = [
    BottomNavyBarItem(
      icon: const Icon(MdiIcons.home),
      title: const Text('Home'),
      activeColor: secondaryColor,
    ),
    BottomNavyBarItem(
      icon: const Icon(MdiIcons.heart),
      title: const Text('Favorite'),
      activeColor: Colors.redAccent,
    ),
    BottomNavyBarItem(
      icon: const Icon(MdiIcons.account),
      title: const Text('Profile'),
      activeColor: Colors.blueAccent,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Consumer<BottomNavBar>(
      builder: (context, page, child) => Scaffold(
        body: page.listWidget[page.currentIndex],
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 10,
            horizontal: 8,
          ),
          child: BottomNavyBar(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            showElevation: false,
            items: _navyBarItems,
            onItemSelected: (index) {
              page.currentPage(index);
            },
            selectedIndex: page.currentIndex,
          ),
        ),
      ),
    );
  }
}
