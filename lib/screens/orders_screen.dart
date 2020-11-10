import 'package:app4_shop_app/providers/orders.dart' show Orders;
import 'package:app4_shop_app/widgets/app_drawer.dart';
import 'package:app4_shop_app/widgets/order_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrdersScreen extends StatefulWidget {
  static const routeName = '/orders';

  @override
  _OrdersScreenState createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  Future _ordersFuture;
  Future _obtainOrdersFuture() {
    return Provider.of<Orders>(context, listen: false).fetchAndSetOrders();
  }

  @override
  void initState() {
    _ordersFuture = _obtainOrdersFuture();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print("building orders");
    // final orderData = Provider.of<Orders>(context);
    return Scaffold(
        appBar: AppBar(
          title: Text('Your Orders'),
        ),
        drawer: AppDrawer(),
        body: FutureBuilder(
            future: _ordersFuture,
            builder: (ctx, dataSnapshot) {
              if (dataSnapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else {
                if (dataSnapshot.error != null) {
                  // ...
                  return Center(child: Text("An error occurred!"));
                } else {
                  return Consumer<Orders>(
                      builder: (ctx, orderData, child) => ListView.builder(
                            itemCount: orderData.orders.length,
                            itemBuilder: (ctx, i) =>
                                OrderItem(orderData.orders[i]),
                          ));
                }
              }
            }));
  }
}

// FutureBuilder(): sizin için  try catch metodunu ekler ve
// mevcut anlık görüntüyü geleceğinizin mevcut durumuna getirecek bir kurucu alır,
//  böylece gelecekteki dönüşünüze göre farklı içerikler oluşturabilirsiniz.
