import 'package:flutter/material.dart';
import 'package:grocery_app/services/utils.dart';
import 'package:grocery_app/views/common_widgets/custom_text_widget.dart';

class AddToCardWidgetHome extends StatelessWidget {
  const AddToCardWidgetHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Color color = Utils(context).color;
    Size size = Utils(context).getScreenSize;
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
            (){},
        child: CustomTextWidget(
          text: /*_isInCart ? 'In cart' :*/ 'Add to cart',
          maxLines: 1,
          color: color,
          textSize: 20,
        ),
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
      ),
    );
  }
}
