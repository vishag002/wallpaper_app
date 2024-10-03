import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'package:wallpaper_app/controller/collection_controller.dart';
import 'package:wallpaper_app/controller/favourite_controller.dart';
import 'package:wallpaper_app/controller/wallpaper_controller.dart';
import 'package:wallpaper_app/view/user_screen.dart';

class Tile extends StatelessWidget {
  final int index;

  const Tile({Key? key, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return index.isEven
        ? imageContainer(context)
        : collectionContainer(context);
  }

  Widget imageContainer(BuildContext context) {
    return Consumer2<WallpaperProvider, FavoriteProvider>(
      builder: (context, wallpaperProvider, favoriteProvider, child) {
        if (wallpaperProvider.isLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (wallpaperProvider.errorMessage != null) {
          return Center(child: Text(wallpaperProvider.errorMessage!));
        } else if (wallpaperProvider.wallpapers != null &&
            wallpaperProvider.wallpapers!.isNotEmpty &&
            index ~/ 2 < wallpaperProvider.wallpapers!.length) {
          final wallpaper = wallpaperProvider.wallpapers![index ~/ 2];
          return Stack(
            alignment: Alignment.bottomCenter,
            fit: StackFit.passthrough,
            children: [
              Container(
                height: MediaQuery.of(context).size.height * .3,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(15)),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: CachedNetworkImage(
                    imageUrl: wallpaper.urls?.regular ?? '',
                    fit: BoxFit.cover,
                    placeholder: (context, url) => BlurHash(
                      hash:
                          wallpaper.blurHash ?? 'LEHV6nWB2yk8pyo0adR*.7kCMdnj',
                    ),
                    errorWidget: (context, url, error) =>
                        const Center(child: Text('Failed to load image')),
                  ),
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height * .05,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(.7),
                  borderRadius:
                      BorderRadius.vertical(bottom: Radius.circular(10)),
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
                    IconButton(
                      onPressed: () {
                        favoriteProvider.toggleFavorite(wallpaper.id ?? '');
                      },
                      icon: Icon(
                        favoriteProvider.isFavorite(wallpaper.id ?? '')
                            ? Icons.favorite
                            : Icons.favorite_border,
                        size: 20,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              )
            ],
          );
        } else {
          return Center(child: const Text('No image available'));
        }
      },
    );
  }

  Widget collectionContainer(BuildContext context) {
    return Consumer<CollectionProvider>(
      builder: (context, provider, child) {
        if (provider.isLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (provider.error.isNotEmpty) {
          return Center(child: Text(provider.error));
        } else if (provider.collections.isEmpty ||
            index ~/ 2 >= provider.collections.length) {
          return const Center(child: Text('No collection available'));
        } else {
          final collection = provider.collections[index ~/ 2];
          return GestureDetector(
            onTap: () {
              if (collection != null) {
                Get.to(() => ArtistProfileScreen(collection: collection));
              }
            },
            child: Stack(
              alignment: Alignment.bottomCenter,
              fit: StackFit.passthrough,
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * .15,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        BlurHash(
                          hash: collection.coverPhoto?.blurHash ??
                              'LEHV6nWB2yk8pyo0adR*.7kCMdnj',
                          imageFit: BoxFit.cover,
                        ),
                        CachedNetworkImage(
                          imageUrl: collection.coverPhoto?.urls?.regular ?? '',
                          fit: BoxFit.cover,
                          placeholder: (context, url) => BlurHash(
                            hash: collection.coverPhoto?.blurHash ??
                                'LEHV6nWB2yk8pyo0adR*.7kCMdnj',
                          ),
                          errorWidget: (context, url, error) =>
                              const Center(child: Text('Failed to load image')),
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
                    borderRadius:
                        BorderRadius.vertical(bottom: Radius.circular(10)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Text(
                            collection.title ?? 'Unknown Collection',
                            style: TextStyle(color: Colors.white),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Text(
                          '${collection.totalPhotos ?? 0} photos',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
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
