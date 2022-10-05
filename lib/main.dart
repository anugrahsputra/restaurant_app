import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/api/restaurant_api.dart';
import 'package:restaurant_app/constant/style.dart';
import 'package:restaurant_app/models/restaurant.dart';
import 'package:restaurant_app/provider/list_restaurant_provider.dart';
import 'package:restaurant_app/ui/restaurant_detail.dart';
import 'package:restaurant_app/ui/restaurant_list.dart';
import 'package:restaurant_app/ui/search_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) =>
              ListRestaurantProvider(restaurantApi: RestaurantApi()),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Restaurant App',
        theme: ThemeData(
          colorScheme: Theme.of(context).colorScheme.copyWith(
                primary: primaryColor,
                secondary: secondaryColor,
              ),
          textTheme: textTheme,
          appBarTheme: const AppBarTheme(elevation: 0),
        ),
        initialRoute: RestaurantList.routeName,
        routes: {
          RestaurantList.routeName: (context) => const RestaurantList(),
          RestoDetail.routeName: (context) => RestoDetail(
                restaurant:
                    ModalRoute.of(context)?.settings.arguments as Restaurant,
              ),
          Search.routeName: (context) => const Search(),
        },
      ),
    );
  }
}
