import 'package:flutter/material.dart';
import 'package:restaurant_app/data/api/restaurant_api.dart';
import 'package:restaurant_app/constant/result_state.dart';
import 'package:restaurant_app/data/models/detail_restaurant.dart';
import 'package:http/http.dart' as http;

class DetailRestaurantProvider extends ChangeNotifier {
  final RestaurantApi restaurantApi;

  DetailRestaurantProvider({required this.restaurantApi, required String id}) {
    _fetchDetailRestaurant(id);
  }

  late DetailRestaurant _detailRestaurant;
  late ResultState _state;
  String _message = '';

  DetailRestaurant get detail => _detailRestaurant;
  ResultState get state => _state;
  String get message => _message;

  Future _fetchDetailRestaurant(id) async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final restaurant = await restaurantApi.detail(id, http.Client());
      if (restaurant.restaurant.toJson().isEmpty) {
        _state = ResultState.noData;
        notifyListeners();
        return _message = 'data is empty';
      } else {
        _state = ResultState.hasData;
        notifyListeners();
        return _detailRestaurant = restaurant;
      }
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
      return _message = 'Error => $e';
    }
  }
}
