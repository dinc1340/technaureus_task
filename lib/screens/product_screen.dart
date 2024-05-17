import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:technaureus_task/screens/cart_page.dart';
import 'package:technaureus_task/screens/customer_screen.dart';
import 'package:technaureus_task/services/product_api.dart';
import 'package:technaureus_task/models/product_model.dart';
import 'package:technaureus_task/provider/product.dart';
import 'package:technaureus_task/widgets/product_card.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  ProductClass? datas;

  @override
  void initState() {
    getData();
    super.initState();
  }

  getData() async {
    datas = await getUserData();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var productProvider = Provider.of<ProductProvider>(context, listen: false);
    productProvider.loadData();
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back,
            color: const Color(0xff647A5F),
            size: 25.sp,
          ),
        ),
        toolbarHeight: 100.h,
        scrolledUnderElevation: 0,
        title: const Text(
          "Fruit",
          style: TextStyle(
              color: Color(0xff647A5F),
              fontWeight: FontWeight.bold,
              fontFamily: "DM Sans"),
        ),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 202, 230, 202),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 22.w),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const CartPage(),
                    ));
              },
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    height: 50.h,
                    width: 50.h,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(55.r),
                        color: Colors.white),
                    child: const Icon(
                      Icons.shopping_cart_outlined,
                      size: 27,
                      color: Colors.green,
                    ),
                  ),
                  Consumer<ProductProvider>(builder: (a, b, c) {
                    int length = productProvider.cartItemList.length;
                    if (length == 0) {
                      return const SizedBox.shrink();
                    } else {
                      return Positioned(
                        right: -3.w,
                        top: -6.h,
                        child: Container(
                          height: 20.h,
                          width: 20.w,
                          decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(100)),
                          child: Center(
                            child: Text(
                              '$length',
                              style: TextStyle(
                                  color: Colors.white, fontSize: 11.sp),
                            ),
                          ),
                        ),
                      );
                    }
                  })
                ],
              ),
            ),
          )
        ],
      ),
      backgroundColor: const Color.fromARGB(255, 202, 230, 202),
      floatingActionButton: Padding(
        padding: EdgeInsets.only(left: 44.w, right: 11.w, bottom: 11),
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.r),
            boxShadow: [
              BoxShadow(
                color: Colors.green.withOpacity(0.2),
                spreadRadius: 2,
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
            gradient: LinearGradient(
              colors: [
                Colors.green.withOpacity(0.6),
                Colors.green.withOpacity(0.5),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Consumer<ProductProvider>(builder: (context, a, b) {
            return FloatingActionButton(
              backgroundColor: Colors.transparent,
              elevation: 0,
              child: Padding(
                padding: EdgeInsets.only(left: 22.w, right: 15.w, top: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          textAlign: TextAlign.justify,
                          "Subtotal",
                          style: TextStyle(
                              color: const Color(0xff647A5F),
                              fontWeight: FontWeight.w500,
                              fontSize: 11.sp),
                        ),
                        Text(
                          "\$${productProvider.totalCartPrice.toString()}",
                          style: TextStyle(
                              color: const Color.fromARGB(255, 29, 80, 31),
                              fontWeight: FontWeight.w800,
                              fontSize: 20.sp),
                        ),
                      ],
                    ),
                    GestureDetector(
                      onTap: () {
                        if (productProvider.cartItemList.isNotEmpty) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CustomerScreen(
                                    productProvider: productProvider),
                              ));
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                'Add Products',
                                textAlign: TextAlign.center,
                              ),
                              behavior: SnackBarBehavior.floating,
                            ),
                          );
                        }
                      },
                      child: Padding(
                        padding: EdgeInsets.only(bottom: 7.h),
                        child: Container(
                          width: MediaQuery.of(context).size.width * .4,
                          height: 30,
                          decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(11.r)),
                          child: Center(
                              child: Text(
                            "CHECKOUT NOW",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                                fontSize: 13.sp),
                          )),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              onPressed: () {},
            );
          }),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(left: 22.w, right: 22.w),
          child: Column(children: [
            Gap(50.h),
            datas == null
                ? const Center(child: CircularProgressIndicator())
                : Padding(
                    padding: EdgeInsets.only(
                      left: 5.w,
                      right: 6.w,
                      bottom: 70.h,
                    ),
                    child: GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 15.w,
                          mainAxisSpacing: 15.h),
                      itemBuilder: (context, index) {
                        return ProductCard(
                          data: datas!.data[index],
                          productProvider: productProvider,
                        );
                      },
                      itemCount: datas!.data.length,
                    ),
                  )
          ]),
        ),
      ),
    );
  }
}
