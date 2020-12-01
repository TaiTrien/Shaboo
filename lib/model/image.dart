import 'package:camera/camera.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
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

  Future<void> takePhoto(CameraController controller) async {
    try {
      await controller.initialize();
      final path = join((await getTemporaryDirectory()).path, '${DateTime.now()}.png');
      await controller.takePicture(path);

      final result = await ImageGallerySaver.saveFile(
        path,
        // Uint8List.fromList(response.data),
        // quality: 60,
        // name: "hello",
      );
      print(result);
    } catch (e) {
      print(e);
    }
  }
}
