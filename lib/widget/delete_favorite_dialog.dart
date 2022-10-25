import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:restaurant_app/constant/navigation.dart';
import 'package:restaurant_app/constant/style.dart';
import 'package:restaurant_app/provider/database_provider.dart';
import 'package:restaurant_app/provider/detail_restaurant_provider.dart';

class DeleteFavoriteDialog extends StatelessWidget {
  final String restoId;
  final DatabaseProvider databaseProvider;
  final DetailRestaurantProvider dataRestaurantProvider;

  const DeleteFavoriteDialog({
    Key? key,
    required this.restoId,
    required this.databaseProvider,
    required this.dataRestaurantProvider,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Delete Favorite Resto?'),
      content: const Text(
        'Are you sure you want to delete this restaurant from your favorite list?',
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigation.back();
          },
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            databaseProvider.removeFavorite(restoId);
            Navigation.back();
            Fluttertoast.showToast(
              msg:
                  '${dataRestaurantProvider.detail.restaurant.name} successfully removed from favorite',
              backgroundColor: secondaryColor,
              textColor: Colors.white,
              gravity: ToastGravity.BOTTOM,
            );
          },
          child: const Text('Delete'),
        ),
      ],
    );
  }
}
