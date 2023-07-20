import 'package:flutter/material.dart';
import 'package:grocery_app/services/utils.dart';
import 'package:grocery_app/views/common_widgets/custom_text_widget.dart';

class AddToCardWidgetDetails extends StatelessWidget {
  const AddToCardWidgetDetails({Key? key, required this.quantityTextController}) : super(key: key);

  final  TextEditingController quantityTextController ;
  @override
  Widget build(BuildContext context) {
    final Color color = Utils(context).color;
    return Container(
      width: double.infinity,
      padding:
      const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
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
                        text: '\$2.59/',
                        color: color,
                        textSize: 20,
                        isTitle: true,
                      ),
                      CustomTextWidget(
                        text: '${quantityTextController.text}Kg',
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
                onTap: () {},
                borderRadius: BorderRadius.circular(10),
                child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: CustomTextWidget(
                        text: 'Add to cart',
                        color: Colors.white,
                        textSize: 18)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
