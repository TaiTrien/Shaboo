import 'package:image_picker/image_picker.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class PhotoModel {
  List<int> idPhotos = <int>[];
  List<Asset> photos = <Asset>[];

  Future<List<Asset>> getPhotosFromGallery() async {
    try {
      var status = await Permission.photos.request();
      if (!status.isGranted) return [];

      photos = await MultiImagePicker.pickImages(
        maxImages: 6,
        enableCamera: true,
      );
    } catch (e) {
      print(e);
    }
    return photos;
  }

  Future<dynamic> getPhotoFromCamera() async {
    PickedFile photo;
    try {
      final picker = ImagePicker();
      var status = await Permission.camera.request();
      if (!status.isGranted) return null;

      photo = await picker.getImage(source: ImageSource.camera);
      return photo;
    } catch (e) {
      print(e);
    }
  }
}
