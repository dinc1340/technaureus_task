import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:technaureus_task/models/product_model.dart';
import 'package:technaureus_task/provider/product.dart';
import 'package:technaureus_task/screens/customer_screen.dart';
import 'package:technaureus_task/screens/product_screen.dart';
import 'package:technaureus_task/services/product_api.dart';
import 'package:technaureus_task/widgets/cart_card.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  ProductClass? datas;

  @override
  void initState() {
    Provider.of<ProductProvider>(context, listen: false);
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
      backgroundColor: const Color.fromARGB(255, 202, 230, 202),
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
        backgroundColor: const Color.fromARGB(255, 202, 230, 202),
        scrolledUnderElevation: 0,
        title: const Text(
          "My Cart",
          style: TextStyle(
              color: Color(0xff647A5F),
              fontWeight: FontWeight.bold,
              fontFamily: "DM Sans"),
        ),
        centerTitle: true,
      ),
      floatingActionButton: Padding(
        padding: EdgeInsets.only(left: 44.w, right: 18.w, bottom: 11),
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
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const ProductScreen(),
                              ));
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
      body: Consumer<ProductProvider>(builder: (context, a, b) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
          child: Column(
            children: [
              ListView.separated(
                shrinkWrap: true,
                separatorBuilder: (context, index) => SizedBox(
                  height: 20.h,
                ),
                itemBuilder: (context, index) {
                  return CartCard(
                    item: productProvider.cartItemList[index],
                    productProvider: productProvider,
                  );
                },
                itemCount: productProvider.cartItemList.length,
              ),
            ],
          ),
        );
      }),
    );
  }
}
