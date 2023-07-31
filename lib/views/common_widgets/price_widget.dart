import 'package:flutter/material.dart';
import 'package:grocery_app/services/utils.dart';
import 'package:grocery_app/views/common_widgets/custom_text_widget.dart';
class PriceWidget extends StatelessWidget {
  const PriceWidget({Key? key, required this.salePrice, required this.price, required this.textPrice, required this.isOnSale}) : super(key: key);
  final double  price;
  final num salePrice;
  final String textPrice;
  final bool isOnSale;

  @override
  Widget build(BuildContext context) {
    num userPrice = isOnSale? salePrice : price;
    final Color color = Utils(context).color;
    return FittedBox(
        child: Row(
          children: [
            CustomTextWidget(
              text: '\$${(userPrice * int.parse(textPrice)).toStringAsFixed(2)}',
              color: Colors.green,
              textSize: 22,
            ),
            const SizedBox(
              width: 5,
            ),
            Visibility(
              visible: isOnSale? true :false,
              child: Text(
                '\$${(price * int.parse(textPrice) ).toStringAsFixed(2)}',
                style: TextStyle(
                  fontSize: 15,
                  color: color,
                  decoration: TextDecoration.lineThrough,
                ),
              ),
            )
          ],
        ));
  }
}
