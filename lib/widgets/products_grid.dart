import 'package:app4_shop_app/providers/products.dart';
import 'package:app4_shop_app/widgets/product_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductsGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(context);
    final products = productsData.items;
    return GridView.builder(
        padding: const EdgeInsets.all(10),
        itemCount: products.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            // crossAxisCount: istenilen kolon bilgisidir. yani yan yana 2 adet ürün görüntülenecek.
            childAspectRatio: 3 / 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10),
        // SliverGridDelegateWithFixedCrossAxisCount ile belirli miktarda sütuna sahip olmak istediğimi tanımlayabilirim
        // ve bu kriterlerin karşılanması için öğeleri ekrana sıkıştırır.
        itemBuilder: (ctx, i) => ProductItem(
            products[i].id, products[i].title, products[i].imageUrl));
  }
}
