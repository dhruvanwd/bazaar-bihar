import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_crop/image_crop.dart';
import 'package:image_picker/image_picker.dart';

import 'ImageCropperCtrl.dart';

class ImageCropper extends StatelessWidget {
  Widget _buildOpeningImage() {
    return Center(child: _buildOpenImage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GetBuilder<ImageCropperController>(
          builder: (_) => Container(
            padding:
                const EdgeInsets.symmetric(vertical: 40.0, horizontal: 20.0),
            child:
                _.sample == null ? _buildOpeningImage() : _buildCroppingImage(),
          ),
        ),
      ),
    );
  }

  Widget _buildCroppingImage() {
    final _imgCropperCtrl = ImageCropperController.to;
    return Column(
      children: <Widget>[
        Expanded(
          child: Crop.file(
            _imgCropperCtrl.sample!,
            key: _imgCropperCtrl.cropKey,
            aspectRatio: 2,
          ),
        ),
        Container(
          padding: const EdgeInsets.only(top: 20.0),
          alignment: AlignmentDirectional.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              TextButton(
                child: Text(
                  'Cancel',
                ),
                onPressed: () => Get.back(),
              ),
              TextButton(
                onPressed: () {
                  _imgCropperCtrl.completeCropping();
                },
                child: Text("Crop Image"),
              )
            ],
          ),
        )
      ],
    );
  }

  Widget _buildOpenImage() {
    final _imgCropperCtrl = ImageCropperController.to;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 20),
          child: Text(
            "Select image from",
            style: Get.theme.textTheme.subtitle2,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 120,
              child: TextButton(
                child: Text(
                  'Gallery',
                ),
                onPressed: () => _imgCropperCtrl.openImage(ImageSource.gallery),
                style: TextButton.styleFrom(
                  primary: Colors.teal,
                  side: BorderSide(color: Colors.blue, width: 1),
                ),
              ),
            ),
            Padding(padding: EdgeInsets.symmetric(horizontal: 12)),
            SizedBox(
              width: 120,
              child: TextButton(
                child: Text(
                  'Camera',
                ),
                onPressed: () => _imgCropperCtrl.openImage(ImageSource.camera),
                style: TextButton.styleFrom(
                  primary: Colors.teal,
                  side: BorderSide(color: Colors.blue, width: 1),
                ),
              ),
            )
          ],
        )
      ],
    );
  }
}
