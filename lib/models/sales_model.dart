class SalesModel {
  String productName;
  int quantity;
  String optomProduct;
  String price;
  int totalPrice;

  SalesModel(
      {required this.productName,
      required this.quantity,
      required this.optomProduct,
      required this.price,
      required this.totalPrice});

  Map<String, dynamic> toJson() {
    return {
      'product_name': productName,
      'quantity': quantity,
      'optom_product': optomProduct,
      'price': price,
      'total_price': totalPrice
    };
  }
}
