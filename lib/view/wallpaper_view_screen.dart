import 'package:flutter/material.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'package:get/get.dart';
import 'package:wallpaper_app/model/api_model.dart';
import 'package:wallpaper_app/utilis/text_const.dart';
import 'package:wallpaper_app/view/user_screen.dart';

class WallpaperViewScreen extends StatelessWidget {
  final MyClass wallpaper;

  const WallpaperViewScreen({Key? key, required this.wallpaper})
      : super(key: key);

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
                        // BlurHash placeholder while the image is loading
                        BlurHash(
                          hash: wallpaper.blurHash ??
                              'LEHV6nWB2yk8pyo0adR*.7kCMdnj',
                          imageFit: BoxFit.cover,
                        ),
                        // The actual image
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
                  height: MediaQuery.of(context).size.height * .1,
                  width: double.infinity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed: () {
                          print("iconbutton pressed");
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
                    wallpaper.user?.name ?? "Unknown",
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
                          icon: Icon(
                            Icons.favorite_border,
                            size: 30,
                          )),
                      Text("${wallpaper.likes ?? 0}") // Like count
                    ],
                  )
                ],
              ),
            ),
            InkWell(
              onTap: () {
                //  Get.to(ArtistProfileScreen());
              },
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundImage: NetworkImage(
                        wallpaper.user?.profileImage?.medium ?? ''),
                  ),
                  SizedBox(width: 10),
                  Text(wallpaper.user?.username ?? "Unknown"),
                ],
              ),
            ),
            Text(wallpaper.altDescription ?? "No description available"),
            Text("Created at: ${wallpaper.createdAt?.toString() ?? 'Unknown'}"),
            SizedBox(height: 50),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                InkWell(
                  onTap: () {
                    // Implement full resolution download
                    print("Full resolution image downloaded");
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
                        Text("Full resolution",
                            style: TextStyle(color: Colors.white))
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    // Implement SD quality download
                    print("SD quality image downloaded");
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
                        Text("SD quality",
                            style: TextStyle(color: Colors.white))
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
}
