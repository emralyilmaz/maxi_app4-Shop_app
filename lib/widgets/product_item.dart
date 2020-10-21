// provider.of - consumer arasındaki fark:
// provider kullandığınızda, bu veri her değiştiğinde tüm derleme yöntemi yeniden çalıştırılır.
// Şimdi akıllı widget bölme ile, widget'larınızı böylelikle bu bir sorun olmayacak şekilde bölebilirsiniz
// çünkü bir şey değiştiğinde tüm yapı yöntemini çalıştırmak istersiniz,
// ancak her zaman widget ağacınızın yalnızca bir alt bölümünü çalıştırmak istediğiniz bir durum olabilir.
// bazı veriler değiştiğinde ve daha sonra, pencere öğesi ağacının yalnızca ürün verilerinize bağlı olan alt bölümünü bu dinleyiciyle sarmalayabilirsiniz.

import 'package:app4_shop_app/providers/cart.dart';
import 'package:app4_shop_app/providers/product.dart';
import 'package:app4_shop_app/screens/product_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductItem extends StatelessWidget {
  // final String id;
  // final String title;
  // final String imageUrl;

  // ProductItem(this.id, this.title, this.imageUrl);

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context, listen: false);
    final cart = Provider.of<Cart>(context, listen: false);
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed(
              ProductDetailScreen.routeName,
              arguments: product.id,
            );
          },
          child: Image.network(
            product.imageUrl,
            fit: BoxFit.cover,
          ),
        ),
        footer: GridTileBar(
          backgroundColor: Colors.black87,
          leading: Consumer<Product>(
            builder: (ctx, product, _) => IconButton(
              icon: Icon(
                product.isFavorite ? Icons.favorite : Icons.favorite_border,
              ),
              color: Theme.of(context).accentColor,
              onPressed: () {
                product.toggleFavoriteStatus();
              },
            ),
          ),
          title: Text(
            product.title,
            textAlign: TextAlign.center,
          ),
          trailing: IconButton(
            icon: Icon(
              Icons.shopping_cart,
            ),
            onPressed: () {
              cart.addItem(product.id, product.price, product.title);
            },
            color: Theme.of(context).accentColor,
          ),
        ),
      ),
    );
  }
}
