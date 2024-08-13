import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class PhotoViewerScreen extends StatefulWidget {
  const PhotoViewerScreen({super.key, required this.initIdx, required this.imageList});
  final int initIdx;
  final List imageList;

  @override
  State<PhotoViewerScreen> createState() => _PhotoViewerScreenState();
}

class _PhotoViewerScreenState extends State<PhotoViewerScreen> {
  late PhotoViewController photoViewController;
  late int idx = widget.initIdx;

  @override
  void initState() {
    super.initState();
    photoViewController = PhotoViewController();
  }

  @override
  void dispose() {
    super.dispose();
    //! Don't forget to dispose of the controller!
    photoViewController.dispose();
  }

  void onPageChanged(int index) {
    setState(() {
      idx = index;
    });
  }
  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(
        title: const Text('Company Gallery'),
      ),
      body: PhotoViewGallery.builder(
        itemCount: widget.imageList.length,
        pageController: PageController(initialPage: widget.initIdx),
        onPageChanged: onPageChanged,
        builder: (context, index) {
          return PhotoViewGalleryPageOptions(
            imageProvider: NetworkImage(
              widget.imageList[index],
            ),
            minScale: PhotoViewComputedScale.contained * 0.8,
            maxScale: PhotoViewComputedScale.covered * 2,
          );
        },
        scrollPhysics: const BouncingScrollPhysics(),
        backgroundDecoration: BoxDecoration(
          color: Theme.of(context).canvasColor,
        ),
        loadingBuilder: (context, event) => const Center(
          child: CircularProgressIndicator(),
        ),
      ),
      bottomSheet: Text('Image ${idx+1}/${widget.imageList.length}'),
    );
  }
}