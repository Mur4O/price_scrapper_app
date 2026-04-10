class Product {
  String? productName;
  String? price;

  Product(
    {
      this.productName,
      this.price,
    }
  );

  Product.fromJson(Map<String, dynamic> json) {
    productName = json['productName'];
    price = json['price'];
  }
}