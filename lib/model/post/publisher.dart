class PublisherModel {
  int _publisherID;
  String createdAt;
  String updatedAt;
  String name;
  String slug;

  PublisherModel(
    int publisherID, {
    this.createdAt,
    this.updatedAt,
    this.name,
    this.slug,
  }) : _publisherID = publisherID;

  Map<String, dynamic> toJson() => {
        'publisherID': this._publisherID,
        'createdAt': this.createdAt,
        'updatedAt': this.updatedAt,
        'name': this.name,
        'slug': this.slug,
      };
}
