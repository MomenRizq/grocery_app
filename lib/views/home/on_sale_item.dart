import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:grocery_app/inner_screens/product_details/product_details_view.dart';
import 'package:grocery_app/services/global_methods.dart';
import 'package:grocery_app/services/utils.dart';
import 'package:grocery_app/views/common_widgets/price_widget.dart';
import 'package:grocery_app/views/common_widgets/custom_text_widget.dart';
import 'package:grocery_app/views/common_widgets/heart_button.dart';

class OnSaleItems extends StatelessWidget {
  const OnSaleItems({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Color color = Utils(context).color;
    final theme = Utils(context).getTheme;
    Size size = Utils(context).getScreenSize;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        color: Theme.of(context).cardColor.withOpacity(0.9),
        borderRadius: BorderRadius.circular(12),
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () {
            GlobalMethods.navigateTo(
                ctx: context, routeName: ProductDetailsView.routeName);
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
                        imageUrl: 'https://i.ibb.co/F0s3FHQ/Apricots.png',
                        height: size.width * 0.22,
                        width: size.width * 0.22,
                        boxFit: BoxFit.fill,
                      ),
                      Column(
                        children: [
                          CustomTextWidget(
                            text: '1KG',
                            color: color,
                            textSize: 22,
                            isTitle: true,
                          ),
                          const SizedBox(
                            height: 6,
                          ),
                          Row(
                            children: [
                              GestureDetector(
                                onTap: () {},
                                child: Icon(
                                  IconlyLight.bag2,
                                  size: 22,
                                  color: color,
                                ),
                              ),
                              HeartButton(),
                            ],
                          ),
                        ],
                      )
                    ],
                  ),
                  const PriceWidget(
                    salePrice:3.5 ,
                    price:7.8 ,
                    textPrice: '1',
                    isOnSale: false,
                  ),
                  const SizedBox(height: 5),
                  CustomTextWidget(text: 'Product title', color: color, textSize: 16, isTitle: true,),
                  const SizedBox(height: 5),
                ]),
          ),
        ),
      ),
    );
  }
}
