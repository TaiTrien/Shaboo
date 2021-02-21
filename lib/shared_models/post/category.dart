class CategoryModel {
  int _categoryID;
  String name;
  String slug;
  String desc;

  CategoryModel(
    int categoryID, {
    this.name,
    this.slug,
    this.desc,
  }) : _categoryID = categoryID;

  get categoryID => this._categoryID;

  Map<String, dynamic> toJson() => {
        'categoryID': this._categoryID,
        'name': this.name,
        'slug': this.slug,
        'desc': this.desc,
      };

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      json['id'],
      name: json['name'],
      slug: json['slug'],
      desc: json['descriptions'],
    );
  }

  static List<CategoryModel> toList(List<dynamic> dynamicList) {
    List<CategoryModel> list = [];
    dynamicList?.forEach((item) {
      list.add(CategoryModel.fromJson(item["category"]));
    });
    return list;
  }
}
