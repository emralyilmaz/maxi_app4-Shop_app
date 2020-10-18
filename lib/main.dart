import 'package:app4_shop_app/screens/product_detail_screen.dart';
import 'package:app4_shop_app/screens/products_overview_screen.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
          primarySwatch: Colors.purple,
          accentColor: Colors.orange,
          fontFamily: "lato"),
      home: ProductsOverviewScreen(),
      routes: {ProductDetailScreen.routeName: (ctx) => ProductDetailScreen()},
    );
  }
}
