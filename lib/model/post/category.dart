class CategoryModel {
  int _categoryID;
  String createdAt;
  String updatedAt;
  String name;
  String slug;
  String desc;

  CategoryModel(
    int categoryID, {
    this.createdAt,
    this.updatedAt,
    this.name,
    this.slug,
    this.desc,
  }) : _categoryID = categoryID;

  Map<String, dynamic> toJson() => {
        'categoryID': this._categoryID,
        'createdAt': this.createdAt,
        'updatedAt': this.updatedAt,
        'name': this.name,
        'slug': this.slug,
        'desc': this.desc,
      };
}
