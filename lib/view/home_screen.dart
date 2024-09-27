import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';
import 'package:wallpaper_app/controller/wallpaper_controller.dart';
import 'package:wallpaper_app/utilis/text_const.dart';
import 'package:wallpaper_app/widget/liked_tab.dart';
import 'package:wallpaper_app/widget/staggered_grid_wid.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: theme.primary,
        appBar: AppBar(
          toolbarHeight: 90,
          centerTitle: true,
          title: CircleAvatar(
            backgroundColor: Colors.amber,
            radius: 40,
          ),
          bottom: TabBar(
            //  dividerColor: Colors.orange,
            labelStyle: TextStyles.body.copyWith(color: theme.secondary),
            indicatorColor: Colors.deepOrange,
            indicatorPadding: EdgeInsets.only(bottom: 5),
            tabs: [
              Tab(text: 'For You'),
              Tab(text: 'Liked'),
              Tab(text: 'Library'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            expandedWidget(context),
            LikedTab(),
            const Center(child: Text('Library Content')),
          ],
        ),
      ),
    );
  }
}

Widget expandedWidget(BuildContext context) {
  final provider = Provider.of<WallpaperProvider>(context, listen: false);
  return LayoutBuilder(
    builder: (BuildContext context, BoxConstraints constraints) {
      return SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: StaggeredGrid.count(
            crossAxisCount: 2,
            mainAxisSpacing: 15,
            crossAxisSpacing: 15,
            children: List.generate(
              provider.wallpapers!.length + 2,
              (index) {
                bool isCollectionContainer = index == 0 || index == 10;
                return InkWell(
                  onTap: () {
                    if (isCollectionContainer) {
                      print("Collection container pressed at index: $index");
                    } else {
                      print("Image container pressed at index: $index");
                    }
                  },
                  child: isCollectionContainer
                      ? Tile(index: index * 2 + 1)
                      : Tile(index: (index > 9 ? index - 1 : index) * 2),
                );
              },
            ),
          ),
        ),
      );
    },
  );
}
