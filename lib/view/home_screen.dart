import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:wallpaper_app/controller/carousel_controller.dart';
import 'package:wallpaper_app/view/collection_screen.dart';
import 'package:wallpaper_app/view/wallpaper_view_screen.dart';

class HomeScreen extends StatelessWidget {
  final List<String> imageUrls = [
    'https://images.unsplash.com/photo-1485550409059-9afb054cada4?q=80&w=1965&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
    'https://images.unsplash.com/photo-1516062423079-7ca13cdc7f5a?q=80&w=1783&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
    'https://images.unsplash.com/photo-1485550409059-9afb054cada4?q=80&w=1965&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
    'https://images.unsplash.com/photo-1458682625221-3a45f8a844c7?q=80&w=1974&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
    'https://images.unsplash.com/photo-1516062423079-7ca13cdc7f5a?q=80&w=1783&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
  ];

  final List<String> imageTitle = [
    'As seen on\nMkBHD',
    'Featured Artist',
    'Wallpaper\nof the Week',
    'Collection\nof the Week',
    'Upgrade\nto Panels+'
  ];

  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: MediaQuery.of(context).size.height / 2.64,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              titlePadding: EdgeInsets.only(bottom: 30),

              // Dynamically updating the title based on the current carousel index
              title: Consumer<CarouselControllerProvider>(
                builder: (context, provider, _) {
                  return Text(
                    imageTitle[provider.currentIndex],
                    textAlign: TextAlign.center,
                  );
                },
              ),
              background: Column(
                children: [
                  Consumer<CarouselControllerProvider>(
                    builder: (context, provider, _) => Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.height / 2.3,
                          width: double.infinity,
                          color: Colors.grey,
                          child: CarouselSlider(
                            items: imageUrls
                                .map(
                                  (e) => Container(
                                    height: 200,
                                    width: MediaQuery.of(context).size.width,
                                    decoration: BoxDecoration(
                                      color: Colors.red,
                                      image: DecorationImage(
                                        image: NetworkImage(e),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                )
                                .toList(),
                            carouselController: provider.controller,
                            options: CarouselOptions(
                              animateToClosest: true,
                              autoPlay: true,
                              aspectRatio: .5,
                              autoPlayAnimationDuration: Duration(seconds: 1),
                              autoPlayInterval: Duration(seconds: 10),
                              autoPlayCurve: Curves.linear,
                              enlargeCenterPage: false,
                              enableInfiniteScroll: true,
                              viewportFraction: 1,
                              onPageChanged: (index, reason) {
                                // Update the current index when the page changes
                                provider.setCurrentIndex(index);
                              },
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 10,
                          child: slideIndicator(context, imageUrls, provider),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          searchButton(),
          expandedWidget(),
        ],
      ),
    );
  }

  //slideIndicator
  Widget slideIndicator(BuildContext context, List<String> imageUrls,
      CarouselControllerProvider provider) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: imageUrls.asMap().entries.map((entry) {
        return GestureDetector(
          onTap: () => provider.animateToPage(entry.key),
          child: Container(
            width: 8.0,
            height: 8.0,
            margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: (Theme.of(context).brightness == Brightness.dark
                      ? Colors.black
                      : Colors.white)
                  .withOpacity(provider.currentIndex == entry.key ? 1 : 0.4),
            ),
          ),
        );
      }).toList(),
    );
  }

  //search button
  Widget searchButton() {
    return SliverToBoxAdapter(
      child: Container(
        height: 60,
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.search),
            Text(
              "Search",
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }

  //expanded widget
  Widget expandedWidget() {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: StaggeredGrid.count(
          crossAxisCount: 2, // Number of columns
          mainAxisSpacing: 15, // Space between rows
          crossAxisSpacing: 15, // Space between columns
          children: List.generate(
              30,
              (index) => InkWell(
                  onTap: () {
                    if (index % 2 == 0) {
                      print("Image container pressed at index: $index");
                      Get.to(WallpaperViewScreen());
                    } else {
                      print("Collection container pressed at index: $index");
                      Get.to(CollectionScreen());
                    }
                  },
                  child: Tile(index: index))), // List of tiles
        ),
      ),
    );
  }
}

class Tile extends StatelessWidget {
  final int index;

  const Tile({Key? key, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return index % 2 == 0
        ? imageContainer(context)
        : collectionContainer(context);
  }

  Widget imageContainer(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      fit: StackFit.passthrough,
      children: [
        Container(
          height: MediaQuery.of(context).size.height * .3,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Colors.red,
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15),
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
                    return const Center(child: Text('Failed to load image'));
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
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(10)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Name Here"),
              IconButton(
                onPressed: () {
                  print("iconbutton pressed");
                  //on pressed save to favourites
                },
                icon: Icon(
                  Icons.favorite,
                  size: 20,
                  color: Colors.red,
                ),
              ),
            ],
          ),
        )
      ],
    );
  }

  ///

  Widget collectionContainer(context) {
    return Container(
      height: MediaQuery.of(context).size.height * .15,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.black,
      ),
      child: Center(
        child: Text(
          'Item $index',
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
      ),
    );
  }
}
