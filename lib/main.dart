import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:technaureus_task/provider/customer.dart';
import 'package:technaureus_task/provider/product.dart';
import 'package:technaureus_task/screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(393, 852),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (_, child) {
          return MultiProvider(
            providers: [
              ChangeNotifierProvider(
                create: (context) => ProductProvider(),
              ),
              ChangeNotifierProvider(
                create: (context) => CustomerProvider(),
              )
            ],
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Flutter Demo',
              theme: ThemeData(
                colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
                useMaterial3: true,
              ),
              home: const HomeScreen(),
            ),
          );
        });
  }
}
