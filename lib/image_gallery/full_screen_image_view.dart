import 'package:flutter/material.dart';
import 'package:flutter_test_app/navigation/app_navigation_stack.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:test_app_ui_kit/test_app_ui_kit.dart';

class FullScreenImageView extends StatelessWidget {
  const FullScreenImageView({
    required this.imageUrls,
    Key? key,
  }) : super(key: key);

  final List<String> imageUrls;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Stack(children: <Widget>[
          Container(
            color: Colors.black,
            child: PhotoViewGallery.builder(
              backgroundDecoration: const BoxDecoration(color: Colors.black),
              itemCount: imageUrls.length,
              builder: (context, index) {
                return PhotoViewGalleryPageOptions(
                  imageProvider: NetworkImage(imageUrls[index]),
                  initialScale: PhotoViewComputedScale.contained * 1,
                );
              },
              loadingBuilder: (context, event) =>
                  const Center(child: SimpleLoader()),
            ),
          ),
          GestureDetector(
            onTap: AppNavigationStack.instance.pop,
            child: Container(
              padding: const EdgeInsets.all(16),
              child: const Icon(
                Icons.close,
                color: Colors.white,
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
