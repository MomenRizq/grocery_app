import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:grocery_app/inner_screens/product_details/widgets/add_to_card_widget_details.dart';
import 'package:grocery_app/services/utils.dart';
import 'package:grocery_app/views/common_widgets/custom_quantity_controller.dart';
import 'package:grocery_app/views/common_widgets/custom_text_widget.dart';
import 'package:grocery_app/views/common_widgets/heart_button.dart';


class ProductDetailsBody extends StatefulWidget {
  const ProductDetailsBody({Key? key}) : super(key: key);

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
                    text: 'title',
                    color: color,
                    textSize: 25,
                    isTitle: true,
                  ),
                ),
                const HeartButton(),
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
                  text: '\$2.59',
                  color: Colors.green,
                  textSize: 22,
                  isTitle: true,
                ),
                CustomTextWidget(
                  text: '/Kg',
                  color: color,
                  textSize: 12,
                  isTitle: false,
                ),
                const SizedBox(
                  width: 10,
                ),
                Visibility(
                  visible: true,
                  child: Text(
                    '\$3.9',
                    style: TextStyle(
                        fontSize: 15,
                        color: color,
                        decoration: TextDecoration.lineThrough),
                  ),
                ),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(
                      vertical: 4, horizontal: 8),
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
          AddToCardWidgetDetails(quantityTextController: _quantityTextController,),
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
