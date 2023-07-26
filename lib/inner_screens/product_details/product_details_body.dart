import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:grocery_app/consts/firebase_consts.dart';
import 'package:grocery_app/inner_screens/product_details/widgets/add_to_card_widget_details.dart';
import 'package:grocery_app/provider/cart_provider.dart';
import 'package:grocery_app/provider/products_provider.dart';
import 'package:grocery_app/provider/wishlist_provider.dart';
import 'package:grocery_app/services/global_methods.dart';
import 'package:grocery_app/services/utils.dart';
import 'package:grocery_app/views/common_widgets/custom_quantity_controller.dart';
import 'package:grocery_app/views/common_widgets/custom_text_widget.dart';
import 'package:grocery_app/views/common_widgets/heart_button.dart';
import 'package:provider/provider.dart';

class ProductDetailsBody extends StatefulWidget {
  const ProductDetailsBody({Key? key, required this.id}) : super(key: key);
  final String id;

  @override
  State<ProductDetailsBody> createState() => _ProductDetailsBodyState();
}

class _ProductDetailsBodyState extends State<ProductDetailsBody> {
  final _quantityTextController = TextEditingController(text: '1');

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    _quantityTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Color color = Utils(context).color;
    final productProviders = Provider.of<ProductsProvider>(context);
    final cartProvider = Provider.of<CartProvider>(context);
    final getCurrProduct = productProviders.findProdById(widget.id);
    double usedPrice = getCurrProduct.isOnSale
        ? getCurrProduct.salePrice
        : getCurrProduct.price;
    double totalPrice = usedPrice * int.parse(_quantityTextController.text);
    bool? _isInCart = cartProvider.getCartItems.containsKey(getCurrProduct.id);
    final wishlistProvider = Provider.of<WishlistProvider>(context);
    bool? _isInWishlist =
    wishlistProvider.getWishlistItems.containsKey(getCurrProduct.id);
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(40),
          topRight: Radius.circular(40),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20, left: 30, right: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: CustomTextWidget(
                    text: getCurrProduct.title,
                    color: color,
                    textSize: 25,
                    isTitle: true,
                  ),
                ),
                HeartButton(productId: getCurrProduct.id,isInWishlist: _isInWishlist,),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20, left: 30, right: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CustomTextWidget(
                  text: '\$${usedPrice.toStringAsFixed(2)}',
                  color: Colors.green,
                  textSize: 22,
                  isTitle: true,
                ),
                CustomTextWidget(
                  text: getCurrProduct.isPiece ? '/Piece' : '/Kg',
                  color: color,
                  textSize: 12,
                  isTitle: false,
                ),
                const SizedBox(
                  width: 10,
                ),
                Visibility(
                  visible: getCurrProduct.isOnSale ? true : false,
                  child: Text(
                    '\$${getCurrProduct.price.toStringAsFixed(2)}',
                    style: TextStyle(
                        fontSize: 15,
                        color: color,
                        decoration: TextDecoration.lineThrough),
                  ),
                ),
                const Spacer(),
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                  decoration: BoxDecoration(
                      color: const Color.fromRGBO(63, 200, 101, 1),
                      borderRadius: BorderRadius.circular(5)),
                  child: CustomTextWidget(
                    text: 'Free delivery',
                    color: Colors.white,
                    textSize: 20,
                    isTitle: true,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _quantityController(
                fun: () {
                  if (_quantityTextController.text == '1') {
                    return;
                  } else {
                    setState(() {
                      _quantityTextController.text =
                          (int.parse(_quantityTextController.text) - 1)
                              .toString();
                    });
                  }
                },
                icon: CupertinoIcons.minus,
                color: Colors.red,
              ),
              const SizedBox(
                width: 5,
              ),
              Flexible(
                flex: 1,
                child: TextField(
                  controller: _quantityTextController,
                  key: const ValueKey('quantity'),
                  keyboardType: TextInputType.number,
                  maxLines: 1,
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                  ),
                  textAlign: TextAlign.center,
                  cursorColor: Colors.green,
                  enabled: true,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp('[0-9]')),
                  ],
                  onChanged: (value) {
                    setState(() {
                      if (value.isEmpty) {
                        _quantityTextController.text = '1';
                      } else {}
                    });
                  },
                ),
              ),
              const SizedBox(
                width: 5,
              ),
              _quantityController(
                fun: () {
                  setState(() {
                    _quantityTextController.text =
                        (int.parse(_quantityTextController.text) + 1)
                            .toString();
                  });
                },
                icon: CupertinoIcons.plus,
                color: Colors.green,
              ),
            ],
          ),
          const Spacer(),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.secondary,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomTextWidget(
                        text: 'Total',
                        color: Colors.red.shade300,
                        textSize: 20,
                        isTitle: true,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      FittedBox(
                        child: Row(
                          children: [
                            CustomTextWidget(
                              text: '\$${totalPrice.toStringAsFixed(2)}/',
                              color: color,
                              textSize: 20,
                              isTitle: true,
                            ),
                            CustomTextWidget(
                              text: '${_quantityTextController.text}Kg',
                              color: color,
                              textSize: 16,
                              isTitle: false,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  width: 8,
                ),
                Flexible(
                  child: Material(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(10),
                    child: InkWell(
                      onTap: _isInCart
                          ? (){
                        cartProvider.removeOneItem(getCurrProduct.id);
                      }
                          : () {
                        final User? user =
                            KauthInstance.currentUser;

                        if (user == null) {
                          GlobalMethods.errorDialog(
                              subtitle:
                              'No user found, Please login first',
                              context: context);
                          return;
                        }
                        cartProvider.addProductsToCart(
                            productId: getCurrProduct.id,
                            quantity: int.parse(
                                _quantityTextController.text));
                      },
                      borderRadius: BorderRadius.circular(10),
                      child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: CustomTextWidget(
                              text: _isInCart ? 'In cart' : 'Add to cart',
                              color: Colors.white,
                              textSize: 18)),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _quantityController({
    required Function fun,
    required IconData icon,
    required Color color,
  }) {
    return Flexible(
      flex: 2,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: Material(
          color: color,
          borderRadius: BorderRadius.circular(12),
          child: InkWell(
            borderRadius: BorderRadius.circular(12),
            onTap: () {
              fun();
            },
            child: Padding(
              padding: const EdgeInsets.all(6.0),
              child: Icon(
                icon,
                color: Colors.white,
                size: 20,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
