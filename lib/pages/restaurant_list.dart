import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/constant/navigation.dart';
import 'package:restaurant_app/data/api/restaurant_api.dart';
import 'package:restaurant_app/constant/result_state.dart';
import 'package:restaurant_app/constant/style.dart';
import 'package:restaurant_app/data/models/list_restaurant.dart';
import 'package:restaurant_app/pages/restaurant_detail.dart';
import 'package:restaurant_app/provider/list_restaurant_provider.dart';
import 'package:restaurant_app/widget/title_widget.dart';

class RestaurantList extends StatelessWidget {
  const RestaurantList({Key? key}) : super(key: key);

  static const routeName = '/restaurant_list';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.only(
            top: 24,
            left: 15,
            right: 15,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const TitleWidget(),
                  IconButton(
                    onPressed: () => Navigator.pushNamed(context, '/search'),
                    icon: const Icon(
                      Icons.search,
                      size: 28,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Consumer<ListRestaurantProvider>(
                builder: (context, value, _) {
                  if (value.state == ResultState.loading) {
                    return Column(
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height / 3,
                        ),
                        Center(
                          child: LoadingAnimationWidget.beat(
                              color: secondaryColor, size: 40),
                        ),
                      ],
                    );
                  } else if (value.state == ResultState.hasData) {
                    return Expanded(
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: value.list.restaurants.length,
                        itemBuilder: (context, index) {
                          final restaurant = value.list.restaurants[index];
                          return _buildRestaurantCard(context, restaurant);
                        },
                      ),
                    );
                  } else if (value.state == ResultState.noData) {
                    return Center(
                      child: Text(value.message),
                    );
                  } else {
                    return const Center(
                      child: Text('No Internet Connection'),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRestaurantCard(BuildContext context, Restaurant restaurant) {
    return ListTile(
      onTap: () {
        Navigation.intentWithData(RestoDetail.routeName, restaurant.id);
      },
      contentPadding: const EdgeInsets.symmetric(vertical: 5),
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Image.network(
          RestaurantApi().mediumImage(restaurant.pictureId),
          width: 80,
          height: 120,
          fit: BoxFit.cover,
        ),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(restaurant.name, style: textTheme.headline6),
          Row(
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
              Text(" (${restaurant.rating})")
            ],
          ),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
      subtitle: Row(
        children: [
          const Icon(
            Icons.location_on,
            size: 15,
            color: Colors.redAccent,
          ),
          Text(restaurant.city),
        ],
      ),
      trailing: const Icon(Icons.chevron_right),
      visualDensity: VisualDensity.adaptivePlatformDensity,
    );
  }
}
