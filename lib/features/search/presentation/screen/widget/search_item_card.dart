import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
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
      elevation: 7,
      shadowColor: Colors.grey.shade400,
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              color: Colors.white,
              height: MediaQuery.of(context).size.height /3.5,
              width: MediaQuery.of(context).size.width,
              child: product.productImage != null && product.productImage!.isNotEmpty
                  ? Image.network(product.productImage!
                 , fit: BoxFit.contain)
                  : const Icon(Icons.image_not_supported, size: 50),
            ),
            const SizedBox(height: 8),
            ItemCard(
              labelText: 'item_name'.tr(),
              text: product.productArName ?? 'not_available'.tr(),
            ),
            ItemCard(
              text: product.productEnName ?? '',
            ),
            ItemCard(
              labelText: 'item_code'.tr(),
              text: product.productCode,
            ),
            ItemCard(
              labelText: 'item_barcode'.tr(),
              text: product.barCode,
            ),
            ItemCard(
              labelText: 'item_qty'.tr(),
              text: product.stockQuantity.toString(),
            ),
            ItemCard(
              labelText: 'item_price'.tr(),
              text: product.price.toString(),
            ),
          ],
        ),
      ),
    );
  }
}
