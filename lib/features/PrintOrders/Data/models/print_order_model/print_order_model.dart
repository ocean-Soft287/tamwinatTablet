import 'package:easy_localization/easy_localization.dart';

import 'order_item.dart';

class PrintOrderModel {
  int? orderNo;
  int? branchId;
  String? orderDate;
  String? deliveryDate;
  int? customerId;
  String? customerPhone;
  String? customerName;
  String? customerEnName;
  dynamic customerAddress;
  dynamic onlineStoreId;
  double? totalValue;
  String? details;
  double? additions;
  String? orderTime;
  double? discount;
  double? finalValue;
  dynamic additionalDescription1;
  dynamic additionalDescription2;
  dynamic additionalDescription3;
  dynamic additionalDescription4;
  dynamic additionalDescription5;
  dynamic additionalDescription6;
  dynamic additionalDescription7;
  dynamic additionalDescription8;
  dynamic additionalDescription9;
  dynamic additionalDescription10;
  int? salesManId;
  String? salesManName;
  String? description1;
  String? description2;
  String? description3;
  String? refrenceNumber;
  int? userId;
  String? userName;
  dynamic taxesPercent;
  dynamic taxesValue;
  int? payId;
  dynamic payValue;
  dynamic districtName;
  dynamic block;
  dynamic street;
  dynamic house;
  dynamic paymentId;
  dynamic groupId;
  dynamic secondPhone;
  dynamic gada;
  dynamic email;
  dynamic floor;
  dynamic apartment;
  dynamic deliveryDay;
  dynamic? deliveryId;
  String? orderAddress;
  String? discountCode;
  dynamic? parentAcId;
  dynamic? discountCardValue;
  String? mapCustomerAddress;
  String? mapPlaceId;
  dynamic? discountPointsValue;
  dynamic regionName;
  bool? notAllowNegativeOutput;
  List<OrderItem>? orderItems;

  // New boolean fields
  bool? prepare;
  bool? startDeliver;
  bool? Delivered;
  bool? underDeliver;

  PrintOrderModel({
    this.orderNo,
    this.branchId,
    this.orderDate,
    this.deliveryDate,
    this.customerId,
    this.customerPhone,
    this.customerName,
    this.customerEnName,
    this.customerAddress,
    this.onlineStoreId,
    this.totalValue,
    this.details,
    this.additions,
    this.orderTime,
    this.discount,
    this.finalValue,
    this.additionalDescription1,
    this.additionalDescription2,
    this.additionalDescription3,
    this.additionalDescription4,
    this.additionalDescription5,
    this.additionalDescription6,
    this.additionalDescription7,
    this.additionalDescription8,
    this.additionalDescription9,
    this.additionalDescription10,
    this.salesManId,
    this.salesManName,
    this.description1,
    this.description2,
    this.description3,
    this.refrenceNumber,
    this.userId,
    this.userName,
    this.taxesPercent,
    this.taxesValue,
    this.payId,
    this.payValue,
    this.districtName,
    this.block,
    this.street,
    this.house,
    this.paymentId,
    this.groupId,
    this.secondPhone,
    this.gada,
    this.email,
    this.floor,
    this.apartment,
    this.deliveryDay,
    this.deliveryId,
    this.orderAddress,
    this.discountCode,
    this.parentAcId,
    this.discountCardValue,
    this.mapCustomerAddress,
    this.mapPlaceId,
    this.discountPointsValue,
    this.regionName,
    this.notAllowNegativeOutput,
    this.orderItems,
    this.prepare,        // Added to constructor
    this.startDeliver,   // Added to constructor
    this.Delivered,   // Added to constructor
    this.underDeliver,   // Added to constructor
  });


static String getStatusMessage(PrintOrderModel order) {
  String status = "";
//  "تم استلام اطلب"
  if (order.startDeliver == true) {
    status += "${tr("start_Deliver_order")}\n";
  } else {
    status += "${tr("not_start_Deliver_order")}\n";
  }


  // "تجهيز"
  if (order.prepare == true) {
    status += "${tr("preparing_order")}\n";
  } else {
    status += "${tr("not_prepared")}\n";
  }
  //  "جاري التوصيل"
  if (order.underDeliver == true) {
    status += "${tr("order_under_delivery")}\n";
  } else {
    status += "${tr("order_not_under_delivery")}\n";
  }

  // "تم التوصيل"
  if (order.Delivered == true) {
    status += "${tr("delivered_order")}\n";
  } else {
    status += "${tr("not_delivered_order")}\n";
  }
  
  return status;
}
  
   
  factory PrintOrderModel.fromJson(Map<String, dynamic> json) {
    return PrintOrderModel(
      orderNo: json['OrderNo'] as int?,
      branchId: json['BranchID'] as int?,
      orderDate: json['OrderDate'] as String?,
      deliveryDate: json['DeliveryDate'] as String?,
      customerId: json['CustomerID'] as int?,
      customerPhone: json['CustomerPhone'] as String?,
      customerName: json['CustomerName'] as String?,
      customerEnName: json['CustomerEnName'] as String?,
      customerAddress: json['CustomerAddress'] as dynamic,
      onlineStoreId: json['OnlineStoreId'] as dynamic?,
      totalValue: (json['TotalValue'] as num?)?.toDouble(),
      details: json['Details'] as String?,
      additions: json['Additions'] as double?,
      orderTime: json['OrderTime'] as String?,
      discount: json['Discount'] as double?,
      finalValue: (json['FinalValue'] as double?)?.toDouble(),
      additionalDescription1: json['AdditionalDescription1'] as dynamic,
      additionalDescription2: json['AdditionalDescription2'] as dynamic,
      additionalDescription3: json['AdditionalDescription3'] as dynamic,
      additionalDescription4: json['AdditionalDescription4'] as dynamic,
      additionalDescription5: json['AdditionalDescription5'] as dynamic,
      additionalDescription6: json['AdditionalDescription6'] as dynamic,
      additionalDescription7: json['AdditionalDescription7'] as dynamic,
      additionalDescription8: json['AdditionalDescription8'] as dynamic,
      additionalDescription9: json['AdditionalDescription9'] as dynamic,
      additionalDescription10: json['AdditionalDescription10'] as dynamic,
      salesManId: json['SalesManID'] as dynamic,
      salesManName: json['SalesManName'] as String?,
      description1: json['Description1'] as String?,
      description2: json['Description2'] as String?,
      description3: json['Description3'] as String?,
      refrenceNumber: json['RefrenceNumber'] as String?,
      userId: json['UserID'] as dynamic,
      userName: json['UserName'] as String?,
      taxesPercent: json['TaxesPercent'] as dynamic,
      taxesValue: json['TaxesValue'] as dynamic,
      payId: json['PayID'] as dynamic?,
      payValue: (json['PayValue'] as num?)?.toDouble(),
      districtName: json['DistrictName'] as dynamic,
      block: json['Block'] as dynamic,
      street: json['Street'] as dynamic,
      house: json['House'] as dynamic,
      paymentId: json['PaymentID'] as dynamic,
      groupId: json['GroupID'] as dynamic,
      secondPhone: json['SecondPhone'] as dynamic,
      gada: json['Gada'] as dynamic,
      email: json['Email'] as dynamic,
      floor: json['Floor'] as dynamic,
      apartment: json['Apartment'] as dynamic,
      deliveryDay: json['DeliveryDay'] as dynamic,
      deliveryId: json['DeliveryID'] as dynamic?,
      orderAddress: json['OrderAddress'] as String?,
      discountCode: json['DiscountCode'] as String?,
      parentAcId: json['ParentAcID'] as dynamic?,
      discountCardValue: json['DiscountCardValue'] as dynamic?,
      mapCustomerAddress: json['MapCustomerAddress'] as String?,
      mapPlaceId: json['MapPlaceID'] as String?,
      discountPointsValue: json['DiscountPointsValue'] as dynamic?,
      regionName: json['RegionName'] as dynamic,
      notAllowNegativeOutput: json['NotAllowNegativeOutput'] as bool?,
      orderItems: (json['OrderItems'] as List<dynamic>?)
          ?.map((e) => OrderItem.fromJson(e as Map<String, dynamic>))
          .toList(),
      prepare: json['Prepare'] as bool?,          // Parse the new field
      startDeliver: json['StartDeliver'] as bool?, // Parse the new field
      Delivered: json['Delivered'] as bool?, // Parse the new field
      underDeliver: json['UnderDeliver'] as bool?, // Parse the new field
    );
  }

  Map<String, dynamic> toJson() => {
        'OrderNo': orderNo,
        'BranchID': branchId,
        'OrderDate': orderDate,
        'DeliveryDate': deliveryDate,
        'CustomerID': customerId,
        'CustomerPhone': customerPhone,
        'CustomerName': customerName,
        'CustomerEnName': customerEnName,
        'CustomerAddress': customerAddress,
        'OnlineStoreId': onlineStoreId,
        'TotalValue': totalValue,
        'Details': details,
        'Additions': additions,
        'OrderTime': orderTime,
        'Discount': discount,
        'FinalValue': finalValue,
        'AdditionalDescription1': additionalDescription1,
        'AdditionalDescription2': additionalDescription2,
        'AdditionalDescription3': additionalDescription3,
        'AdditionalDescription4': additionalDescription4,
        'AdditionalDescription5': additionalDescription5,
        'AdditionalDescription6': additionalDescription6,
        'AdditionalDescription7': additionalDescription7,
        'AdditionalDescription8': additionalDescription8,
        'AdditionalDescription9': additionalDescription9,
        'AdditionalDescription10': additionalDescription10,
        'SalesManID': salesManId,
        'SalesManName': salesManName,
        'Description1': description1,
        'Description2': description2,
        'Description3': description3,
        'RefrenceNumber': refrenceNumber,
        'UserID': userId,
        'UserName': userName,
        'TaxesPercent': taxesPercent,
        'TaxesValue': taxesValue,
        'PayID': payId,
        'PayValue': payValue,
        'DistrictName': districtName,
        'Block': block,
        'Street': street,
        'House': house,
        'PaymentID': paymentId,
        'GroupID': groupId,
        'SecondPhone': secondPhone,
        'Gada': gada,
        'Email': email,
        'Floor': floor,
        'Apartment': apartment,
        'DeliveryDay': deliveryDay,
        'DeliveryID': deliveryId,
        'OrderAddress': orderAddress,
        'DiscountCode': discountCode,
        'ParentAcID': parentAcId,
        'DiscountCardValue': discountCardValue,
        'MapCustomerAddress': mapCustomerAddress,
        'MapPlaceID': mapPlaceId,
        'DiscountPointsValue': discountPointsValue,
        'RegionName': regionName,
        'NotAllowNegativeOutput': notAllowNegativeOutput,
        'OrderItems': orderItems?.map((e) => e.toJson()).toList(),
        'Prepare': prepare,                // Serialize the new field
        'StartDeliver': startDeliver,      // Serialize the new field
        'Delivered': Delivered,      // Serialize the new field
        'UnderDeliver': underDeliver,      // Serialize the new field
      };
}
