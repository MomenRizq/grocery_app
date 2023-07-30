import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:grocery_app/consts/firebase_consts.dart';
import 'package:grocery_app/models/cart_model.dart';
import 'package:grocery_app/models/products_model.dart';
import 'package:grocery_app/provider/cart_provider.dart';
import 'package:grocery_app/services/global_methods.dart';
import 'package:grocery_app/services/utils.dart';
import 'package:grocery_app/views/common_widgets/custom_text_widget.dart';
import 'package:provider/provider.dart';

class AddToCardWidgetHome extends StatelessWidget {
  const AddToCardWidgetHome({Key? key, required this.id, required this.qun})
      : super(key: key);
  final String id;

  final String qun;

  @override
  Widget build(BuildContext context) {
    final Color color = Utils(context).color;
    Size size = Utils(context).getScreenSize;
    final cartProvider = Provider.of<CartProvider>(context);
    final productModel = Provider.of<ProductModel>(context);
    bool? _isInCart = cartProvider.getCartItems.containsKey(productModel.id);
    return SizedBox(
      width: double.infinity,
      child: TextButton(
        onPressed: /*_isInCart
                    ? null
                    : () async {
                  // if (_isInCart) {
                  //   return;
                  // }
                  final User? user = authInstance.currentUser;

                  if (user == null) {
                    GlobalMethods.errorDialog(
                        subtitle: 'No user found, Please login first',
                        context: context);
                    return;
                  }
                  await GlobalMethods.addToCart(
                      productId: productModel.id,
                      quantity: int.parse(_quantityTextController.text),
                      context: context);
                  await cartProvider.fetchCart();
                  // cartProvider.addProductsToCart(
                  //     productId: productModel.id,
                  //     quantity: int.parse(_quantityTextController.text));
                },*/
            _isInCart
                ? null
                : () async{
                    final User? user = KauthInstance.currentUser;

                    if (user == null) {
                      GlobalMethods.errorDialog(
                          subtitle: 'No user found, Please login first',
                          context: context);
                      return;
                    }
                    await GlobalMethods.addToCart(
                        productId: id,
                        quantity:int.parse(qun),
                        context: context);
                    await cartProvider.fetchCart();
                    // cartProvider.addProductsToCart(
                    //     productId: id, quantity: int.parse(qun));
                  },
        style: ButtonStyle(
            backgroundColor:
                MaterialStateProperty.all(Theme.of(context).cardColor),
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(12.0),
                  bottomRight: Radius.circular(12.0),
                ),
              ),
            )),
        child: CustomTextWidget(
          text: _isInCart ? 'In cart' : 'Add to cart',
          maxLines: 1,
          color: color,
          textSize: 20,
        ),
      ),
    );
  }
}
