import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CategoryExtract extends StatelessWidget {
  const CategoryExtract({
    super.key,
    required this.image,
    required this.type,
  });
  final String image;
  final String type;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: MediaQuery.of(context).size.width * .17,
          height: MediaQuery.of(context).size.height * .08,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(11.r), color: Colors.white),
          child: Center(
            child: Padding(
              padding: EdgeInsets.only(top: 5.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset(
                    image,
                    height: 35,
                    width: 35,
                  ),
                  Text(
                    type,
                    style: TextStyle(
                        fontSize: 12.sp,
                        color: const Color(0xff647A5F),
                        fontWeight: FontWeight.bold,
                        fontFamily: "DM Sans"),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
