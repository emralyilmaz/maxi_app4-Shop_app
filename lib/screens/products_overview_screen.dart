import 'package:app4_shop_app/widgets/products_grid.dart';
import 'package:flutter/material.dart';

class ProductsOverviewScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("MyShop"),
        ),
        body: ProductsGrid());
  }
}
