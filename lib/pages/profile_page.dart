import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/constant/style.dart';
import 'package:restaurant_app/main.dart';
import 'package:restaurant_app/provider/schedule_provider.dart';
import 'package:restaurant_app/utils/notification_helper.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);
  static const routeName = '/profile-page';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            _profile(),
            _notifications(),
            Center(
              child: ElevatedButton(
                onPressed: () async {
                  await NotificationHelper()
                      .showNotification(flutterLocalNotificationsPlugin);
                },
                child: const Text('test notification'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _profile() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
      child: Center(
        child: Column(
          children: [
            CircleAvatar(
              backgroundImage: const NetworkImage(
                'https://drive.google.com/uc?id=1mvFT04TvqDrQIhABphtyeyN7v_J-5Ap3',
              ),
              radius: 48,
              onBackgroundImageError: (e, s) {
                debugPrint('image issue $e, $s');
              },
            ),
            const SizedBox(height: 10),
            const Text(
              'Anugrah Surya Putra',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
            ),
            const SizedBox(height: 5),
            const Text(
              'anugrahsputra@gmail.com',
              style: TextStyle(
                fontWeight: FontWeight.w300,
                fontSize: 18,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _notifications() {
    return ListTile(
      leading: const Icon(
        MdiIcons.bell,
        size: 25,
      ),
      title: const Text(
        'Notification',
        style: TextStyle(fontSize: 18),
      ),
      trailing: Consumer<ScheduleProvider>(
        builder: (context, schedule, child) {
          return Switch.adaptive(
            value: schedule.isScheduled,
            onChanged: (value) async {
              schedule.scheduledNotification(value);
              if (value == true) {
                Fluttertoast.showToast(
                  msg: 'Notification Enabled',
                  gravity: ToastGravity.BOTTOM,
                  backgroundColor: secondaryColor,
                  textColor: Colors.white,
                );
              } else {
                Fluttertoast.showToast(
                  msg: 'Notification Disabled',
                  gravity: ToastGravity.BOTTOM,
                  backgroundColor: secondaryColor,
                  textColor: Colors.white,
                );
              }
            },
          );
        },
      ),
    );
  }
}
