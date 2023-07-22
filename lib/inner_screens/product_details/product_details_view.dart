import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:grocery_app/inner_screens/product_details/product_details_body.dart';
import 'package:grocery_app/provider/products_provider.dart';
import 'package:grocery_app/views/common_widgets/custom_quantity_controller.dart';
import 'package:grocery_app/views/common_widgets/custom_text_widget.dart';
import 'package:grocery_app/views/common_widgets/heart_button.dart';
import 'package:provider/provider.dart';

import '../../services/utils.dart';

class ProductDetailsView extends StatelessWidget {
  static const routeName = '/ProductDetailsView';
  const ProductDetailsView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Size size = Utils(context).getScreenSize;
    final Color color = Utils(context).color;
    final productProviders = Provider.of<ProductsProvider>(context);

    final productId = ModalRoute.of(context)!.settings.arguments as String;
    final getCurrProduct = productProviders.findProdById(productId);

    return Scaffold(
      appBar: AppBar(
          leading: InkWell(
            borderRadius: BorderRadius.circular(12),
            onTap: () =>
            Navigator.canPop(context) ? Navigator.pop(context) : null,
            child: Icon(
              IconlyLight.arrowLeft2,
              color: color,
              size: 24,
            ),
          ),
          elevation: 0,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor),
      body: Column(children: [
        Flexible(
          flex: 2,
          child: FancyShimmerImage(
            imageUrl: getCurrProduct.imageUrl,
            boxFit: BoxFit.scaleDown,
            width: size.width,
            // height: screenHeight * .4,
          ),
        ),
        Flexible(
          flex: 3,
          child: ProductDetailsBody(id:productId )
        )
      ]),
    );
  }

}
