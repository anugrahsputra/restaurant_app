import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/constant/navigation.dart';
import 'package:restaurant_app/data/api/restaurant_api.dart';
import 'package:restaurant_app/constant/result_state.dart';
import 'package:restaurant_app/constant/style.dart';
import 'package:restaurant_app/data/models/detail_restaurant.dart';
import 'package:restaurant_app/pages/main_page.dart';
import 'package:restaurant_app/provider/database_provider.dart';
import 'package:restaurant_app/provider/detail_restaurant_provider.dart';
import 'package:restaurant_app/widget/expanded_text.dart';

class RestoDetail extends StatefulWidget {
  const RestoDetail({
    Key? key,
    required this.id,
  }) : super(key: key);

  static const routeName = '/restaurant_detail';

  final String id;

  @override
  State<RestoDetail> createState() => _RestoDetailState();
}

class _RestoDetailState extends State<RestoDetail> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<DetailRestaurantProvider>(
      create: (context) => DetailRestaurantProvider(
        restaurantApi: RestaurantApi(),
        id: widget.id,
      ),
      child: Scaffold(
        body: Consumer<DetailRestaurantProvider>(
          builder: (context, state, _) {
            if (state.state == ResultState.loading) {
              return Center(
                child: LoadingAnimationWidget.staggeredDotsWave(
                    color: secondaryColor, size: 40),
              );
            } else if (state.state == ResultState.hasData) {
              return CustomScrollView(
                slivers: [
                  SliverAppBar(
                    leading: Center(
                      child: IconButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const Mainpage(),
                              ));
                        },
                        icon: const Icon(
                          MdiIcons.chevronLeftCircle,
                          size: 35,
                        ),
                      ),
                    ),
                    pinned: true,
                    expandedHeight: 300,
                    flexibleSpace: FlexibleSpaceBar(
                      background: Image.network(
                        RestaurantApi()
                            .largeImage(state.detail.restaurant.pictureId),
                        width: double.maxFinite,
                        fit: BoxFit.cover,
                      ),
                    ),
                    bottom: PreferredSize(
                      preferredSize: const Size.fromHeight(95),
                      child: SingleChildScrollView(
                        child: Container(
                          padding: const EdgeInsets.only(
                              left: 24, right: 24, top: 20, bottom: 10),
                          width: double.maxFinite,
                          decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(20),
                              )),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    state.detail.restaurant.name,
                                    style: const TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.location_on,
                                        color: Colors.red,
                                        size: 15,
                                      ),
                                      Text(
                                        state.detail.restaurant.city,
                                        style: textTheme.bodyText1,
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  _rating(state.detail.restaurant),
                                ],
                              ),
                              Consumer<DatabaseProvider>(
                                builder: (context, provider, child) {
                                  return FutureBuilder(
                                    future: provider
                                        .isFavorite(state.detail.restaurant.id),
                                    builder: (context, snapshot) {
                                      var isFavorite = snapshot.data ?? false;
                                      if (isFavorite == true) {
                                        return IconButton(
                                          onPressed: () {
                                            provider.removeFavorite(
                                                state.detail.restaurant.id);
                                            Fluttertoast.showToast(
                                              msg:
                                                  '${state.detail.restaurant.name} removed from favorite',
                                              backgroundColor: secondaryColor,
                                              textColor: Colors.white,
                                              gravity: ToastGravity.BOTTOM,
                                            );
                                            setState(() {});
                                          },
                                          icon: const Icon(
                                            MdiIcons.heartCircle,
                                            size: 50,
                                            color: Colors.redAccent,
                                          ),
                                        );
                                      } else {
                                        return IconButton(
                                          onPressed: () {
                                            provider.addFavorite(
                                                state.detail.restaurant.id);
                                            Fluttertoast.showToast(
                                              msg:
                                                  '${state.detail.restaurant.name} added to favorite',
                                              backgroundColor: secondaryColor,
                                              textColor: Colors.white,
                                              gravity: ToastGravity.BOTTOM,
                                            );
                                            setState(() {});
                                          },
                                          icon: const Icon(
                                            MdiIcons.heartCircleOutline,
                                            size: 50,
                                            color: Colors.redAccent,
                                          ),
                                        );
                                      }
                                    },
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 10,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Description',
                            style: textTheme.headline6,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          ExpandedText(
                            text: state.detail.restaurant.description,
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 23, bottom: 10),
                          child: Text(
                            'Menu',
                            style: textTheme.headlineMedium,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24),
                          child: Text(
                            'Drinks',
                            style: textTheme.headlineSmall,
                          ),
                        ),
                        _buildDrinks(context, state.detail.restaurant),
                        const SizedBox(
                          height: 15,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24),
                          child: Text(
                            'Foods',
                            style: textTheme.headlineSmall,
                          ),
                        ),
                        _buildFoods(context, state.detail.restaurant),
                        const SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  )
                ],
              );
            } else if (state.state == ResultState.noData) {
              return Center(
                child: Text(state.message),
              );
            } else {
              return const Center(
                child: Text('No Internet Connection'),
              );
            }
          },
        ),
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
          itemSize: 15,
          itemBuilder: (context, _) => const Icon(
            Icons.star,
            color: secondaryColor,
          ),
        ),
        Text(
          ' (${restaurant.rating})',
          style: const TextStyle(fontSize: 15),
        ),
      ],
    );
  }
}
