class LocationModel {
  String code;
  String parentCode;
  String name;
  String slug;
  String type;
  String nameWithType;

  LocationModel({
    this.code,
    this.parentCode,
    this.name,
    this.slug,
    this.type,
    this.nameWithType,
  });

  Map<String, dynamic> toJson() => {
        'code': this.code,
        'parentCode': this.parentCode,
        'name': this.name,
        'slug': this.slug,
        'type': this.type,
        'nameWithType': this.nameWithType,
      };
}
