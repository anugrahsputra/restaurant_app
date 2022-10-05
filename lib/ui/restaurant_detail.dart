import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/api/restaurant_api.dart';
import 'package:restaurant_app/constant/result_state.dart';
import 'package:restaurant_app/constant/style.dart';
import 'package:restaurant_app/models/detail_restaurant.dart';
import 'package:restaurant_app/provider/detail_restaurant_provider.dart';
import 'package:restaurant_app/widget/expanded_text.dart';

class RestoDetail extends StatelessWidget {
  const RestoDetail({
    Key? key,
    required this.id,
  }) : super(key: key);

  static const routeName = '/restaurant_detail';

  final String id;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) =>
          DetailRestaurantProvider(restaurantApi: RestaurantApi(), id: id),
      child: Consumer<DetailRestaurantProvider>(
        builder: (context, state, _) {
          if (state.state == ResultState.loading) {
            return Container(
              height: double.infinity,
              width: double.infinity,
              color: Colors.white,
              child: Center(
                child: LoadingAnimationWidget.staggeredDotsWave(
                    color: secondaryColor, size: 40),
              ),
            );
          } else if (state.state == ResultState.hasData) {
            return Scaffold(
              body: SafeArea(
                child: SingleChildScrollView(
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height / 0.70,
                    child: Stack(
                      children: [
                        Image.network(RestaurantApi()
                            .largeImage(state.detail.restaurant.pictureId)),
                        Positioned(
                          top: 10,
                          left: 10,
                          child: Container(
                            margin: const EdgeInsets.only(top: 5),
                            width: 35,
                            height: 35,
                            decoration: BoxDecoration(
                              color: Colors.white70,
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: const Icon(
                                Icons.arrow_back_ios_new,
                                size: 20,
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          top: 170,
                          left: 0,
                          right: 0,
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(20),
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                    left: 20,
                                    top: 20,
                                  ),
                                  child: Text(
                                    state.detail.restaurant.name,
                                    style: const TextStyle(
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  child: _rating(state.detail.restaurant),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 10),
                                  child: Row(
                                    children: [
                                      const Icon(
                                        Icons.location_on,
                                        color: secondaryColor,
                                      ),
                                      Text(
                                        state.detail.restaurant.city,
                                        style: textTheme.bodyText1,
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 30,
                                ),
                                Container(
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Description',
                                        style: textTheme.headline6,
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      ExpandedText(
                                        text:
                                            state.detail.restaurant.description,
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 20),
                                      child: Text(
                                        'Menu',
                                        style: textTheme.headlineMedium,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 20, top: 15),
                                      child: Text(
                                        'Drinks',
                                        style: textTheme.headlineSmall,
                                      ),
                                    ),
                                    _buildDrinks(
                                        context, state.detail.restaurant),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 20, top: 15),
                                      child: Text(
                                        'Foods',
                                        style: textTheme.headlineSmall,
                                      ),
                                    ),
                                    _buildFoods(
                                        context, state.detail.restaurant),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          } else if (state.state == ResultState.noData) {
            return Center(
              child: Text(state.message),
            );
          } else {
            return const Center(
              child: Text(''),
            );
          }
        },
      ),
    );
  }

  Widget _buildDrinks(BuildContext context, Restaurant restaurant) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      width: MediaQuery.of(context).size.width,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: restaurant.menus.drinks
              .map(
                (drink) => Container(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 15,
                  ),
                  padding: const EdgeInsets.all(5),
                  width: 150,
                  decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Column(
                    children: [
                      Image.asset(
                        'assets/drink.png',
                        width: 70,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: Text(
                          drink.name.toString(),
                          textAlign: TextAlign.start,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const Align(
                        alignment: Alignment.bottomLeft,
                        child: Text(
                          "Rp.20000-,",
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
              .toList(),
        ),
      ),
    );
  }

  Widget _buildFoods(BuildContext context, Restaurant restaurant) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      width: MediaQuery.of(context).size.width,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: restaurant.menus.foods
              .map(
                (food) => Container(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 15,
                  ),
                  padding: const EdgeInsets.all(5),
                  width: 150,
                  decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Column(
                    children: [
                      Image.asset(
                        'assets/diet.png',
                        width: 70,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: Text(
                          food.name.toString(),
                          textAlign: TextAlign.start,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const Align(
                        alignment: Alignment.bottomLeft,
                        child: Text(
                          "Rp.25000-,",
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
              .toList(),
        ),
      ),
    );
  }

  Widget _rating(Restaurant restaurant) {
    return Row(
      children: [
        RatingBarIndicator(
          direction: Axis.horizontal,
          rating: restaurant.rating,
          itemCount: 5,
          itemSize: 20,
          itemBuilder: (context, _) => const Icon(
            Icons.star,
            color: secondaryColor,
          ),
        ),
        Text(
          ' (${restaurant.rating})',
          style: textTheme.headlineSmall,
        ),
      ],
    );
  }
}
