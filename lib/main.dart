import 'package:fianl_app/constants.dart';
import 'package:flutter/material.dart';
import 'detail_page.dart';
import 'home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
            appBarTheme: AppBarTheme(
                color: Constants.primaryColor,
                iconTheme: IconThemeData(color: Constants.secondaryColor))),
        title: 'Onboarding Screen',
        home: Home(),
        debugShowCheckedModeBanner: false,
        routes: {
          "home": (context) => const Home(),
          "detail_page": (context) => const DetailPage(),
        });
  }
}
