import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_code_challenge/themes/theme.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'constants/texts.dart';
import 'screens/beer_list.dart';
import 'utils/favorite_beer_preferences.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  await FavoriteBeerPreferences.init();

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
