import 'package:app4_shop_app/providers/products.dart';
import 'package:app4_shop_app/screens/edit_product_screen.dart';
import 'package:app4_shop_app/widgets/app_drawer.dart';
import 'package:app4_shop_app/widgets/user_product_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserProductsScreen extends StatelessWidget {
  static const routeName = "/user-products";
  @override
  Widget build(BuildContext context) {
    final prodctsData = Provider.of<Products>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Products"),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(EditProductScreen.routeName);
            },
          )
        ],
      ),
      drawer: AppDrawer(),
      body: Padding(
        padding: EdgeInsets.all(8),
        child: ListView.builder(
          itemCount: prodctsData.items.length,
          itemBuilder: (_, i) => Column(
            children: [
              UserProductItem(
                  prodctsData.items[i].title, prodctsData.items[i].imageUrl),
              Divider()
            ],
          ),
        ),
      ),
    );
  }
}
