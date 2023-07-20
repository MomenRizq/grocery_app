import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:grocery_app/services/utils.dart';
import 'package:provider/provider.dart';


class HeartButton extends StatefulWidget {
  const HeartButton({Key? key, /*required this.productId, this.isInWishlist = false*/})
      : super(key: key);
 // final String productId;
 // final bool? isInWishlist;

  @override
  State<HeartButton> createState() => _HeartButtonState();
}

class _HeartButtonState extends State<HeartButton> {
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    final Color color = Utils(context).color;
    return GestureDetector(
      onTap: () async {
       /* setState(() {
          loading = true;
        });
        try {
          final User? user = authInstance.currentUser;

          if (user == null) {
            GlobalMethods.errorDialog(
                subtitle: 'No user found, Please login first',
                context: context);
            return;
          }
          if (widget.isInWishlist == false && widget.isInWishlist != null) {
            await GlobalMethods.addToWishlist(
                productId: widget.productId, context: context);
          } else {
            await wishlistProvider.removeOneItem(
                wishlistId:
                wishlistProvider.getWishlistItems[getCurrProduct.id]!.id,
                productId: widget.productId);
          }
          await wishlistProvider.fetchWishlist();
          setState(() {
            loading = false;
          });
        } catch (error) {
          GlobalMethods.errorDialog(subtitle: '$error', context: context);
        } finally {
          setState(() {
            loading = false;
          });
        }*/
        // print('user id is ${user.uid}');
        // wishlistProvider.addRemoveProductToWishlist(productId: productId);
      },
      child: loading
          ? const Padding(
        padding: EdgeInsets.all(8.0),
        child: SizedBox(
            height: 15, width: 15, child: CircularProgressIndicator()),
      )
          : Icon(
        /*widget.isInWishlist != null && widget.isInWishlist == true
            ? IconlyBold.heart
            :*/ IconlyLight.heart,
        size: 22,
        color: /*widget.isInWishlist != null && widget.isInWishlist == true
            ? Colors.red
            :*/ color,
      ),
    );
  }
}