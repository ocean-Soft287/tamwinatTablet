import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:search_appp/features/search/model/search_result.dart';
import 'package:search_appp/features/search/presentation/screen/widget/text_field.dart';

class SearchItemCard extends StatelessWidget {
  const SearchItemCard({
    super.key,
    required this.product,
  });

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    return Card(
     margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
     child: Padding(
       padding: const EdgeInsets.all(12.0),
       child: Column(
         children: [
           Container(
             color: Colors.white,
             height: 100.h,
             width: MediaQuery.of(context).size.width,
             child: product.productImage != null && product.productImage!.isNotEmpty
                 ? Image.network(product.productImage!, fit: BoxFit.cover)
                 : const Icon(Icons.image_not_supported, size: 50),
           ),
           const SizedBox(height: 8),
           ItemCard(
             labelText: 'اسم الصنف / Item Name',
             text: product.productArName ?? 'غير متوفر',
           ),
           ItemCard(
             text: product.productEnName ?? '',
           ),
           ItemCard(
             labelText: 'Item Code',
             text: product.productCode,
           ),
           ItemCard(
             labelText: 'Item Barcode',
             text: product.barCode,
           ),
           ItemCard(
             labelText: 'كميه الصنف / Item QTY',
             text: product.stockQuantity.toString(),
           ),
           ItemCard(
             labelText: 'Price / السعر',
             text: product.price.toString(),
           ),
         ],
       ),
     ),
                                    );
  }
}
