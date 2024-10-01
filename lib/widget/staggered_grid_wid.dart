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
        ? _buildImageTile(context)
        : _buildCollectionTile(context);
  }

  Widget _buildImageTile(BuildContext context) {
    return Consumer<WallpaperProvider>(
      builder: (context, provider, _) {
        if (provider.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (provider.errorMessage != null) {
          return Center(child: Text(provider.errorMessage!));
        }
        if (provider.wallpapers != null &&
            provider.wallpapers!.isNotEmpty &&
            index ~/ 2 < provider.wallpapers!.length) {
          return _buildWallpaperTile(provider.wallpapers![index ~/ 2]);
        }
        return const Center(child: Text('No image available'));
      },
    );
  }

  Widget _buildWallpaperTile(wallpaper) {
    return Stack(
      alignment: Alignment.bottomCenter,
      fit: StackFit.passthrough,
      children: [
        _buildWallpaperImage(wallpaper),
        _buildWallpaperInfo(wallpaper),
      ],
    );
  }

  Widget _buildWallpaperImage(wallpaper) {
    return Container(
      height: 300, // Adjust as needed
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Stack(
          fit: StackFit.expand,
          children: [
            BlurHash(
              hash: wallpaper.blurHash ?? 'LEHV6nWB2yk8pyo0adR*.7kCMdnj',
              imageFit: BoxFit.cover,
            ),
            Image.network(
              wallpaper.urls?.regular ?? '',
              filterQuality: FilterQuality.high,
              fit: BoxFit.cover,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return BlurHash(
                  hash: wallpaper.blurHash ?? 'LEHV6nWB2yk8pyo0adR*.7kCMdnj',
                );
              },
              errorBuilder: (context, error, stackTrace) {
                return const Center(child: Text('Failed to load image'));
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWallpaperInfo(wallpaper) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(.7),
        borderRadius: const BorderRadius.vertical(bottom: Radius.circular(15)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text(
                wallpaper.user?.name ?? 'Unknown',
                style: const TextStyle(color: Colors.white),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          IconButton(
            onPressed: () {
              // TODO: Implement save to favorites
              print("Save to favorites: ${wallpaper.id}");
            },
            icon: const Icon(
              Icons.favorite_border,
              size: 20,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCollectionTile(BuildContext context) {
    return Container(
      height: 150, // Adjust as needed
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.grey[800],
      ),
      child: Center(
        child: Text(
          'Collection ${(index + 1) ~/ 2}',
          style: const TextStyle(color: Colors.white, fontSize: 16),
        ),
      ),
    );
  }
}
