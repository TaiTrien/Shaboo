import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class ImageModel {
  List<int> idImages = <int>[];
  List<Asset> images = <Asset>[];

  Future<List<Asset>> getImageFromGallery() async {
    try {
      var status = await Permission.photos.request();
      if (!status.isGranted) return [];

      images = await MultiImagePicker.pickImages(
        maxImages: 300,
        enableCamera: true,
      );
    } catch (e) {
      print(e);
    }
    return images;
  }
}
