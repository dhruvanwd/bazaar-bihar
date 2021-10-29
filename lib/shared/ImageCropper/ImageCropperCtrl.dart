import 'dart:io';
import '../Utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_crop/image_crop.dart';
import 'package:image_picker/image_picker.dart';
import 'package:simple_s3/simple_s3.dart';

class ImageCropperController extends GetxController {
  static ImageCropperController get to => Get.find();
  var file;
  var sample;

  List<File> croppedImages = [];

  final cropKey = GlobalKey<CropState>();

  Future<void> openImage(ImageSource src) async {
    final pickedFile = await ImagePicker().pickImage(source: src);
    final file = File(pickedFile!.path);
    final sample = await ImageCrop.sampleImage(
      file: file,
      preferredSize: Get.size.longestSide.ceil(),
    );
    this.sample?.delete();
    this.file?.delete();
    this.sample = sample;
    this.file = file;
    update();
  }

  SimpleS3 _simpleS3 = SimpleS3();
  uploadAwsFile(File file, String folderPath) async {
    try {
      String result = await _simpleS3.uploadFile(
        file,
        "bazaar-bihar",
        "ap-south-1:4904764b-af76-448d-af01-d138951bbeb6",
        AWSRegions.apSouth1,
        s3FolderPath: folderPath,
      );
      print(result);
      return result;
    } catch (e, s) {
      multiPrint([e, s]);
    }
  }

  Future<void> _cropImage() async {
    final scale = cropKey.currentState?.scale;
    final area = cropKey.currentState?.area;
    if (area == null) {
      // cannot crop, widget is not setup
      return;
    }

    // scale up to use maximum possible number of pixels
    // this will sample image in higher resolution to make cropped image larger
    final sample = await ImageCrop.sampleImage(
      file: this.file!,
      preferredSize: (2000 / scale!).round(),
    );

    file = await ImageCrop.cropImage(
      file: sample,
      area: area,
    );

    debugPrint('$file');
    update();
  }

  completeCropping() async {
    await _cropImage();
    this.croppedImages.add(file);
    Get.back();
    this.sample = null;
    this.file = null;
    update();
  }

  @override
  void dispose() {
    super.dispose();
    this.file?.delete();
    this.sample?.delete();
  }
}
