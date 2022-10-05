import 'package:flutter/material.dart';
import 'package:restaurant_app/api/restaurant_api.dart';
import 'package:restaurant_app/constant/result_state.dart';
import 'package:restaurant_app/models/search_restaurant.dart';

class SearchRestaurantProvider extends ChangeNotifier {
  final RestaurantApi restaurantApi;
  String query;

  SearchRestaurantProvider({required this.restaurantApi, this.query = ''}) {
    _fetchSearchRestaurant(query);
  }

  late SearchRestaurant _searchRestaurant;
  late ResultState _state;
  String _message = '';

  SearchRestaurant get search => _searchRestaurant;
  ResultState get state => _state;
  String get message => _message;

  searchRestaurant(String newValue) {
    query = newValue;
    _fetchSearchRestaurant(query);
    notifyListeners();
  }

  Future _fetchSearchRestaurant(value) async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final restaurant = await restaurantApi.search(query);
      if (restaurant.restaurants.isEmpty) {
        _state = ResultState.noData;
        notifyListeners();
        return _message = 'data is empty';
      } else {
        _state = ResultState.hasData;
        notifyListeners();
        return _searchRestaurant = restaurant;
      }
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
      return _message = 'Error => $e';
    }
  }
}
