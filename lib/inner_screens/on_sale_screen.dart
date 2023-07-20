import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:grocery_app/views/common_widgets/back_widget.dart';
import 'package:grocery_app/views/common_widgets/custom_text_widget.dart';
import 'package:grocery_app/views/common_widgets/empty_products_widget.dart';
import 'package:grocery_app/views/home/widgets/on_sale_widget.dart';

import '../services/utils.dart';

class OnSaleScreen extends StatelessWidget {
  static const routeName = "/OnSaleScreen";
  const OnSaleScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Color color = Utils(context).color;
    Size size = Utils(context).getScreenSize;
    bool isEmpty = false ;
    return Scaffold(
      appBar: AppBar(
        leading: BackWidget(),
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: CustomTextWidget(
          text: 'Products on sale',
          color: color,
          textSize: 24.0,
          isTitle: true,
        ),
      ),
      body: isEmpty ? const EmptyProdWidget(text: 'No products on sale yet!,\nStay tuned',)
        : GridView.count(
        crossAxisCount: 2,
        padding: EdgeInsets.zero,
        // crossAxisSpacing: 10,
        childAspectRatio: size.width / (size.height * 0.45),
        children: List.generate(16, (index) {
          return const OnSaleWidget(isInner:true);
        }),
      ),
    );
  }
}
