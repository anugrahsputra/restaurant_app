import 'package:flutter/material.dart';
import 'package:restaurant_app/api/restaurant_api.dart';
import 'package:restaurant_app/constant/result_state.dart';
import 'package:restaurant_app/models/list_restaurant.dart';

class ListRestaurantProvider extends ChangeNotifier {
  final RestaurantApi restaurantApi;

  ListRestaurantProvider({required this.restaurantApi}) {
    _fetchRestaurantList();
  }

  late ListRestaurant _listRestaurant;
  late ResultState _state;
  String _message = '';

  ListRestaurant get list => _listRestaurant;
  ResultState get state => _state;
  String get message => _message;

  Future _fetchRestaurantList() async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final restaurant = await restaurantApi.list();
      if (restaurant.restaurants.isEmpty) {
        _state = ResultState.noData;
        notifyListeners();
        return _message = 'data is empty';
      } else {
        _state = ResultState.hasData;
        notifyListeners();
        return _listRestaurant = restaurant;
      }
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
      return _message = 'Error => $e';
    }
  }
}
