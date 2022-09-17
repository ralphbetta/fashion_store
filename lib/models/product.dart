class ProductModel {
  final String name;
  final String price;
  final String category;
  final String rating;
  final String quantity;
  final String image;
  final String desc;
  final String? barCode;
  int orderQty;

  ProductModel({
    required this.name,
    required this.price,
    this.orderQty = 1,
    required this.category,
    required this.rating,
    required this.quantity,
    required this.image,
    this.barCode,
    required this.desc,
  });
}
