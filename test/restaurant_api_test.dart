import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:http/testing.dart';
import 'package:restaurant_app/data/api/restaurant_api.dart';
import 'package:restaurant_app/data/models/detail_restaurant.dart';
import 'package:restaurant_app/data/models/list_restaurant.dart';
import 'package:restaurant_app/data/models/search_restaurant.dart';

void main() {
  group(
    'Testing Restaurant API ',
    () {
      test(
        'Return a list of restaurants',
        () async {
          final client = MockClient((request) async {
            final response = {
              "error": false,
              "message": "success",
              "count": 20,
              "restaurants": []
            };
            return Response(json.encode(response), 200);
          });
          expect(
            await RestaurantApi().list(client),
            isA<ListRestaurant>(),
          );
        },
      );

      test(
        "Return a Detail of restaurants",
        () async {
          final client = MockClient(
            (request) async {
              final response = {
                "error": false,
                "message": "success",
                "restaurant": {
                  "id": "",
                  "name": "",
                  "description": "",
                  "city": "",
                  "address": "",
                  "pictureId": "",
                  "categories": [],
                  "menus": {"foods": [], "drinks": []},
                  "rating": 1.0,
                  "customerReviews": []
                }
              };
              return Response(json.encode(response), 200);
            },
          );
          expect(
            await RestaurantApi().detail(client, 'Restaurant Id'),
            isA<DetailRestaurant>(),
          );
        },
      );

      test(
        'Return Searched Restaurant',
        () async {
          final client = MockClient(
            (request) async {
              final response = {
                "error": false,
                "founded": 1,
                "restaurants": []
              };
              return Response(json.encode(response), 200);
            },
          );

          expect(
            await RestaurantApi().search(client, 'Search Restaurant'),
            isA<SearchRestaurant>(),
          );
        },
      );
    },
  );
}
