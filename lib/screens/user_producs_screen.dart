import 'package:app4_shop_app/providers/product.dart';
import 'package:app4_shop_app/providers/products.dart';
import 'package:app4_shop_app/screens/edit_product_screen.dart';
import 'package:app4_shop_app/widgets/app_drawer.dart';
import 'package:app4_shop_app/widgets/user_product_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserProductsScreen extends StatefulWidget {
  static const routeName = '/user-products';

  @override
  _UserProductsScreenState createState() => _UserProductsScreenState();
}

class _UserProductsScreenState extends State<UserProductsScreen> {
  List<Product> _list = [];
  bool _loading = false;

  Future<void> _refreshProducts(BuildContext context) async {
    await Provider.of<Products>(context, listen: false)
        .fetchAndSetProducts(true);
  }

  @override
  void initState() {
    super.initState();
    _fetcProducts();
  }

  _fetcProducts() async {
    setState(() {
      _loading = true;
    });
    await Provider.of<Products>(context, listen: false)
        .fetchAndSetProducts(true);

    setState(() {
      _list = context.read<Products>().items;
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Products'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(EditProductScreen.routeName);
            },
          ),
        ],
      ),
      drawer: AppDrawer(),
      body: RefreshIndicator(
        onRefresh: () => _refreshProducts(context),
        child: Padding(
          padding: EdgeInsets.all(8),
          child: _loading
              ? Center(child: CircularProgressIndicator())
              : ListView.builder(
                  itemCount: _list.length,
                  itemBuilder: (_, i) {
                    var product = _list[i];
                    return Column(
                      children: [
                        UserProductItem(
                          product.id,
                          product.title,
                          product.imageUrl,
                        ),
                        Divider(),
                      ],
                    );
                  },
                ),
        ),
      ),
    );
  }
}
