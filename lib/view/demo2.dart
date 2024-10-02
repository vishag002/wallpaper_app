import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wallpaper_app/controller/collection_controller.dart';

class CollectionListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<CollectionProvider>(
      builder: (context, provider, child) {
        if (provider.isLoading) {
          return Center(child: CircularProgressIndicator());
        } else if (provider.error.isNotEmpty) {
          return Center(child: Text(provider.error));
        } else if (provider.collections.isEmpty) {
          return Center(child: Text('No collections available'));
        } else {
          return ListView.builder(
            itemCount: provider.collections.length,
            itemBuilder: (context, index) {
              final collection = provider.collections[index];
              return Card(
                child: Column(
                  children: [
                    collection.coverPhoto?.urls?.small != null
                        ? Image.network(
                            collection.coverPhoto!.urls!.small!,
                            fit: BoxFit.cover,
                            height: 200,
                            width: double.infinity,
                          )
                        : Container(
                            height: 200,
                            color: Colors.grey,
                            child: Center(child: Text('No image available')),
                          ),
                    ListTile(
                      title: Text(collection.title ?? 'Untitled Collection'),
                      subtitle:
                          Text('Total Photos: ${collection.totalPhotos ?? 0}'),
                    ),
                  ],
                ),
              );
            },
          );
        }
      },
    );
  }
}
