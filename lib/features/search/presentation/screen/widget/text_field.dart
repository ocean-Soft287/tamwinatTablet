import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ItemCard extends StatelessWidget {
  final String text;
  final String? labelText;

  const ItemCard({
    super.key,
    required this.text,
    this.labelText,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Column(
        children: [
          if (labelText != null)
            Text(
              labelText!,
              style: TextStyle(
                fontSize: 16.0.sp,
                color: Colors.black87,
              ),
            ),
          SizedBox(
            height: 5.h,
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
            decoration: BoxDecoration(
              border:
                  Border.all(color: Colors.black), // تعيين حدود للـ Container
              borderRadius:
                  BorderRadius.circular(4.0), // تدوير الحواف للـ Container
            ),
            child: Text(
              text,
              style: TextStyle(
                fontSize: 16.0.sp,
                color: Colors.black87,
              ),
              maxLines: 3,
            ),
          ),
        ],
      ),
    );
  }
}
