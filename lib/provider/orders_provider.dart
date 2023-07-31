import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:grocery_app/models/orders_model.dart';

class OrdersProvider with ChangeNotifier {
  static List<OrderModel> _orders = [];
  List<OrderModel> get getOrders {
    return _orders;
  }

  Future<void> fetchOrders() async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    User? user = auth.currentUser;
    var uid = user!.uid;
    await FirebaseFirestore.instance
        .collection('orders')
        .where('userId', isEqualTo: uid)
        .orderBy('orderDate', descending: false)
        .get()
        .then((QuerySnapshot ordersSnapshot) {
      _orders = [];
      // _orders.clear();
      ordersSnapshot.docs.forEach((element) {
        _orders.insert(
          0,
          OrderModel(
            orderId: element.data().toString().contains('orderId') ?element.get('orderId'):"",
            userId: element.data().toString().contains('userId') ? element.get('userId') :"",
            productId: element.data().toString().contains('productId') ? element.get('productId'):"",
            userName: element.data().toString().contains('userName') ? element.get('userName') :"",
            price: element.data().toString().contains('price') ? element.get('price').toString() : "".toString(),
            imageUrl: element.data().toString().contains('imageUrl') ?  element.get('imageUrl'):"",
            quantity:element.data().toString().contains('quantity') ?  element.get('quantity').toString():"".toString(),
            orderDate: element.data().toString().contains('orderDate') ? element.get('orderDate'):"",
          ),
        );
      });
    });
    notifyListeners();
  }
}
