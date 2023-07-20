import 'package:flutter/material.dart';
import 'package:grocery_app/services/utils.dart';
import 'package:grocery_app/views/common_widgets/custom_text_widget.dart';

class CheckoutWidget extends StatelessWidget {
  const CheckoutWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Color color = Utils(context).color;
    Size size = Utils(context).getScreenSize;
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
              onTap: () {},
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: CustomTextWidget(
                  text: 'Order Now',
                  textSize: 20,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          const Spacer(),
          FittedBox(child: CustomTextWidget(text: 'Total: \$0.259', color: color, textSize: 18, isTitle: true,))
        ]),
      ),
    );
  }
}
