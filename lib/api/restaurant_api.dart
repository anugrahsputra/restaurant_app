import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:restaurant_app/models/detail_restaurant.dart';
import 'package:restaurant_app/models/list_restaurant.dart';
import 'package:restaurant_app/models/search_restaurant.dart';

class RestaurantApi {
  final String baseUrl = 'https://restaurant-api.dicoding.dev';
  final String restaurantListUrl = '/list';
  final String restaurantDetailUrl = '/detail/';
  final String restaurantSearchUrl = '/search?q=';
  final String restaurantReviewUrl = '/review';
  final String headers = 'application/x-www-form-urlencoded';
  final String smallImageUrl = '/images/small/';
  final String mediumImageUrl = '/images/medium/';
  final String largeImageUrl = '/images/large/';

  Future<ListRestaurant> list() async {
    final response = await http.get(Uri.parse('$baseUrl$restaurantListUrl'));
    try {
      if (response.statusCode == 200) {
        return ListRestaurant.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to get restaurant list');
      }
    } on SocketException {
      throw 'No Internet Connection';
    } catch (e) {
      rethrow;
    }
  }

  Future<DetailRestaurant> detail(id) async {
    final response =
        await http.get(Uri.parse('$baseUrl$restaurantDetailUrl$id'));
    try {
      if (response.statusCode == 200) {
        return DetailRestaurant.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to get detail restaurant');
      }
    } on SocketException {
      throw 'No Internet Connection';
    } catch (e) {
      rethrow;
    }
  }

  Future<SearchRestaurant> search(query) async {
    final response =
        await http.get(Uri.parse("$baseUrl$restaurantSearchUrl$query"));
    if (response.statusCode == 200) {
      return SearchRestaurant.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load restaurant search');
    }
  }

  // image
  smallImage(pictureId) {
    String url = "$baseUrl$smallImageUrl$pictureId";
    return url;
  }

  mediumImage(pictureId) {
    String url = "$baseUrl$mediumImageUrl$pictureId";
    return url;
  }

  largeImage(pictureId) {
    String url = "$baseUrl$largeImageUrl$pictureId";
    return url;
  }
}
