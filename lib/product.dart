class Product {
  String? productName;
  String? price;
  String? imagePath;

  Product(
    {
      this.productName,
      this.price,
      this.imagePath,
    }
  );

  Product.fromJson(Map<String, dynamic> json) {
    productName = json['productName'];
    price = json['price'];
    imagePath = json['imagePath'];
  }
}
