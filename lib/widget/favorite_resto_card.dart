import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/constant/navigation.dart';
import 'package:restaurant_app/constant/result_state.dart';
import 'package:restaurant_app/constant/style.dart';
import 'package:restaurant_app/data/api/restaurant_api.dart';
import 'package:restaurant_app/pages/restaurant_detail.dart';
import 'package:restaurant_app/provider/database_provider.dart';
import 'package:restaurant_app/provider/detail_restaurant_provider.dart';

class FavoriteRestoCard extends StatelessWidget {
  final String restaurantId;
  const FavoriteRestoCard({Key? key, required this.restaurantId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<DatabaseProvider>(
      builder: (context, provider, child) {
        return FutureBuilder(
          future: provider.isFavorite(restaurantId),
          builder: (context, snapshot) {
            var isFavorite = snapshot.data ?? false;
            return ChangeNotifierProvider<DetailRestaurantProvider>(
              create: (context) => DetailRestaurantProvider(
                restaurantApi: RestaurantApi(),
                id: restaurantId,
              ),
              child: Consumer<DetailRestaurantProvider>(
                builder: (context, state, child) {
                  if (state.state == ResultState.loading) {
                    return Center(
                      child: LoadingAnimationWidget.staggeredDotsWave(
                          color: secondaryColor, size: 40),
                    );
                  } else if (state.state == ResultState.hasData) {
                    return _buildCard(state);
                  } else {
                    return Center(
                      child: Text(state.message),
                    );
                  }
                },
              ),
            );
          },
        );
      },
    );
  }

  _buildCard(DetailRestaurantProvider state) {
    return GestureDetector(
      onTap: () =>
          Navigation.intentWithData(RestoDetail.routeName, restaurantId),
      child: Container(
        margin: const EdgeInsets.only(
          left: 24,
          right: 24,
          bottom: 30,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: primaryColor,
        ),
        width: double.maxFinite,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(15),
                topRight: Radius.circular(15),
              ),
              child: Image.network(
                RestaurantApi().largeImage(
                  state.detail.restaurant.pictureId,
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8, bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        state.detail.restaurant.name,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
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
                            state.detail.restaurant.address,
                            style: const TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      RatingBarIndicator(
                        rating: state.detail.restaurant.rating,
                        itemCount: 5,
                        itemSize: 15,
                        itemBuilder: (context, _) => const Icon(
                          Icons.star,
                          color: secondaryColor,
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
