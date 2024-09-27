import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'package:wallpaper_app/controller/wallpaper_controller.dart';

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
    return Consumer<WallpaperProvider>(
      builder: (context, provider, child) {
        if (provider.isLoading) {
          return Center(
              child: CircularProgressIndicator(
            color: Colors.transparent,
          ));
        } else if (provider.errorMessage != null) {
          return Center(child: Text(provider.errorMessage!));
        } else if (provider.wallpapers != null &&
            provider.wallpapers!.isNotEmpty &&
            index ~/ 2 < provider.wallpapers!.length) {
          final wallpaper = provider.wallpapers![index ~/ 2];
          return Stack(
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
                      BlurHash(
                        hash: wallpaper.blurHash ??
                            'LEHV6nWB2yk8pyo0adR*.7kCMdnj',
                        imageFit: BoxFit.cover,
                      ),
                      Image.network(
                        wallpaper.urls?.regular ?? '',
                        filterQuality: FilterQuality.high,
                        fit: BoxFit.cover,
                        loadingBuilder: (BuildContext context, Widget child,
                            ImageChunkEvent? loadingProgress) {
                          if (loadingProgress == null) return child;
                          return BlurHash(
                            hash: wallpaper.blurHash ??
                                'LEHV6nWB2yk8pyo0adR*.7kCMdnj',
                          );
                        },
                        errorBuilder: (context, error, stackTrace) {
                          return const Center(
                              child: Text('Failed to load image'));
                        },
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
                          wallpaper.user?.name ?? 'Unknown',
                          style: TextStyle(color: Colors.white),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        print("iconbutton pressed for image ${wallpaper.id}");
                        //on pressed save to favourites
                      },
                      icon: Icon(
                        Icons.favorite_border,
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
          return Center(child: Text('No image available'));
        }
      },
    );
  }

  Widget collectionContainer(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * .15,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.black,
      ),
      child: Center(
        child: Text(
          'Collection ${(index + 1) ~/ 2}',
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
      ),
    );
  }
}
