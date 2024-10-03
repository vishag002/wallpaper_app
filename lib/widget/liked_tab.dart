import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:wallpaper_app/controller/favourite_controller.dart';
import 'package:wallpaper_app/controller/wallpaper_controller.dart';
import 'package:wallpaper_app/view/wallpaper_view_screen.dart';

class LikedTab extends StatelessWidget {
  final ScrollController scrollController;
  const LikedTab({super.key, required this.scrollController});

  @override
  Widget build(
    BuildContext context,
  ) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Consumer2<FavoriteProvider, WallpaperProvider>(
        builder: (context, favoriteProvider, wallpaperProvider, child) {
          final favorites = favoriteProvider.favorites;
          final favoriteWallpapers = wallpaperProvider.wallpapers
              ?.where((wallpaper) => favorites.contains(wallpaper.id))
              .toList();

          if (favoriteWallpapers == null || favoriteWallpapers.isEmpty) {
            return Center(child: Text('No favorites yet'));
          }
          return MasonryGridView.count(
            controller: scrollController,
            crossAxisCount: 2,
            mainAxisSpacing: 15,
            crossAxisSpacing: 15,
            itemCount: favoriteWallpapers.length,
            itemBuilder: (context, index) {
              final wallpaper = favoriteWallpapers[index];

              return InkWell(
                onTap: () {
                  //to-do
                  Get.to(() => WallpaperViewScreen(wallpaper: wallpaper));
                },
                child: Column(
                  children: [
                    Stack(
                      alignment: Alignment.bottomCenter,
                      fit: StackFit.passthrough,
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.height * .3,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Stack(
                              fit: StackFit.expand,
                              children: [
                                CachedNetworkImage(
                                  imageUrl: wallpaper.urls?.regular ?? '',
                                  fit: BoxFit.cover,
                                  placeholder: (context, url) => BlurHash(
                                    hash: wallpaper.blurHash ??
                                        'LEHV6nWB2yk8pyo0adR*.7kCMdnj',
                                  ),
                                  errorWidget: (context, url, error) =>
                                      const Center(
                                          child: Text('Failed to load image')),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          height: MediaQuery.of(context).size.height * .05,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(.7),
                            borderRadius: BorderRadius.vertical(
                                bottom: Radius.circular(10)),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Text(
                                    wallpaper.user?.name ?? 'Unknown',
                                    style: TextStyle(color: Colors.white),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ),
                              Consumer<FavoriteProvider>(
                                builder: (context, favoriteProvider, child) {
                                  return IconButton(
                                    onPressed: () {
                                      favoriteProvider
                                          .toggleFavorite(wallpaper.id ?? '');
                                    },
                                    icon: Icon(
                                      Icons.favorite,
                                      size: 20,
                                      color: Colors.white,
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
