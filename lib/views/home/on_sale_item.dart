import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:grocery_app/inner_screens/product_details/product_details_view.dart';
import 'package:grocery_app/models/products_model.dart';
import 'package:grocery_app/provider/cart_provider.dart';
import 'package:grocery_app/provider/wishlist_provider.dart';
import 'package:grocery_app/services/global_methods.dart';
import 'package:grocery_app/services/utils.dart';
import 'package:grocery_app/views/common_widgets/price_widget.dart';
import 'package:grocery_app/views/common_widgets/custom_text_widget.dart';
import 'package:grocery_app/views/common_widgets/heart_button.dart';
import 'package:provider/provider.dart';

class OnSaleItems extends StatelessWidget {
  const OnSaleItems({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Color color = Utils(context).color;
    final theme = Utils(context).getTheme;
    Size size = Utils(context).getScreenSize;
    final productModel = Provider.of<ProductModel>(context);
    final cartProvider = Provider.of<CartProvider>(context);
    bool? _isInCart = cartProvider.getCartItems.containsKey(productModel.id);
    bool? _isInWishlist = WishlistProvider().getWishlistItems.containsKey(productModel.id);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        color: Theme.of(context).cardColor.withOpacity(0.9),
        borderRadius: BorderRadius.circular(12),
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () {
            Navigator.pushNamed(context,ProductDetailsView.routeName,
                arguments: productModel.id);
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                // mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FancyShimmerImage(
                        imageUrl: productModel.imageUrl,
                        height: size.width * 0.22,
                        width: size.width * 0.22,
                        boxFit: BoxFit.fill,
                      ),
                      Column(
                        children: [
                          CustomTextWidget(
                            text: productModel.isPiece ? "1 piece" :"1 Kg",
                            color: color,
                            textSize: 18,
                            maxLines: 1,
                            isTitle: true,
                          ),
                          const SizedBox(
                            height: 6,
                          ),
                          Row(
                            children: [
                              GestureDetector(
                                onTap: _isInCart
                                    ? (){
                                  cartProvider.removeOneItem(productModel.id);
                                }
                                    :() {
                                  cartProvider.addProductsToCart(productId: productModel.id,
                                      quantity: 1);
                                },
                                child: Icon(
                                  _isInCart ?IconlyBold.bag2 :IconlyLight.bag2,
                                  size: 22,
                                  color:_isInCart ?Colors.green: color,
                                ),
                              ),
                              HeartButton(isInWishlist: _isInWishlist,productId: productModel.id,),
                            ],
                          ),
                        ],
                      )
                    ],
                  ),
                   PriceWidget(
                    salePrice: productModel.salePrice ,
                    price:productModel.price ,
                    textPrice: '1',
                    isOnSale: true,
                  ),
                  const SizedBox(height: 5),
                  CustomTextWidget(text: productModel.title, color: color, textSize: 16, isTitle: true,),
                  const SizedBox(height: 5),
                ]),
          ),
        ),
      ),
    );
  }
}
