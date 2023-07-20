import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:grocery_app/inner_screens/product_details/product_details_view.dart';
import 'package:grocery_app/services/global_methods.dart';
import 'package:grocery_app/services/utils.dart';
import 'package:grocery_app/views/common_widgets/add_to_card_widget_home.dart';
import 'package:grocery_app/views/common_widgets/price_widget.dart';
import 'package:grocery_app/views/common_widgets/custom_text_widget.dart';
import 'package:grocery_app/views/common_widgets/heart_button.dart';

import 'package:provider/provider.dart';


class OurProductItem extends StatefulWidget {
  const OurProductItem({Key? key}) : super(key: key);

  @override
  State<OurProductItem> createState() => _OurProductItemState();
}

class _OurProductItemState extends State<OurProductItem> {
  final _quantityTextController = TextEditingController();
  @override
  void initState() {
    _quantityTextController.text = '1';
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
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        borderRadius: BorderRadius.circular(12),
        color: Theme.of(context).cardColor,
        child: InkWell(
          onTap: () {
            // GlobalMethods.navigateTo(
            //     ctx: context, routeName: ProductDetails.routeName);
            GlobalMethods.navigateTo(
                ctx: context, routeName:ProductDetailsView.routeName);
          },
          borderRadius: BorderRadius.circular(12),
          child: Column(children: [
            FancyShimmerImage(
              imageUrl: 'https://i.ibb.co/F0s3FHQ/Apricots.png',
              height: size.width * 0.21,
              width: size.width * 0.2,
              boxFit: BoxFit.fill,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    flex: 3,
                    child: CustomTextWidget(
                      text: "apple",
                      color: color,
                      maxLines: 1,
                      textSize: 18,
                      isTitle: true,
                    ),
                  ),
                  Flexible(
                      flex: 1,
                      child: HeartButton(
                        //productId: productModel.id,
                        //isInWishlist: _isInWishlist,
                      )),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                 Flexible(
                    flex: 3,
                    child: PriceWidget(
                      salePrice:3.5 ,
                      price:7.8 ,
                      textPrice: _quantityTextController.text  ,
                      isOnSale: true,
                    ),
                  ),
                  Flexible(
                    child: Row( mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          flex: 4,
                          child: FittedBox(
                            child: CustomTextWidget(
                              text: /*productModel.isPiece ? 'Piece' :*/ 'kg',
                              color: color,
                              textSize: 20,
                              isTitle: true,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 4,
                        ),
                        Flexible(
                            flex: 4,
                            // TextField can be used also instead of the textFormField
                            child: TextFormField(
                              controller: _quantityTextController,
                              key: const ValueKey('10'),
                              style: TextStyle(color: color, fontSize: 18),
                              keyboardType: TextInputType.number,
                              maxLines: 1,
                              enabled: true,
                              onChanged: (value) {
                                setState(() {
                                  if(value.isEmpty)
                                    {
                                      _quantityTextController.text = "1" ;
                                    }
                                });
                              },
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                  RegExp('[0-9.]'),
                                ),
                              ],
                            ))
                      ],
                    ),
                  )
                ],
              ),
            ),
            const Spacer(),
            AddToCardWidgetHome()
          ]),
        ),
      ),
    );
  }
}