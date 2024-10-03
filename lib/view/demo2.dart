// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:wallpaper_app/controller/collection_controller.dart';

// class CollectionListView extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Consumer<CollectionProvider>(
//       builder: (context, provider, child) {
//         if (provider.isLoading) {
//           return Center(child: CircularProgressIndicator());
//         } else if (provider.error.isNotEmpty) {
//           return Center(child: Text(provider.error));
//         } else if (provider.collections.isEmpty) {
//           return Center(child: Text('No collections available'));
//         } else {
//           return ListView.builder(
//             itemCount: provider.collections.length,
//             itemBuilder: (context, index) {
//               final collection = provider.collections[index];
//               return Card(
//                 child: Column(
//                   children: [
//                     collection.coverPhoto?.urls?.small != null
//                         ? Image.network(
//                             collection.coverPhoto!.urls!.small!,
//                             fit: BoxFit.cover,
//                             height: 200,
//                             width: double.infinity,
//                           )
//                         : Container(
//                             height: 200,
//                             color: Colors.grey,
//                             child: Center(child: Text('No image available')),
//                           ),
//                     ListTile(
//                       title: Text(collection.title ?? 'Untitled Collection'),
//                       subtitle:
//                           Text('Total Photos: ${collection.totalPhotos ?? 0}'),
//                     ),
//                   ],
//                 ),
//               );
//             },
//           );
//         }
//       },
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'package:wallpaper_app/controller/favourite_controller.dart';
import 'package:wallpaper_app/controller/wallpaper_controller.dart';
import 'package:wallpaper_app/model/api_model.dart';
import 'package:wallpaper_app/view/wallpaper_view_screen.dart';

class FavoritesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favorites'),
      ),
      body: Consumer2<FavoriteProvider, WallpaperProvider>(
        builder: (context, favoriteProvider, wallpaperProvider, child) {
          final favorites = favoriteProvider.favorites;
          final favoriteWallpapers = wallpaperProvider.wallpapers
              ?.where((wallpaper) => favorites.contains(wallpaper.id))
              .toList();

          if (favoriteWallpapers == null || favoriteWallpapers.isEmpty) {
            return Center(child: Text('No favorites yet'));
          }

          return GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.7,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemCount: favoriteWallpapers.length,
            itemBuilder: (context, index) {
              final wallpaper = favoriteWallpapers[index];
              return FavoriteTile(wallpaper: wallpaper);
            },
          );
        },
      ),
    );
  }
}

class FavoriteTile extends StatelessWidget {
  final MyClass wallpaper;

  const FavoriteTile({Key? key, required this.wallpaper}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => WallpaperViewScreen(wallpaper: wallpaper),
          ),
        );
      },
      child: Stack(
        alignment: Alignment.bottomCenter,
        fit: StackFit.passthrough,
        children: [
          Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: CachedNetworkImage(
                imageUrl: wallpaper.urls?.regular ?? '',
                fit: BoxFit.cover,
                placeholder: (context, url) => BlurHash(
                  hash: wallpaper.blurHash ?? 'LEHV6nWB2yk8pyo0adR*.7kCMdnj',
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
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(10)),
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
                        favoriteProvider.toggleFavorite(wallpaper.id ?? '');
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
    );
  }
}
