import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:grocery_app/models/products_model.dart';
import 'package:grocery_app/provider/wishlist_provider.dart';
import 'package:grocery_app/provider/wishlist_provider.dart';
import 'package:grocery_app/provider/wishlist_provider.dart';
import 'package:grocery_app/services/utils.dart';
import 'package:provider/provider.dart';


class HeartButton extends StatelessWidget {
  const HeartButton({Key? key,required this.productId , this.isInWishlist = false });
  final String productId;
  final bool? isInWishlist;
  @override
  Widget build(BuildContext context) {
    final wishlistProvider = Provider.of<WishlistProvider>(context);
    final Color color = Utils(context).color;
    return GestureDetector(
      onTap: () {
        wishlistProvider.addRemoveProductToWishlist(productId: productId);
      },
      child: Icon(
        isInWishlist != null && isInWishlist == true
            ? IconlyBold.heart
            : IconlyLight.heart,
        size: 22,
        color:
        isInWishlist != null && isInWishlist == true ? Colors.red : color,
      ),
    );
  }
}