import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:grocery_app/consts/consts.dart';
import 'package:grocery_app/consts/firebase_consts.dart';
import 'package:grocery_app/provider/cart_provider.dart';
import 'package:grocery_app/provider/orders_provider.dart';
import 'package:grocery_app/provider/products_provider.dart';
import 'package:grocery_app/provider/wishlist_provider.dart';
import 'package:grocery_app/views/bottom_bar_view.dart';
import 'package:provider/provider.dart';


class FetchScreen extends StatefulWidget {
  const FetchScreen({Key? key}) : super(key: key);

  @override
  State<FetchScreen> createState() => _FetchScreenState();
}

class _FetchScreenState extends State<FetchScreen> {
  List<String> images = Consts.authImagesPaths;
  @override
  void initState() {
    images.shuffle();
    Future.delayed(const Duration(microseconds: 5), () async {
      final productsProvider =
          Provider.of<ProductsProvider>(context, listen: false);
      final cartProvider = Provider.of<CartProvider>(context , listen: false);
      final wishlistProvider = Provider.of<WishlistProvider>(context , listen: false);
      final ordersProvider = Provider.of<OrdersProvider>(context , listen: false);
      final User? user = KauthInstance.currentUser;

      if(user == null)
        {
          await productsProvider.fetchProducts();
          cartProvider.clearLocalCart();
          wishlistProvider.clearLocalWishlist();
        }
      else
        {
          await productsProvider.fetchProducts();
          await cartProvider.fetchCart();
          await wishlistProvider.fetchWishlist();
          await ordersProvider.fetchOrders();
        }

      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (ctx) => const BottomBarView(),
      ));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            images[0],
            fit: BoxFit.cover,
            height: double.infinity,
          ),
          Container(
            color: Colors.black.withOpacity(0.7),
          ),
          const Center(
            child: SpinKitFadingFour(
              color: Colors.white,
            ),
          )
        ],
      ),
    );
  }
}
