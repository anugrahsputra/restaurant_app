import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/data/api/restaurant_api.dart';
import 'package:restaurant_app/constant/style.dart';
import 'package:restaurant_app/data/db/database_helper.dart';
import 'package:restaurant_app/pages/main_page.dart';
import 'package:restaurant_app/provider/bottom_navbar_provider.dart';
import 'package:restaurant_app/provider/database_provider.dart';
import 'package:restaurant_app/provider/list_restaurant_provider.dart';
import 'package:restaurant_app/provider/schedule_provider.dart';
import 'package:restaurant_app/provider/search_restaurant_provider.dart';
import 'package:restaurant_app/pages/restaurant_detail.dart';
import 'package:restaurant_app/pages/search_page.dart';
import 'package:restaurant_app/provider/shared_preferances_provider.dart';
import 'package:restaurant_app/utils/background_service.dart';
import 'package:restaurant_app/utils/notification_helper.dart';

FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final NotificationHelper notificationHelper = NotificationHelper();
  final BackgroundService service = BackgroundService();

  service.initializeIsolate();

  await AndroidAlarmManager.initialize();
  await notificationHelper.initNotifications(flutterLocalNotificationsPlugin);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => BottomNavBar(),
        ),
        ChangeNotifierProvider(
          create: (context) =>
              ListRestaurantProvider(restaurantApi: RestaurantApi()),
        ),
        ChangeNotifierProvider(
          create: (context) =>
              SearchRestaurantProvider(restaurantApi: RestaurantApi()),
        ),
        ChangeNotifierProvider(
          create: (context) => DatabaseProvider(
            databaseHelper: DatabaseHelper(),
          ),
        ),
        ChangeNotifierProvider(
          create: (context) => ScheduleProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => SharedPreferencesProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Restaurant App',
        theme: ThemeData(
          colorScheme: Theme.of(context).colorScheme.copyWith(
                primary: primaryColor,
                secondary: secondaryColor,
              ),
          textTheme: textTheme,
          appBarTheme: const AppBarTheme(elevation: 0),
          scaffoldBackgroundColor: Colors.white,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        initialRoute: Mainpage.routeName,
        routes: {
          Mainpage.routeName: (context) => const Mainpage(),
          RestoDetail.routeName: (context) => RestoDetail(
                id: ModalRoute.of(context)?.settings.arguments as String,
              ),
          Search.routeName: (context) => const Search(),
        },
      ),
    );
  }
}
