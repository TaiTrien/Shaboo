class AuthorModel {
  int _authorID;
  String createdAt;
  String updatedAt;
  String name;
  String slug;

  AuthorModel(
    int authorID, {
    this.createdAt,
    this.updatedAt,
    this.name,
    this.slug,
  }) : _authorID = authorID;

  Map<String, dynamic> toJson() => {
        'authorID': this._authorID,
        'createdAt': this.createdAt,
        'updatedAt': this.updatedAt,
        'name': this.name,
        'slug': this.slug,
      };
}
