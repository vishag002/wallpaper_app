import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'package:get/get.dart';

class WallpaperViewScreen extends StatelessWidget {
  const WallpaperViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Stack(
            alignment: Alignment.topCenter,
            fit: StackFit.passthrough,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * .6,
                child: ClipRRect(
                  borderRadius:
                      BorderRadius.vertical(bottom: Radius.circular(30)),
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      // BlurHash placeholder while the image is loading
                      const BlurHash(
                        hash:
                            'LEHV6nWB2yk8pyo0adR*.7kCMdnj', // Replace with your own blur hash
                        imageFit: BoxFit.cover,
                      ),
                      // The actual image
                      Image.network(
                        'https://images.unsplash.com/photo-1516062423079-7ca13cdc7f5a?q=80&w=1783&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
                        filterQuality: FilterQuality.high,
                        fit: BoxFit.cover,
                        loadingBuilder: (BuildContext context, Widget child,
                            ImageChunkEvent? loadingProgress) {
                          if (loadingProgress == null) return child;
                          return const BlurHash(
                            hash:
                                'LEHV6nWB2yk8pyo0adR*.7kCMdnj', // Same hash used as a fallback
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
                    Row(
                      children: [
                        IconButton(
                            onPressed: () {
                              //
                            },
                            icon: Icon(
                              Icons.favorite_border,
                              size: 30,
                              color: Colors.white,
                            )),
                        IconButton(
                            onPressed: () {
                              //
                            },
                            icon: Icon(
                              Icons.share_rounded,
                              size: 30,
                              color: Colors.white,
                            ))
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
          Text("NAME"),
          InkWell(
            onTap: () {
              print("imaage downloaded");
            },
            child: Container(
              height: 40,
              width: 150,
              color: Colors.blue,
              child: Row(
                children: [
                  Icon(
                    Icons.download,
                    size: 20,
                  ),
                  Text("GET WALLPAPER")
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
