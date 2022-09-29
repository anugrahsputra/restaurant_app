import 'package:flutter/material.dart';
import 'package:restaurant_app/constant/style.dart';

class TitleWidget extends StatelessWidget {
  const TitleWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: const [
        Text(
          'Resto',
          style: TextStyle(
            fontSize: 57,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          'Find',
          style: TextStyle(
            fontSize: 57,
            fontWeight: FontWeight.bold,
            color: secondaryColor,
          ),
        ),
      ],
    );
  }
}
