import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class ImageDialog extends StatelessWidget {
  final String linkImage;
  const ImageDialog(this.linkImage, {super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
        insetPadding: const EdgeInsets.all(0),
        child: Stack(
          children: <Widget>[
            SizedBox(
              width: double.infinity,
              height: 250,
              child: PhotoView(
                imageProvider: AssetImage(linkImage),
              ),
            ),
          ],
        ));
  }
}
