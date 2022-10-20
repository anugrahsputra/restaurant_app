import 'package:flutter/material.dart';
import 'package:restaurant_app/pages/favorite_page.dart';
import 'package:restaurant_app/pages/profile_page.dart';
import 'package:restaurant_app/pages/restaurant_list.dart';

class BottomNavBar extends ChangeNotifier {
  int currentIndex = 0;

  final List<Widget> listWidget = [
    const RestaurantList(),
    const FavoritePage(),
    const ProfilePage(),
  ];

  currentPage(int index) {
    currentIndex = index;
    notifyListeners();
  }
}
