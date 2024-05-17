import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:technaureus_task/models/customer_model.dart';

class CustomerCard extends StatefulWidget {
  const CustomerCard({super.key, required this.user});
  final CustomerData user;

  @override
  State<CustomerCard> createState() => _CustomerCardState();
}

class _CustomerCardState extends State<CustomerCard> {
  String baseUrl = "http://143.198.61.94:8000";

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(color: Colors.black.withOpacity(.4), blurRadius: 9.r)
      ], color: Colors.white, borderRadius: BorderRadius.circular(11.r)),
      height: MediaQuery.of(context).size.height * .12,
      child: Padding(
        padding: EdgeInsets.only(
          left: 7.w,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                widget.user.profilePic != null
                    ? Container(
                        clipBehavior: Clip.hardEdge,
                        height: MediaQuery.of(context).size.height * .1,
                        width: MediaQuery.of(context).size.height * .1,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(13.r)),
                        child: Image.network(
                          "$baseUrl${widget.user.profilePic.toString()}",
                          fit: BoxFit.cover,
                        ),
                      )
                    : Container(
                        clipBehavior: Clip.hardEdge,
                        height: MediaQuery.of(context).size.height * .1,
                        width: MediaQuery.of(context).size.height * .1,
                        decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(13.r)),
                        child: Image.asset(
                          "asset/images/profilepic.png",
                          fit: BoxFit.cover,
                        ),
                      ),
                Gap(5.w),
                SizedBox(
                    height: 75.h,
                    child: VerticalDivider(
                      thickness: .5,
                      width: 9.w,
                      color: Colors.black.withOpacity(.5),
                    )),
                Gap(7.w),
                Padding(
                  padding: EdgeInsets.only(top: 8.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            widget.user.name.toString().toUpperCase(),
                            style: TextStyle(
                                fontSize: 16.sp,
                                color: Colors.black,
                                fontWeight: FontWeight.w700,
                                fontFamily: "DM Sans"),
                          ),
                        ],
                      ),
                      Text(
                        "ID:${widget.user.id.toString()}",
                        style: TextStyle(
                            fontSize: 13.sp,
                            color: const Color(0xff647A5F).withOpacity(.5),
                            fontWeight: FontWeight.w500,
                            fontFamily: "DM Sans"),
                      ),
                      RichText(
                        text: TextSpan(
                          text: widget.user.street!.toUpperCase(),
                          style: TextStyle(
                              fontSize: 13.sp,
                              color: const Color(0xff647A5F).withOpacity(.5),
                              fontWeight: FontWeight.w500,
                              fontFamily: "DM Sans"),
                          children: [
                            TextSpan(
                              text: " ,${widget.user.streetTwo!.toUpperCase()}",
                              style: TextStyle(
                                  fontSize: 13.sp,
                                  color:
                                      const Color(0xff647A5F).withOpacity(.5),
                                  fontWeight: FontWeight.w500,
                                  fontFamily: "DM Sans"),
                            ),
                            TextSpan(
                              text: " ,${widget.user.state!.toUpperCase()}",
                              style: TextStyle(
                                  fontSize: 13.sp,
                                  color:
                                      const Color(0xff647A5F).withOpacity(.5),
                                  fontWeight: FontWeight.w500,
                                  fontFamily: "DM Sans"),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(
                top: 5.h,
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Image.asset(
                        "asset/images/phone.jpg",
                        height: 17.h,
                        width: 17.w,
                      ),
                      Image.asset(
                        "asset/images/whatsapp.jpg",
                        height: 20.h,
                        width: 20.w,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
