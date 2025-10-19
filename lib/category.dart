class Category {
  String? categoryId;
  String? productName;
  String? graphicsProcessor;
  String? cores;
  String? tmus;
  String? rops;
  String? memorySize;
  String? memoryType;
  String? busWidth;
  String? mediumPrice;
  String? imagePath;

  Category (
    {
      this.categoryId,
      this.productName,
      this.graphicsProcessor,
      this.cores,
      this.tmus,
      this.rops,
      this.memorySize,
      this.memoryType,
      this.busWidth,
      this.mediumPrice,
      this.imagePath,
    }
  );

  Category.fromJson(Map<String, dynamic> json) {
    categoryId = json['categoryId'];
    productName = json['productName'];
    graphicsProcessor = json['graphicsProcessor'];
    cores = json['cores'];
    tmus = json['tmus'];
    rops = json['rops'];
    memorySize = json['memorySize'];
    memoryType = json['memoryType'];
    busWidth = json['busWidth'];
    mediumPrice = json['mediumPrice'];
    imagePath = json['imagePath'];
  }
}