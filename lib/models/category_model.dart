class CategoryModel {
  int id;
  String name;
  String image;

  CategoryModel({required this.id, required this.name, required this.image});

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
        id: json["id"] ?? 0,
        name: json["name"] ?? "",
        image: json["image"] ?? "");
  }

  Map<String, dynamic> toJson() {
    return{
      'name':name,
      'image':image
    };
  }
}
