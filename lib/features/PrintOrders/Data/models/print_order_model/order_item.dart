class OrderItem {
  int? orderNo;
  int? number;
  int? itemId;
  String? itemArMame;
  String? itemEnNAme;
  dynamic quantity;
  dynamic price;
  dynamic unitId;
  String? unitArName;
  String? unitEnName;
  dynamic barCode;
  dynamic colorsId;
  dynamic colorId;
  dynamic colorName;
  dynamic colorEName;
  dynamic sizeId;
  dynamic size;
  dynamic reservation;

  OrderItem({
    this.orderNo,
    this.number,
    this.itemId,
    this.itemArMame,
    this.itemEnNAme,
    this.quantity,
    this.price,
    this.unitId,
    this.unitArName,
    this.unitEnName,
    this.barCode,
    this.colorsId,
    this.colorId,
    this.colorName,
    this.colorEName,
    this.sizeId,
    this.size,
    this.reservation,
  });

  factory OrderItem.fromJson(Map<String, dynamic> json) => OrderItem(
        orderNo: json['OrderNo'] as int?,
        number: json['Number'] as int?,
        itemId: json['ItemID'] as int?,
        itemArMame: json['ItemArMame'] as String?,
        itemEnNAme: json['ItemEnNAme'] as String?,
        quantity: json['Quantity'] as dynamic,
        price: (json['Price'] as num?)?.toDouble(),
        unitId: json['UnitId'] as dynamic,
        unitArName: json['UnitArName'] as String?,
        unitEnName: json['UnitEnName'] as String?,
        barCode: json['BarCode'] as dynamic,
        colorsId: json['Colors_ID'] as dynamic,
        colorId: json['ColorID'] as dynamic,
        colorName: json['ColorName'] as dynamic,
        colorEName: json['ColorEName'] as dynamic,
        sizeId: json['Size_ID'] as dynamic,
        size: json['Size'] as dynamic,
        reservation: json['Reservation'] as dynamic,
      );

  Map<String, dynamic> toJson() => {
        'OrderNo': orderNo,
        'Number': number,
        'ItemID': itemId,
        'ItemArMame': itemArMame,
        'ItemEnNAme': itemEnNAme,
        'Quantity': quantity,
        'Price': price,
        'UnitId': unitId,
        'UnitArName': unitArName,
        'UnitEnName': unitEnName,
        'BarCode': barCode,
        'Colors_ID': colorsId,
        'ColorID': colorId,
        'ColorName': colorName,
        'ColorEName': colorEName,
        'Size_ID': sizeId,
        'Size': size,
        'Reservation': reservation,
      };
}
