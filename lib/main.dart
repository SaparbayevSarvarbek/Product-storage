import 'package:flutter/material.dart';
import 'package:flutter_app/pages/login_page.dart';
import 'package:flutter_app/view_model/category_view_model.dart';
import 'package:flutter_app/view_model/product_view_model.dart';
import 'package:flutter_app/view_model/sales_view_model.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
      create: (context) => ProductViewModel(),
    ),ChangeNotifierProvider(
      create: (context) => CategoryViewModel(),
    ),
    ChangeNotifierProvider(
      create: (context) => SalesViewModel(),
    ),
  ], child: const MyApp()));
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
        primarySwatch: Colors.red,
      ),
      home: LoginPage(),
    );
  }
}
