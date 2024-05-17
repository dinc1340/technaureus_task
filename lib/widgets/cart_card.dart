import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:technaureus_task/models/cart_model.dart';
import 'package:technaureus_task/provider/product.dart';

class CartCard extends StatefulWidget {
  const CartCard({
    super.key,
    required this.productProvider,
    required this.item,
  });

  final CartItemModel item;
  final ProductProvider productProvider;

  @override
  State<CartCard> createState() => _CartCardState();
}

class _CartCardState extends State<CartCard> {
  String baseUrl = "http://143.198.61.94:8000";
  int count = 0;

  @override
  void initState() {
    count = widget.item.quantity;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, _, c) {
      count = widget.item.quantity;

      return Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(11.r)),
            height: 55.h,
            child: Padding(
              padding: EdgeInsets.only(left: 70.w, right: 11.w),
              child: Row(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.32,
                    child: Padding(
                      padding: EdgeInsets.only(top: 7.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.item.item.name!,
                            style: TextStyle(
                                fontSize: 13.sp,
                                color: const Color(0xff647A5F),
                                fontWeight: FontWeight.bold,
                                fontFamily: "DM Sans"),
                          ),
                          RichText(
                            text: TextSpan(
                              text: "\$${widget.item.item.price}",
                              style: TextStyle(
                                  fontSize: 15.sp,
                                  color: const Color(0xff647A5F),
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "DM Sans"),
                              children: [
                                TextSpan(
                                  text: "/kg",
                                  style: TextStyle(
                                      fontSize: 11.sp,
                                      color: const Color(0xff647A5F),
                                      fontWeight: FontWeight.w400,
                                      fontFamily: "DM Sans"),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          if (count > 0) {
                            setState(() {
                              count--;
                            });
                          }
                          widget.productProvider.removeFromCart(widget.item);
                        },
                        child: Container(
                            height: 27.h,
                            width: 27.w,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100.sp),
                                border: Border.all(color: Colors.green)),
                            child: Center(
                              child: Icon(
                                Icons.remove,
                                size: 13.sp,
                                color: Colors.green,
                              ),
                            )),
                      ),
                      Gap(7.w),
                      Text(
                        "$count",
                        style: TextStyle(
                            fontSize: 13.sp,
                            color: const Color(0xff647A5F),
                            fontWeight: FontWeight.bold,
                            fontFamily: "DM Sans"),
                      ),
                      Gap(7.w),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            count++;
                          });
                          widget.productProvider.addToCart(widget.item);
                        },
                        child: Container(
                            height: 27.h,
                            width: 27.w,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100.sp),
                              color: Colors.green,
                            ),
                            child: Center(
                              child: Icon(
                                Icons.add,
                                size: 13.sp,
                                color: Colors.white,
                              ),
                            )),
                      ),
                    ],
                  ),
                  const Spacer(),
                  Text(
                    "\$${widget.item.quantity * widget.item.item.price!}",
                    style: TextStyle(
                        fontSize: 15.sp,
                        color: const Color(0xff647A5F),
                        fontWeight: FontWeight.bold,
                        fontFamily: "DM Sans"),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: -13.h,
            left: 20.w,
            child: Container(
              clipBehavior: Clip.hardEdge,
              height: 35.h,
              width: 35.w,
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(5.r)),
              child: Image.network(
                "$baseUrl${widget.item.item.image.toString()}",
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      );
    });
  }
}
