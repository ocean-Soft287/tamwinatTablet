class ProductModel {
  final String productCode;
  final String barCode;
  final String? productArName;
  final String? productEnName;
  final String? categoryArName;
  final String? categoryEnName;
  final double stockQuantity;
  final double price;
  final double priceAfterDiscount;
  final double lastBuyPrice;
  final double localCost;
  final String? specification;
  final int productID;
  final String? productImage;
  final double customerQuantity;
  final double totalQuantity;
  final double soldQuantity;
  final double remainQuantity;

  ProductModel({
    required this.productCode,
    required this.barCode,
    this.productArName,
    this.productEnName,
    this.categoryArName,
    this.categoryEnName,
    required this.stockQuantity,
    required this.price,
    required this.priceAfterDiscount,
    required this.lastBuyPrice,
    required this.localCost,
    this.specification,
    required this.productID,
    this.productImage,
    required this.customerQuantity,
    required this.totalQuantity,
    required this.soldQuantity,
    required this.remainQuantity,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      productCode: json['ProductCode'] ?? '',
      barCode: json['BarCode'] ?? '',
      productArName: json['ProductArName'],
      productEnName: json['ProductEnName'],
      categoryArName: json['CategoryArName'],
      categoryEnName: json['CategoryEnName'],
      stockQuantity: (json['StockQuantity'] ?? 0).toDouble(),
      price: (json['Price'] ?? 0).toDouble(),
      priceAfterDiscount: (json['PriceAfterDiscount'] ?? 0).toDouble(),
      lastBuyPrice: (json['LastBuyPrice'] ?? 0).toDouble(),
      localCost: (json['LocalCost'] ?? 0).toDouble(),
      specification: json['Specification'],
      productID: json['ProductID'] ?? 0,
      productImage: json['ProductcImage'],
      customerQuantity: (json['CustomerQuantity'] ?? 0).toDouble(),
      totalQuantity: (json['TotalQuantity'] ?? 0).toDouble(),
      soldQuantity: (json['SoldQuantity'] ?? 0).toDouble(),
      remainQuantity: (json['RemainQuantity'] ?? 0).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ProductCode': productCode,
      'BarCode': barCode,
      'ProductArName': productArName,
      'ProductEnName': productEnName,
      'CategoryArName': categoryArName,
      'CategoryEnName': categoryEnName,
      'StockQuantity': stockQuantity,
      'Price': price,
      'PriceAfterDiscount': priceAfterDiscount,
      'LastBuyPrice': lastBuyPrice,
      'LocalCost': localCost,
      'Specification': specification,
      'ProductID': productID,
      'ProductcImage': productImage,
      'CustomerQuantity': customerQuantity,
      'TotalQuantity': totalQuantity,
      'SoldQuantity': soldQuantity,
      'RemainQuantity': remainQuantity,
    };
  }
}
