import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/constant/result_state.dart';
import 'package:restaurant_app/constant/style.dart';
import 'package:restaurant_app/pages/main_page.dart';
import 'package:restaurant_app/provider/database_provider.dart';
import 'package:restaurant_app/widget/favorite_resto_card.dart';
import 'package:restaurant_app/widget/page_title_widget.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({Key? key}) : super(key: key);

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  @override
  void initState() {
    super.initState();
    setState(() {
      _buildList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () => Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => Mainpage(),
            ),
          ),
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const PageTitle(title: 'Your Favorite Resto', size: 30),
                _buildList(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildList() {
    return Consumer<DatabaseProvider>(
      builder: (context, provider, child) {
        if (provider.state == ResultState.loading) {
          return Center(
            child: LoadingAnimationWidget.staggeredDotsWave(
                color: secondaryColor, size: 40),
          );
        } else if (provider.state == ResultState.hasData) {
          return ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: provider.favorite.length,
            itemBuilder: (context, index) {
              var resto = provider.favorite[index];

              return FavoriteRestoCard(
                restaurantId: resto,
              );
            },
          );
        } else {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height / 3.5,
                ),
                const Icon(
                  MdiIcons.food,
                  size: 75,
                  color: Color(0xffd3d3d3),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  'You don\'t have any favorite resto',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xffd3d3d3),
                  ),
                )
              ],
            ),
          );
        }
      },
    );
  }
}
