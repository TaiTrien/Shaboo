class ImageModel {
  int _imageID;
  String createdAt;
  String updatedAt;
  String link;
  String slug;
  String fileName;
  String type;
  int updatedBy;

  ImageModel(
    int imageID, {
    this.createdAt,
    this.updatedAt,
    this.link,
    this.slug,
    this.fileName,
    this.type,
    this.updatedBy,
  }) : this._imageID = imageID;

  Map<String, dynamic> toJson() => {
        'imageID': this._imageID,
        'createdAt': this.createdAt,
        'updatedAt': this.updatedAt,
        'name': this.fileName,
        'slug': this.slug,
        'desc': this.type,
      };
}
