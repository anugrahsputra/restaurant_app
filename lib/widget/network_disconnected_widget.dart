import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class NetworkDisconnected extends StatelessWidget {
  const NetworkDisconnected({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: Column(
          children: const [
            Icon(
              MdiIcons.connection,
              size: 80,
              color: Color(0xffd3d3d3),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'Check Your Internet Connection',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xffd3d3d3),
              ),
            )
          ],
        ),
      ),
    );
  }
}
