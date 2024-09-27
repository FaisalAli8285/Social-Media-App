import 'package:finallysocialapp/res/colors.dart';
import 'package:finallysocialapp/res/fonts.dart';
import 'package:finallysocialapp/utils/Routes/routes.dart';
import 'package:finallysocialapp/utils/Routes/routes_name.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: AppColors.primaryMaterialColor,
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(
          color: AppColors.whiteColor,
          centerTitle: true,
          titleTextStyle: TextStyle(
              fontSize: 22,
              fontFamily: AppFonts.sfProDisplayMedium,
              color: AppColors.primaryTextTextColor),
        ),
        // textTheme: TextTheme(
        //   headlineLarge: TextStyle(
        //       fontSize: 40,
        //       fontFamily: AppFonts.sfProDisplayMedium,
        //       color: AppColors.primaryTextTextColor,
        //       fontWeight: FontWeight.w500),
        //   headlineMedium: TextStyle(
        //       fontSize: 25,
        //       fontFamily: AppFonts.sfProDisplayMedium,
        //       color: AppColors.primaryTextTextColor,
        //       fontWeight: FontWeight.w500),
        //   headlineSmall: TextStyle(
        //       fontSize: 17,
        //       fontFamily: AppFonts.sfProDisplayBold,
        //       color: AppColors.primaryTextTextColor,
        //       fontWeight: FontWeight.w700),
        //   bodyLarge: TextStyle(
        //       fontSize: 40,
        //       fontFamily: AppFonts.sfProDisplayBold,
        //       color: AppColors.primaryTextTextColor,
        //       fontWeight: FontWeight.w700),
        //   bodyMedium: TextStyle(
        //       fontSize: 40,
        //       fontFamily: AppFonts.sfProDisplayRegular,
        //       color: AppColors.primaryTextTextColor,
        //       height: 1.6),
        // ),
      ),
      initialRoute: RouteName.splashScreen,
      onGenerateRoute: Routes.generateRoute,
    );
  }
}
