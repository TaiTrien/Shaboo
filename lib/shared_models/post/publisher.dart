class PublisherModel {
  int _publisherID;
  String name;
  String slug;

  PublisherModel(
    int publisherID, {
    this.name,
    this.slug,
  }) : _publisherID = publisherID;

  get publisherID => this._publisherID;

  Map<String, dynamic> toJson() => {
        'publisherID': this._publisherID,
        'name': this.name,
        'slug': this.slug,
      };
  factory PublisherModel.fromJson(Map<String, dynamic> json) {
    return PublisherModel(
      json['id'],
      name: json['name'],
      slug: json['slug'],
    );
  }
  static List<PublisherModel> toList(List<dynamic> dynamicList) {
    List<PublisherModel> list = [];
    dynamicList?.forEach((item) {
      list.add(PublisherModel.fromJson(item['publisher']));
    });
    return list;
  }
}
