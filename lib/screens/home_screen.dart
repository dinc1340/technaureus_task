import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:technaureus_task/models/categories.dart';
import 'package:technaureus_task/provider/product.dart';
import 'package:technaureus_task/screens/cart_page.dart';
import 'package:technaureus_task/screens/customer_screen.dart';
import 'package:technaureus_task/screens/product_screen.dart';
import 'package:technaureus_task/widgets/category.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool selected1 = false;
  bool selected2 = false;
  int myCurrentIndex = 0;

  final myItems = [
    Container(
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(35.r)),
      height: 100.h,
      width: 250.w,
      child: Image.asset(
        "asset/images/vegoff1.jpg",
        fit: BoxFit.cover,
      ),
    ),
    Container(
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(35.r)),
      height: 180.h,
      width: 250.w,
      child: Image.asset(
        "asset/images/veg.png",
        fit: BoxFit.cover,
      ),
    ),
    Container(
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(35.r)),
      height: 180.h,
      width: 250.w,
      child: Image.asset(
        "asset/images/vegoffer.jfif",
        fit: BoxFit.cover,
      ),
    ),
    Container(
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(35.r)),
      height: 180.h,
      width: 250.w,
      child: Image.asset(
        "asset/images/veg2.jpg",
        fit: BoxFit.cover,
      ),
    ),
    Container(
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(35.r)),
      height: 180.h,
      width: 250.w,
      child: Image.asset(
        "asset/images/veg3.jpg",
        fit: BoxFit.cover,
      ),
    ),
  ];
  TextEditingController grocery = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var productProvider = Provider.of<ProductProvider>(context, listen: false);
    productProvider.loadData();
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 85.h,
          backgroundColor: const Color.fromARGB(255, 202, 230, 202),
          scrolledUnderElevation: 0,
          title: Row(
            children: [
              Text(
                "Good Day!",
                style: TextStyle(
                    fontSize: 29.sp,
                    color: const Color(0xff647A5F),
                    fontWeight: FontWeight.bold,
                    fontFamily: "DM Sans"),
              ),
              Gap(9.w),
              Image.asset(
                "asset/images/waving-hand.500x512.png",
                color: const Color(0xffF5E2C9),
                height: 30.h,
                width: 30.w,
              )
            ],
          ),
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
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(55.h),
            child: SizedBox(
              height: 50.h,
              child: Padding(
                padding: EdgeInsets.only(right: 35.w, left: 20.w),
                child: TextField(
                  controller: grocery,
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(vertical: 13.h),
                      prefixIcon: Icon(
                        Icons.search,
                        size: 33.sp,
                        color: const Color(0xff647A5F).withOpacity(.3),
                      ),
                      fillColor: Colors.white,
                      filled: true,
                      hintText: "Search grocery",
                      hintStyle: TextStyle(
                        color: const Color(0xff647A5F).withOpacity(.3),
                      ),
                      border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(33.r))),
                ),
              ),
            ),
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 202, 230, 202),
        bottomNavigationBar: ClipRRect(
          child: Container(
            clipBehavior: Clip.hardEdge,
            height: 75.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(35.r),
                  topRight: Radius.circular(35.r)),
              gradient: LinearGradient(
                colors: [
                  Colors.green.withOpacity(0.7),
                  Colors.green.withOpacity(0.3),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: NavigationBar(
              backgroundColor: Colors.transparent,
              indicatorColor: Colors.transparent,
              destinations: [
                NavigationDestination(
                  enabled: true,
                  icon: Icon(
                    Icons.home,
                    size: 30.sp,
                    color: Colors.white,
                  ),
                  label: "Home",
                ),
                NavigationDestination(
                    icon: GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const ProductScreen(),
                            ));
                      },
                      child: Icon(
                        Icons.inventory,
                        size: 30.sp,
                        color: const Color(0xff647A5F),
                      ),
                    ),
                    label: "Product"),
                NavigationDestination(
                  icon: GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CustomerScreen(
                                productProvider: productProvider),
                          ));
                    },
                    child: Icon(
                      Icons.person_outline,
                      size: 30.sp,
                      color: const Color(0xff647A5F),
                    ),
                  ),
                  label: "Customer",
                ),
              ],
            ),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.only(left: 20.w),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Gap(22.h),
                CarouselSlider(
                    options: CarouselOptions(
                        padEnds: false,
                        onPageChanged: (index, reason) {
                          setState(() {
                            myCurrentIndex = index;
                          });
                        },
                        autoPlay: true,
                        viewportFraction: .72,
                        height: 170.h),
                    items: myItems),
                Gap(15.h),
                Center(
                  child: AnimatedSmoothIndicator(
                      effect: ColorTransitionEffect(
                        paintStyle: PaintingStyle.fill,
                        activeDotColor: const Color(0xff647A5F),
                        dotColor: Colors.white,
                        dotWidth: 7.w,
                        radius: 7.r,
                        dotHeight: 7.h,
                      ),
                      activeIndex: myCurrentIndex,
                      count: myItems.length),
                ),
                Gap(15.h),
                Text(
                  "Categories",
                  style: TextStyle(
                      fontSize: 20.sp,
                      color: const Color(0xff647A5F),
                      fontWeight: FontWeight.bold,
                      fontFamily: "DM Sans"),
                ),
                Gap(11.h),
                SizedBox(
                  height: MediaQuery.of(context).size.height * .1,
                  width: double.infinity,
                  child: Builder(builder: (context) {
                    List<Categories> filteredUserData = categorylist;
                    if (grocery.text.isNotEmpty) {
                      filteredUserData = filteredUserData
                          .where((user) => user.categorytype
                              .toLowerCase()
                              .contains(grocery.text.toLowerCase()))
                          .toList();
                    }
                    return ListView.separated(
                        physics: const ClampingScrollPhysics(),
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return CategoryExtract(
                            image: filteredUserData[index].categoryimage,
                            type: filteredUserData[index].categorytype,
                          );
                        },
                        separatorBuilder: (context, index) => SizedBox(
                              width: 11.w,
                            ),
                        itemCount: filteredUserData.length);
                  }),
                ),
                Gap(11.h),
                Padding(
                  padding: EdgeInsets.only(right: 11.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Discovery",
                        style: TextStyle(
                            fontSize: 20.sp,
                            color: const Color(0xff647A5F),
                            fontWeight: FontWeight.bold,
                            fontFamily: "DM Sans"),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const ProductScreen(),
                              ));
                        },
                        child: Row(
                          children: [
                            Text(
                              "See all",
                              style: TextStyle(
                                  fontSize: 13.sp,
                                  color: const Color(0xff647A5F),
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "DM Sans"),
                            ),
                            Gap(5.w),
                            Icon(
                              Icons.arrow_forward_ios,
                              size: 11.sp,
                              color: const Color(0xff647A5F),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Gap(45.h),
                Padding(
                  padding: EdgeInsets.only(
                    right: 22.w,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * .4,
                            height: MediaQuery.of(context).size.height * .15,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15.r),
                                color: Colors.white),
                            child: Padding(
                              padding: EdgeInsets.only(
                                  top: 80.h, left: 11.w, right: 11.w),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Chicken Broiler",
                                        style: TextStyle(
                                            fontSize: 11.sp,
                                            color: const Color.fromARGB(
                                                255, 33, 131, 8),
                                            fontWeight: FontWeight.bold,
                                            fontFamily: "DM Sans"),
                                      ),
                                      RichText(
                                        text: TextSpan(
                                          text: "\$35/",
                                          style: TextStyle(
                                              fontSize: 17.sp,
                                              color: const Color.fromARGB(
                                                  255, 33, 131, 8),
                                              fontWeight: FontWeight.bold,
                                              fontFamily: "DM Sans"),
                                          children: [
                                            TextSpan(
                                              text: "kg",
                                              style: TextStyle(
                                                  fontSize: 11.sp,
                                                  color: const Color.fromARGB(
                                                          255, 33, 131, 8)
                                                      .withOpacity(.5),
                                                  fontWeight: FontWeight.w500,
                                                  fontFamily: "DM Sans"),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  Container(
                                      height: 27.h,
                                      width: 27.w,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(100.sp),
                                        color: Colors.green,
                                      ),
                                      child: Center(
                                        child: Icon(
                                          Icons.add,
                                          size: 15.sp,
                                          color: Colors.white,
                                        ),
                                      )),
                                ],
                              ),
                            ),
                          ),
                          Positioned(
                            top: -45.h,
                            left: 25.w,
                            child: Image.asset(
                              "asset/images/chicken.png",
                              height: 99.h,
                              width: 99.w,
                            ),
                          ),
                          Positioned(
                            right: 15.w,
                            top: 11.h,
                            child: GestureDetector(
                              onTap: () {
                                selected1 = !selected1;
                                setState(() {});
                              },
                              child: selected1 == false
                                  ? Icon(
                                      Icons.favorite_border,
                                      color: Colors.red,
                                      size: 20.sp,
                                    )
                                  : Icon(
                                      Icons.favorite,
                                      color: Colors.red,
                                      size: 20.sp,
                                    ),
                            ),
                          )
                        ],
                      ),
                      Gap(22.w),
                      Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * .4,
                            height: MediaQuery.of(context).size.height * .15,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15.r),
                                color: Colors.white),
                            child: Padding(
                              padding: EdgeInsets.only(
                                  top: 80.h, left: 11.w, right: 11.w),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Beef Tendorioin",
                                        style: TextStyle(
                                            fontSize: 11.sp,
                                            color: const Color.fromARGB(
                                                255, 33, 131, 8),
                                            fontWeight: FontWeight.bold,
                                            fontFamily: "DM Sans"),
                                      ),
                                      RichText(
                                        text: TextSpan(
                                          text: "\$45/",
                                          style: TextStyle(
                                              fontSize: 17.sp,
                                              color: const Color.fromARGB(
                                                  255, 33, 131, 8),
                                              fontWeight: FontWeight.bold,
                                              fontFamily: "DM Sans"),
                                          children: [
                                            TextSpan(
                                              text: "kg",
                                              style: TextStyle(
                                                  fontSize: 11.sp,
                                                  color: const Color.fromARGB(
                                                          255, 33, 131, 8)
                                                      .withOpacity(.5),
                                                  fontWeight: FontWeight.w500,
                                                  fontFamily: "DM Sans"),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  Container(
                                      height: 27.h,
                                      width: 27.w,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(100.sp),
                                        color: Colors.green,
                                      ),
                                      child: Center(
                                        child: Icon(
                                          Icons.add,
                                          size: 15.sp,
                                          color: Colors.white,
                                        ),
                                      )),
                                ],
                              ),
                            ),
                          ),
                          Positioned(
                            top: -45.h,
                            left: 25.w,
                            child: Image.asset(
                              "asset/images/beef.png",
                              height: 99.h,
                              width: 99.w,
                            ),
                          ),
                          Positioned(
                            right: 15.w,
                            top: 11.h,
                            child: GestureDetector(
                              onTap: () {
                                selected2 = !selected2;
                                setState(() {});
                              },
                              child: selected2 == false
                                  ? Icon(
                                      Icons.favorite_border,
                                      color: Colors.red,
                                      size: 20.sp,
                                    )
                                  : Icon(
                                      Icons.favorite,
                                      color: Colors.red,
                                      size: 20.sp,
                                    ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
