import 'package:flutter/material.dart';
import 'package:flutter_code_challenge/themes/theme.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'constants/texts.dart';
import 'screens/beer_list.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) => MaterialApp(
        title: appTitle,
        debugShowCheckedModeBanner: false,
        theme: YourBeersTheme.themeData(),
        home: const BeerList(),
      ),
    );
  }
}
