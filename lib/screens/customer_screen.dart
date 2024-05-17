// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:technaureus_task/provider/customer.dart';
import 'package:technaureus_task/provider/product.dart';
import 'package:technaureus_task/screens/home_screen.dart';
import 'package:technaureus_task/services/customer_api.dart';
import 'package:technaureus_task/models/customer_model.dart';
import 'package:technaureus_task/services/order.dart';
import 'package:technaureus_task/widgets/customer_card.dart';

class CustomerScreen extends StatefulWidget {
  const CustomerScreen({super.key, required this.productProvider});
  final ProductProvider productProvider;

  @override
  State<CustomerScreen> createState() => _CustomerScreenState();
}

class _CustomerScreenState extends State<CustomerScreen> {
  TextEditingController customer = TextEditingController();
  CustomerModel? customdata;

  @override
  void initState() {
    getCustomeData();
    super.initState();
  }

  getCustomeData() async {
    customdata = await getCustomerData();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var customerProvider =
        Provider.of<CustomerProvider>(context, listen: false);
    customerProvider.loadUser();
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 55.h,
        leading: Padding(
          padding: EdgeInsets.only(left: 11.w),
          child: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back_ios,
              size: 22.sp,
            ),
          ),
        ),
        scrolledUnderElevation: 0,
        title: const Text(
          "Customers",
          style: TextStyle(fontWeight: FontWeight.bold, fontFamily: "DM Sans"),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 15.w),
            child: const Icon(Icons.menu),
          )
        ],
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(55.h),
          child: SizedBox(
            height: 44.h,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 22.w),
              child: TextField(
                controller: customer,
                onChanged: (value) {
                  setState(() {});
                },
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.only(top: 7.0, bottom: 8.0),
                  hintStyle: TextStyle(
                      fontSize: 15.sp, color: Colors.black.withOpacity(.4)),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(55),
                    borderSide: BorderSide(color: Colors.black.withOpacity(.4)),
                  ),
                  disabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(55.r),
                    borderSide: BorderSide(color: Colors.black.withOpacity(.4)),
                  ),
                  prefixIcon: Icon(
                    Icons.search_rounded,
                    size: 33.sp,
                    color: Colors.black.withOpacity(.3),
                  ),
                  fillColor: Colors.white,
                  filled: true,
                  hintText: "Search",
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black.withOpacity(.5)),
                    borderRadius: BorderRadius.circular(55.r),
                  ),
                  suffixIcon: Padding(
                    padding: EdgeInsets.only(right: 7.w),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.qr_code,
                          color: Colors.black.withOpacity(.3),
                        ),
                        const SizedBox(width: 5.0),
                        const Icon(
                          Icons.add_circle,
                          color: Color(0xD8055597),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(left: 22.w, right: 22.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Gap(22.h),
              customdata == null
                  ? const Center(child: CircularProgressIndicator())
                  : Consumer<CustomerProvider>(
                      builder: (context, customerProvider, child) {
                      List<CustomerData> filteredUserData = customdata!.data!;

                      if (customer.text.isNotEmpty) {
                        filteredUserData = filteredUserData
                            .where((user) => user.name!
                                .toLowerCase()
                                .contains(customer.text.toLowerCase()))
                            .toList();
                      }
                      return ListView.separated(
                        separatorBuilder: (context, index) => SizedBox(
                          height: 15.h,
                        ),
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () async {
                              bool response = await createOrder(
                                  customerId: filteredUserData[index].id!,
                                  cartItemList:
                                      widget.productProvider.cartItemList,
                                  totalPrice:
                                      widget.productProvider.totalCartPrice);

                              if (response) {
                                widget.productProvider.clearData();
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const HomeScreen(),
                                  ),
                                );
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                      'Something went wrong! Try again later',
                                      textAlign: TextAlign.center,
                                    ),
                                    behavior: SnackBarBehavior.floating,
                                  ),
                                );
                              }
                            },
                            child: CustomerCard(user: filteredUserData[index]),
                          );
                        },
                        itemCount: filteredUserData.length,
                      );
                    })
            ],
          ),
        ),
      ),
    );
  }
}
