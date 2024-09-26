import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CollectionScreen extends StatelessWidget {
  const CollectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [SliverAppBar()],
      ),
    );
  }
}
