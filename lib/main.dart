import 'package:app4_shop_app/providers/auth.dart';
import 'package:app4_shop_app/providers/cart.dart';
import 'package:app4_shop_app/providers/orders.dart';
import 'package:app4_shop_app/providers/products.dart';
import 'package:app4_shop_app/screens/auth_screen.dart';
import 'package:app4_shop_app/screens/cart_screen.dart';
import 'package:app4_shop_app/screens/edit_product_screen.dart';
import 'package:app4_shop_app/screens/orders_screen.dart';
import 'package:app4_shop_app/screens/product_detail_screen.dart';
import 'package:app4_shop_app/screens/products_overview_screen.dart';
import 'package:app4_shop_app/screens/splash_screen.dart';
// import 'package:app4_shop_app/screens/products_overview_screen.dart';
import 'package:app4_shop_app/screens/user_producs_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider.value(
            value: Auth(),
          ),
          ChangeNotifierProxyProvider<Auth, Products>(
            update: (ctx, auth, previousProducts) => Products(
                auth.token,
                auth.userId,
                previousProducts == null ? [] : previousProducts.items),
          ),
          ChangeNotifierProvider.value(
            value: Cart(),
          ),
          ChangeNotifierProxyProvider<Auth, Orders>(
            update: (ctx, auth, previousOrder) => Orders(auth.token,
                auth.userId, previousOrder == null ? [] : previousOrder.orders),
          ),
        ],
        child: Consumer<Auth>(
          builder: (ctx, auth, _) => MaterialApp(
              title: 'MyShop',
              theme: ThemeData(
                primarySwatch: Colors.purple,
                accentColor: Colors.deepOrange,
                fontFamily: 'Lato',
              ),
              home: auth.isAuth
                  ? ProductsOverviewScreen()
                  : FutureBuilder(
                      future: auth.tryAutoLogin(),
                      builder: (ctx, authResultSnapshot) =>
                          authResultSnapshot.connectionState ==
                                  ConnectionState.waiting
                              ? SplashScreen()
                              : AuthScreen(),
                    ),
              routes: {
                ProductDetailScreen.routeName: (ctx) => ProductDetailScreen(),
                CartScreen.routeName: (ctx) => CartScreen(),
                OrdersScreen.routeName: (ctx) => OrdersScreen(),
                UserProductsScreen.routeName: (ctx) => UserProductsScreen(),
                EditProductScreen.routeName: (ctx) => EditProductScreen(),
              }),
        ));
  }
}
