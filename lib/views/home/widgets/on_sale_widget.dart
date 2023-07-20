import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:grocery_app/services/utils.dart';
import 'package:grocery_app/views/common_widgets/price_widget.dart';
import 'package:grocery_app/views/common_widgets/custom_text_widget.dart';
import 'package:grocery_app/views/home/on_sale_item.dart';

class OnSaleWidget extends StatelessWidget {
  const OnSaleWidget({Key? key, this.isInner = false} ) : super(key: key);
  final bool? isInner ;

  @override
  Widget build(BuildContext context) {
    final Color color = Utils(context).color;
    final theme = Utils(context).getTheme;
    Size size = Utils(context).getScreenSize;
    return  Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        children: [
          Visibility(
            visible: isInner! ? false : true,
            child: RotatedBox(
              quarterTurns: -1,
              child: Row(
                children: [
                  CustomTextWidget(
                    text: 'On sale'.toUpperCase(),
                    color: Colors.red,
                    textSize: 22,
                    isTitle: true,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  const Icon(
                    IconlyLight.discount,
                    color: Colors.red,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            width: 8,
          ),
          Flexible(
            child: SizedBox(
              height: size.height * 0.24,
              child: ListView.builder(
                  itemCount: 10,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (ctx, index) {
                    return const OnSaleItems();
                  }),
            ),
          ),
        ],
      ),
    );
  }
}
