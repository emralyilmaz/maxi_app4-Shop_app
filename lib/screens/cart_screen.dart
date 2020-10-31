import 'package:app4_shop_app/providers/cart.dart';
import 'package:app4_shop_app/providers/orders.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:app4_shop_app/widgets/cart_item.dart' as ci;

class CartScreen extends StatelessWidget {
  static const routeName = "/cart";
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Your Cart"),
      ),
      body: Column(
        children: [
          Card(
            margin: EdgeInsets.all(15),
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Total",
                    style: TextStyle(fontSize: 20),
                  ),
                  Spacer(),
                  Chip(
                    label: Text(
                      "\$ ${cart.totalAmount.toStringAsFixed(2)}",
                      style: TextStyle(color: Colors.white),
                    ),
                    backgroundColor: Theme.of(context).primaryColor,
                  ),
                  FlatButton(
                    child: Text("Ordeer Now"),
                    onPressed: () {
                      Provider.of<Orders>(context, listen: false).addOrder(
                          cart.items.values.toList(), cart.totalAmount);
                      cart.clear();
                    },
                    textColor: Theme.of(context).primaryColor,
                  )
                ],
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: cart.items.length,
              itemBuilder: (ctx, i) => ci.CartItem(
                  cart.items.values.toList()[i].id,
                  cart.items.keys.toList()[i],
                  cart.items.values.toList()[i].price,
                  cart.items.values.toList()[i].quantity,
                  cart.items.values.toList()[i].title),
            ),
          )
        ],
      ),
    );
  }
}
