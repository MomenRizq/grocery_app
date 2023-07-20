import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:grocery_app/services/global_methods.dart';
import 'package:grocery_app/services/utils.dart';
import 'package:grocery_app/views/cart/cart_view_body.dart';
import 'package:grocery_app/views/cart/widgets/checkout_widget.dart';
import 'package:grocery_app/views/common_widgets/custom_text_widget.dart';
import 'package:grocery_app/views/common_widgets/empty_screen.dart';

class CartView extends StatelessWidget {
  const CartView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Color color = Utils(context).color;
    Size size = Utils(context).getScreenSize;
    bool _isEmpty = true;
    return _isEmpty
        ? const EmptyScreen(
            title: 'Your cart is empty',
            subtitle: 'Add something and make me happy :)',
            buttonText: 'Shop now',
            imagePath: 'assets/images/cart.png',
          )
        : Scaffold(
            appBar: AppBar(
                elevation: 0,
                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                title: CustomTextWidget(
                  text: 'Cart (2)',
                  color: color,
                  isTitle: true,
                  textSize: 22,
                ),
                actions: [
                  IconButton(
                    onPressed: () {
                      GlobalMethods.warningDialog(
                          title: 'Empty your cart?',
                          subtitle: 'Are you sure?',
                          fct: () {},
                          context: context);
                    },
                    icon: Icon(
                      IconlyBroken.delete,
                      color: color,
                    ),
                  ),
                ]),
            body: Column(
              children: [
                const CheckoutWidget(),
                Expanded(
                  child: ListView.builder(
                    itemCount: 10,
                    itemBuilder: (ctx, index) {
                      return const CartViewBody();
                    },
                  ),
                ),
              ],
            ),
          );
  }
}
