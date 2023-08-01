import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:grocery_app/consts/firebase_consts.dart';
import 'package:grocery_app/provider/cart_provider.dart';
import 'package:grocery_app/provider/orders_provider.dart';
import 'package:grocery_app/provider/products_provider.dart';
import 'package:grocery_app/services/global_methods.dart';
import 'package:grocery_app/services/utils.dart';
import 'package:grocery_app/views/common_widgets/custom_text_widget.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class CheckoutWidget extends StatefulWidget {
  const CheckoutWidget({Key? key}) : super(key: key);

  @override
  State<CheckoutWidget> createState() => _CheckoutWidgetState();
}

class _CheckoutWidgetState extends State<CheckoutWidget> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    final Color color = Utils(context).color;
    Size size = Utils(context).getScreenSize;
    final cartProvider = Provider.of<CartProvider>(context);
    final productProvider = Provider.of<ProductsProvider>(context);
    final orderProvider = Provider.of<OrdersProvider>(context);

    double total = 0.0;
    cartProvider.getCartItems.forEach((key, value) {
      final getCurrProduct = productProvider.findProdById(value.productId);
      total += (getCurrProduct.isOnSale
              ? getCurrProduct.salePrice
              : getCurrProduct.price) *
          value.quantity;
    });
    return SizedBox(
      width: double.infinity,
      height: size.height * 0.1,
      // color: ,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Row(children: [
          Material(
            color: Colors.green,
            borderRadius: BorderRadius.circular(10),
            child: InkWell(
              borderRadius: BorderRadius.circular(10),
              onTap: () async {
                User? user = KauthInstance.currentUser;

                final productProvider =
                    Provider.of<ProductsProvider>(context, listen: false);

                cartProvider.getCartItems.forEach((key, value) async {
                  final getCurrProduct = productProvider.findProdById(
                    value.productId,
                  );
                  setState(() {
                    _isLoading = true;
                  });
                  try {
                    final orderId = const Uuid().v4();
                    await FirebaseFirestore.instance
                        .collection('orders')
                        .doc(orderId)
                        .set({
                      'orderId': orderId,
                      'userId': user!.uid,
                      'productId': value.productId,
                      'price': (getCurrProduct.isOnSale
                              ? getCurrProduct.salePrice
                              : getCurrProduct.price) *
                          value.quantity,
                      'totalPrice': total,
                      'quantity': value.quantity,
                      'imageUrl': getCurrProduct.imageUrl,
                      'userName': user.displayName,
                      'orderDate': Timestamp.now(),
                    });
                    await cartProvider.clearOnlineCart();
                    cartProvider.clearLocalCart();
                    orderProvider.fetchOrders();
                    setState(() {
                      _isLoading = false;
                    });

                    await ScaffoldMessenger.of(context)
                        .showSnackBar(const SnackBar(
                      content: Text('Your order has been placed'),
                      backgroundColor: Colors.green,
                    ));
                  } catch (error) {
                    GlobalMethods.errorDialog(
                        subtitle: error.toString(), context: context);
                    setState(() {
                      _isLoading = false;
                    });
                  } finally {
                    setState(() {
                      _isLoading = false;
                    });
                  }
                });
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: _isLoading
                    ? const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator()),
                      )
                    : CustomTextWidget(
                        text: 'Order Now',
                        textSize: 20,
                        color: Colors.white,
                      ),
              ),
            ),
          ),
          const Spacer(),
          FittedBox(
              child: CustomTextWidget(
            text: 'Total: \$${total.toStringAsFixed(2)}',
            color: color,
            textSize: 18,
            isTitle: true,
          ))
        ]),
      ),
    );
  }
}
