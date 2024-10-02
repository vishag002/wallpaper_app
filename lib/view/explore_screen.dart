import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:wallpaper_app/controller/carousel_controller.dart';
import 'package:wallpaper_app/controller/collection_controller.dart';
import 'package:wallpaper_app/controller/wallpaper_controller.dart';
import 'package:wallpaper_app/utilis/text_const.dart';
import 'package:wallpaper_app/view/user_screen.dart';
import 'package:wallpaper_app/view/wallpaper_view_screen.dart';
import 'package:wallpaper_app/widget/staggered_grid_wid.dart';

class ExploreScreen extends StatefulWidget {
  final VoidCallback showNavigation;
  final VoidCallback hideNavigation;
  const ExploreScreen(
      {super.key, required this.showNavigation, required this.hideNavigation});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  ScrollController scrollController = ScrollController();
  //
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        context.read<WallpaperProvider>().fetchWallpapers();
        context.read<CollectionProvider>().fetchCollections();
      },
    );
    scrollController.addListener(
      () {
        if (scrollController.position.userScrollDirection ==
            ScrollDirection.forward) {
          widget.showNavigation();
        } else {
          widget.hideNavigation();
        }
      },
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    scrollController.removeListener(
      () {
        if (scrollController.position.userScrollDirection ==
            ScrollDirection.forward) {
          widget.showNavigation();
        } else {
          widget.hideNavigation();
        }
      },
    );
  }

  //
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: CustomScrollView(
        controller: scrollController,
        slivers: [
          SliverAppBar(
            expandedHeight: MediaQuery.of(context).size.height / 2.48,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              titlePadding: EdgeInsets.only(bottom: 30),

              // Dynamically updating the title based on the current carousel index
              title: Consumer<CarouselControllerProvider>(
                builder: (context, provider, _) {
                  return Text(
                    imageTitle[provider.currentIndex],
                    textAlign: TextAlign.center,
                    style: TextStyles.title.copyWith(
                        color: Colors.white, fontWeight: FontWeight.bold),
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
          //to-do search function
          searchButton(),
          expandedWidget(context),
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
    return const SliverToBoxAdapter(
      child: SizedBox(
        height: 60,
        width: 150,
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
  Widget expandedWidget(BuildContext context) {
    final wallpaperProvider =
        Provider.of<WallpaperProvider>(context, listen: false);
    final collectionProvider =
        Provider.of<WallpaperProvider>(context, listen: false);
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: StaggeredGrid.count(
          crossAxisCount: 2,
          mainAxisSpacing: 15,
          crossAxisSpacing: 15,
          children: List.generate(
            wallpaperProvider.wallpapers!.length * 2,
            (index) => InkWell(
              onTap: () {
                _handleItemTap(index, wallpaperProvider, CollectionProvider());
              },
              child: Tile(index: index),
            ),
          ),
        ),
      ),
    );
  }

  void _handleItemTap(int index, WallpaperProvider _wallpaperProvider,
      CollectionProvider _collectionProvider) {
    if (index.isEven &&
        index ~/ 2 < (_wallpaperProvider.wallpapers?.length ?? 0)) {
      print("Image container pressed at index: $index");
      Get.to(() => WallpaperViewScreen(
          wallpaper: _wallpaperProvider.wallpapers![index ~/ 2]));
    } else {
      print("Image container pressed at index: $index");
      Get.to(() => ArtistProfileScreen(
            collection: _collectionProvider.collections[index ~/ 2],
          ));
    }
  }
}
