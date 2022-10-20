import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:restaurant_app/constant/style.dart';
import 'package:restaurant_app/provider/database_provider.dart';
import 'package:restaurant_app/provider/detail_restaurant_provider.dart';

class DeleteFavoriteDialog extends StatefulWidget {
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
  State<DeleteFavoriteDialog> createState() => _DeleteFavoriteDialogState();
}

class _DeleteFavoriteDialogState extends State<DeleteFavoriteDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Delete Favorite Resto?'),
      content: const Text(
        'Are you sure you want to delete this restaurant from your favorite list?',
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            widget.databaseProvider.removeFavorite(widget.restoId);
            // Navigator.popAndPushNamed(context, Mainpage.routeName);
            Navigator.pop(context);
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(
            //     builder: (context) => Mainpage(),
            //   ),
            // );
            Fluttertoast.showToast(
              msg:
                  '${widget.dataRestaurantProvider.detail.restaurant.name} successfully removed from favorite',
              backgroundColor: secondaryColor,
              textColor: Colors.white,
              gravity: ToastGravity.BOTTOM,
            );
            setState(() {});
          },
          child: const Text('Delete'),
        ),
      ],
    );
  }
}
