import 'package:shaboo/constants/api_constants.dart';
import 'package:shaboo/models/model.dart';

class ImageModel implements Model {
  int _imageID;
  String link;
  String slug;
  String fileName;
  String type;
  int updatedBy;

  ImageModel(
    int imageID, {
    this.link,
    this.slug,
    this.fileName,
    this.type,
    this.updatedBy,
  }) : this._imageID = imageID;

  get imageID => this._imageID;

  Map<String, dynamic> toJson() => {
        'imageID': this._imageID,
        'name': this.fileName,
        'slug': this.slug,
        'desc': this.type,
      };

  factory ImageModel.fromJson(Map<String, dynamic> json) {
    return ImageModel(
      int.parse(json['id'].toString()),
      link: kPrefixUploadImageUrl + json['filename'],
      slug: json['slug'],
      type: json['type'],
    );
  }

  static List<ImageModel> toList(List<dynamic> dynamicList) {
    List<ImageModel> list = [];
    dynamicList.forEach((item) {
      list.add(ImageModel.fromJson(item["image"]));
    });
    return list;
  }
}
