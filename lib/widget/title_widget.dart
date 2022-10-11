import 'package:flutter/material.dart';
import 'package:restaurant_app/constant/style.dart';

class TitleWidget extends StatelessWidget {
  const TitleWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: const [
            Text(
              'Resto',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Finder',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: secondaryColor,
              ),
            ),
          ],
        ),
        const Text(
          'Find your favorite restaurant',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
