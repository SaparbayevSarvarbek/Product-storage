class ProductModel {
  int id;
  String name;
  int soni;
  String image;
  String optomProduct;
  int buy;
  int sell;
  int category;

  ProductModel(
      {required this.id,
      required this.name,
      required this.soni,
      required this.image,
      required this.optomProduct,
      required this.buy,
      required this.sell,
      required this.category});

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
        id: json["id"] ?? 0,
        name: json["name"] ?? "",
        soni: json["soni"] ?? 0,
        image: json["image"]??"",
        optomProduct: json["optomProduct"] ?? "",
        buy: json["buy"] ?? 0,
        sell: json["sell"] ?? 0,
        category: json["category"] ?? 0);
  }

  Map<String, dynamic> toJson() {
    return {
      'id':id,
      'name': name,
      'soni': soni,
      'image':image,
      'optom_product': optomProduct,
      'buy': buy,
      'sell': sell,
      'category': category
    };
  }
}
