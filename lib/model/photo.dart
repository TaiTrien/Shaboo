import 'package:camera/camera.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class PhotoModel {
  List<int> idPhotos = <int>[];
  List<Asset> photos = <Asset>[];

  Future<List<Asset>> getPhotosFromGallery() async {
    try {
      var status = await Permission.photos.request();
      if (!status.isGranted) return [];

      photos = await MultiImagePicker.pickImages(
        maxImages: 300,
        enableCamera: true,
      );
    } catch (e) {
      print(e);
    }
    return photos;
  }

  Future<dynamic> takePhoto(CameraController controller) async {
    try {
      final path = join((await getTemporaryDirectory()).path, '${DateTime.now()}.png');
      await controller.takePicture(path);

      final result = await ImageGallerySaver.saveFile(path);
      print(result);
      return path;
    } catch (e) {
      print(e);
    }
  }
}
