import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/constant/style.dart';
import 'package:restaurant_app/main.dart';
import 'package:restaurant_app/pages/restaurant_detail.dart';
import 'package:restaurant_app/provider/bottom_navbar_provider.dart';
import 'package:restaurant_app/utils/notification_helper.dart';

class Mainpage extends StatefulWidget {
  const Mainpage({Key? key}) : super(key: key);
  static const routeName = '/main_page';

  @override
  State<Mainpage> createState() => _MainpageState();
}

class _MainpageState extends State<Mainpage> {
  final NotificationHelper _notificationHelper = NotificationHelper();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _notificationHelper.initNotifications(flutterLocalNotificationsPlugin);
      _notificationHelper.configureSelectionNotificationSubject(
          context, RestoDetail.routeName);
    });
  }

  @override
  void dispose() {
    selectNotificationSubject.close();
    super.dispose();
  }

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
