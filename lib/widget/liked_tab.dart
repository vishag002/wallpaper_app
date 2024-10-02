import 'package:flutter/material.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class LikedTab extends StatelessWidget {
  final ScrollController scrollController;
  const LikedTab({super.key, required this.scrollController});

  @override
  Widget build(
    BuildContext context,
  ) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: MasonryGridView.count(
        controller: scrollController,
        crossAxisCount: 2,
        mainAxisSpacing: 15,
        crossAxisSpacing: 15,
        itemCount: 15,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              //to-do
              //   Get.to(() =>  WallpaperViewScreen());
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
                            BlurHash(
                              hash: 'LEHV6nWB2yk8pyo0adR*.7kCMdnj',
                              imageFit: BoxFit.cover,
                            ),
                            Image.network(
                              'https://images.unsplash.com/photo-1516062423079-7ca13cdc7f5a?q=80&w=1783&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
                              filterQuality: FilterQuality.high,
                              fit: BoxFit.cover,
                              loadingBuilder: (BuildContext context,
                                  Widget child,
                                  ImageChunkEvent? loadingProgress) {
                                if (loadingProgress == null) return child;
                                return BlurHash(
                                  hash: 'LEHV6nWB2yk8pyo0adR*.7kCMdnj',
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
                                "Name here",
                                style: TextStyle(color: Colors.white),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                          IconButton(
                            onPressed: () {
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
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
