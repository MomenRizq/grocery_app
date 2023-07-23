import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:grocery_app/models/cart_model.dart';
import 'package:grocery_app/provider/cart_provider.dart';
import 'package:grocery_app/provider/products_provider.dart';
import 'package:grocery_app/services/utils.dart';
import 'package:grocery_app/views/common_widgets/custom_quantity_controller.dart';
import 'package:grocery_app/views/common_widgets/custom_text_widget.dart';
import 'package:provider/provider.dart';

class CustomQuantityWidget extends StatefulWidget {
  const CustomQuantityWidget({Key? key, required this.q}) : super(key: key);

  final int q ;


  @override
  State<CustomQuantityWidget> createState() => _CustomQuantityWidgetState();
}

class _CustomQuantityWidgetState extends State<CustomQuantityWidget> {
  final _quantityTextController = TextEditingController() ;
  @override
  void initState() {
    _quantityTextController.text = widget.q.toString();
    super.initState();
  }

  @override
  void dispose() {
    _quantityTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Color color = Utils(context).color;
    Size size = Utils(context).getScreenSize;
    final productProvider = Provider.of<ProductsProvider>(context);
    final cartModel = Provider.of<CartModel>(context);
    final getCurrProduct = productProvider.findProdById(cartModel.productId);
    final cartProvider = Provider.of<CartProvider>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomTextWidget(
          text: getCurrProduct.title,
          color: color,
          textSize: 20,
          isTitle: true,
        ),
        const SizedBox(
          height: 16.0,
        ),
        SizedBox(
          width: size.width * 0.3,
          child: Row(
            children: [
              _quantityController(
                fun: () {
                  if (_quantityTextController.text == '1') {
                    return;
                  } else {
                    cartProvider.reduceQuantityByOne(getCurrProduct.id);
                    setState(() {
                      _quantityTextController.text =
                          (int.parse(_quantityTextController.text) - 1)
                              .toString();
                    });
                  }
                },
                color: Colors.red,
                icon: CupertinoIcons.minus,
              ),
              Flexible(
                flex: 1,
                child: TextField(
                  controller: _quantityTextController,
                  keyboardType: TextInputType.number,
                  maxLines: 1,
                  decoration: const InputDecoration(
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(),
                    ),
                  ),
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(
                      RegExp('[0-9]'),
                    ),
                  ],
                  onChanged: (v) {
                    setState(() {
                      if (v.isEmpty) {
                        _quantityTextController.text = '1';
                      }
                    });
                  },
                ),
              ),
              _quantityController(
                fun: () {
                  cartProvider.increaseQuantityByOne(getCurrProduct.id);
                  setState(() {
                    _quantityTextController.text = (int.parse( _quantityTextController.text) + 1).toString() ;
                  });

                },
                color: Colors.green,
                icon: CupertinoIcons.plus,
              )
            ],
          ),
        ),
      ],
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
