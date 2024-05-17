import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:technaureus_task/models/cart_model.dart';
import 'package:technaureus_task/models/product_model.dart';
import 'package:technaureus_task/provider/product.dart';

class ProductCard extends StatefulWidget {
  const ProductCard({
    super.key,
    this.data,
    required this.productProvider,
  });

  final ProductData? data;

  final ProductProvider productProvider;

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  String baseUrl = "http://143.198.61.94:8000";
  int count = 0;

  @override
  void initState() {
    super.initState();
    _updateCount();
  }

  void _updateCount() {
    count = widget.productProvider.cartItemList
        .where((item) => item.item.id == widget.data?.id)
        .map((item) => item.quantity)
        .fold(0, (previous, current) => current);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          width: MediaQuery.of(context).size.width * .5,
          height: MediaQuery.of(context).size.height * .15,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.r), color: Colors.white),
        ),
        Positioned(
          top: -40.h,
          left: 50.w,
          child: Container(
            clipBehavior: Clip.hardEdge,
            height: 85.h,
            width: 50.w,
            decoration:
                BoxDecoration(borderRadius: BorderRadius.circular(11.r)),
            child: Image.network(
              "$baseUrl${widget.data!.image.toString()}",
              fit: BoxFit.cover,
            ),
          ),
        ),
        Positioned(
            right: 20.w,
            top: 11.h,
            child: Icon(
              Icons.favorite_border,
              color: Colors.red,
              size: 22.sp,
            )),
        Padding(
          padding: EdgeInsets.only(top: 80.h, left: 7.w, right: 5.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.data!.name.toString(),
                    style: TextStyle(
                        fontSize: 11.sp,
                        color: const Color.fromARGB(255, 33, 131, 8),
                        fontWeight: FontWeight.bold,
                        fontFamily: "DM Sans"),
                  ),
                  RichText(
                    text: TextSpan(
                      text: "\$${widget.data!.price.toString()}/",
                      style: TextStyle(
                          fontSize: 15.sp,
                          color: const Color.fromARGB(255, 33, 131, 8),
                          fontWeight: FontWeight.bold,
                          fontFamily: "DM Sans"),
                      children: [
                        TextSpan(
                          text: "kg",
                          style: TextStyle(
                              fontSize: 11.sp,
                              color: const Color.fromARGB(255, 33, 131, 8),
                              fontWeight: FontWeight.bold,
                              fontFamily: "DM Sans"),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Consumer<ProductProvider>(builder: (context, a, b) {
                _updateCount();
                return Column(
                  children: [
                    count == 0
                        ? GestureDetector(
                            onTap: () {
                              setState(() {
                                count++;
                              });

                              widget.productProvider.addToCart(
                                CartItemModel(
                                  item: widget.data!,
                                ),
                              );
                            },
                            child: Container(
                                height: 25.h,
                                width: 25.w,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100.sp),
                                    color: Colors.green),
                                child: Center(
                                  child: Icon(
                                    Icons.add,
                                    size: 11.sp,
                                    color: Colors.white,
                                  ),
                                )),
                          )
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  if (count > 0) {
                                    setState(() {
                                      count--;
                                    });
                                  }
                                  widget.productProvider.removeFromCart(
                                    CartItemModel(
                                      item: widget.data!,
                                    ),
                                  );
                                },
                                child: Container(
                                    height: 25.h,
                                    width: 25.w,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(100.sp),
                                        border:
                                            Border.all(color: Colors.green)),
                                    child: Center(
                                      child: Icon(
                                        Icons.remove,
                                        size: 13.sp,
                                        color: Colors.green,
                                      ),
                                    )),
                              ),
                              Gap(3.w),
                              Text(
                                count.toString(),
                              ),
                              Gap(3.w),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    count++;
                                  });

                                  widget.productProvider.addToCart(
                                    CartItemModel(
                                      item: widget.data!,
                                    ),
                                  );
                                },
                                child: Container(
                                    height: 25.h,
                                    width: 25.w,
                                    decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.circular(100.sp),
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
                          )
                  ],
                );
              })
            ],
          ),
        )
      ],
    );
  }
}
