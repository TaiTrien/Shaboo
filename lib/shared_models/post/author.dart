class AuthorModel {
  int _authorID;
  String name;
  String slug;

  AuthorModel(
    int authorID, {
    this.name,
    this.slug,
  }) : _authorID = authorID;

  get authorID => this._authorID;

  Map<String, dynamic> toJson() => {
        'authorID': this._authorID,
        'name': this.name,
        'slug': this.slug,
      };

  factory AuthorModel.fromJson(Map<String, dynamic> json) {
    return AuthorModel(
      json['id'],
      name: json['name'],
      slug: json['slug'],
    );
  }
  static List<AuthorModel> toList(List<dynamic> dynamicList) {
    List<AuthorModel> list = [];
    dynamicList?.forEach((item) {
      list.add(AuthorModel.fromJson(item['author']));
    });
    return list;
  }
}
