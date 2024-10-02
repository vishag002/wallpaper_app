import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'package:flutter_wallpaper_manager/flutter_wallpaper_manager.dart';
import 'package:get/get.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:wallpaper_app/model/api_model.dart';
import 'package:wallpaper_app/utilis/text_const.dart';

class WallpaperViewScreen extends StatefulWidget {
  final MyClass wallpaper;

  const WallpaperViewScreen({super.key, required this.wallpaper});

  @override
  State<WallpaperViewScreen> createState() => _WallpaperViewScreenState();
}

class _WallpaperViewScreenState extends State<WallpaperViewScreen> {
  Future<void> _setWallpaper(String url, int location) async {
    try {
      var file = await DefaultCacheManager().getSingleFile(url);
      final bool result =
          await WallpaperManager.setWallpaperFromFile(file.path, location);
      print("Wallpaper set: $result");
    } on PlatformException {
      print("Failed to set wallpaper.");
    }
  }

  Future<void> setHomeScreenWallpaper(String url) async {
    await _setWallpaper(url, WallpaperManager.HOME_SCREEN);
  }

  Future<void> setLockScreenWallpaper(String url) async {
    await _setWallpaper(url, WallpaperManager.LOCK_SCREEN);
  }

  Future<void> setBothScreenWallpaper(String url) async {
    await _setWallpaper(url, WallpaperManager.BOTH_SCREEN);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: theme.primary,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: Column(
          children: [
            Stack(
              alignment: Alignment.topCenter,
              fit: StackFit.passthrough,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * .6,
                  child: ClipRRect(
                    borderRadius:
                        BorderRadius.vertical(bottom: Radius.circular(15)),
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        BlurHash(
                          hash: widget.wallpaper.blurHash ??
                              'LEHV6nWB2yk8pyo0adR*.7kCMdnj',
                          imageFit: BoxFit.cover,
                        ),
                        Image.network(
                          widget.wallpaper.urls?.regular ?? '',
                          filterQuality: FilterQuality.high,
                          fit: BoxFit.cover,
                          loadingBuilder: (BuildContext context, Widget child,
                              ImageChunkEvent? loadingProgress) {
                            if (loadingProgress == null) return child;
                            return BlurHash(
                              hash: widget.wallpaper.blurHash ??
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
                  height: MediaQuery.of(context).size.height * .1,
                  width: double.infinity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed: () {
                          Get.back();
                        },
                        icon: Icon(
                          Icons.close,
                          size: 30,
                          color: Colors.white,
                        ),
                      ),
                      IconButton(
                          onPressed: () {
                            // Implement share functionality
                          },
                          icon: Icon(
                            Icons.share_rounded,
                            size: 30,
                            color: Colors.white,
                          ))
                    ],
                  ),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.wallpaper.user?.name ?? "Unknown",
                    style: TextStyles.title.copyWith(
                      color: theme.secondary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Row(
                    children: [
                      IconButton(
                          onPressed: () {
                            // Implement add to favorites functionality
                          },
                          icon: const Icon(
                            Icons.favorite_border,
                            size: 30,
                          )),
                      Text("${widget.wallpaper.likes ?? 0}") // Like count
                    ],
                  )
                ],
              ),
            ),
            InkWell(
              onTap: () {
                // Get.to(ArtistProfileScreen());
              },
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundImage: NetworkImage(
                        widget.wallpaper.user?.profileImage?.medium ?? ''),
                  ),
                  SizedBox(width: 10),
                  Text(widget.wallpaper.user?.username ?? "Unknown"),
                ],
              ),
            ),
            Text(widget.wallpaper.altDescription ?? "No description available"),
            Text(
                "Created at: ${widget.wallpaper.createdAt?.toString() ?? 'Unknown'}"),
            SizedBox(height: 50),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                InkWell(
                  onTap: () {
                    showBottomSheet(context);
                  },
                  child: Container(
                    height: 70,
                    width: 150,
                    color: Colors.blue,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.download,
                          size: 20,
                          color: Colors.white,
                        ),
                        SizedBox(width: 10),
                        Text("Download", style: TextStyle(color: Colors.white))
                      ],
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  void showBottomSheet(context) {
    showCupertinoModalPopup(
      context: context,
      builder: (context) => BottomSheetWidget(
        setHomeWallpaper: () =>
            setHomeScreenWallpaper(widget.wallpaper.urls?.regular ?? ''),
        setLockWallpaper: () =>
            setLockScreenWallpaper(widget.wallpaper.urls?.regular ?? ''),
        setBothWallpaper: () =>
            setBothScreenWallpaper(widget.wallpaper.urls?.regular ?? ''),
      ),
    );
  }
}

class BottomSheetWidget extends StatelessWidget {
  final VoidCallback setHomeWallpaper;
  final VoidCallback setLockWallpaper;
  final VoidCallback setBothWallpaper;

  const BottomSheetWidget({
    required this.setHomeWallpaper,
    required this.setLockWallpaper,
    required this.setBothWallpaper,
  });

  @override
  Widget build(BuildContext context) {
    return CupertinoActionSheet(
      title: Text("Options"),
      actions: [
        CupertinoActionSheetAction(
          child: Text(
            "Download",
            style: TextStyles.title.copyWith(
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
          onPressed: () {},
        ),
        CupertinoActionSheetAction(
          child: Text(
            "Set as Home Screen Wallpaper",
            style: TextStyles.title.copyWith(
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
          onPressed: setHomeWallpaper,
        ),
        CupertinoActionSheetAction(
          child: Text(
            "Set as Lock Screen Wallpaper",
            style: TextStyles.title.copyWith(
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
          onPressed: setLockWallpaper,
        ),
        CupertinoActionSheetAction(
          child: Text(
            "Set as Both",
            style: TextStyles.title.copyWith(
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
          onPressed: setBothWallpaper,
        ),
      ],
      cancelButton: CupertinoActionSheetAction(
        child: Text(
          "Cancel",
          style: TextStyles.title.copyWith(
            color: Theme.of(context).colorScheme.secondary,
          ),
        ),
        isDefaultAction: true,
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}
