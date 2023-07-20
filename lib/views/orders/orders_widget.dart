import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:grocery_app/inner_screens/product_details/product_details_view.dart';
import 'package:grocery_app/services/global_methods.dart';
import 'package:grocery_app/views/common_widgets/custom_text_widget.dart';
import '../../services/utils.dart';

class OrderWidget extends StatefulWidget {
  const OrderWidget({Key? key}) : super(key: key);

  @override
  State<OrderWidget> createState() => _OrderWidgetState();
}

class _OrderWidgetState extends State<OrderWidget> {
  @override
  Widget build(BuildContext context) {
    final Color color = Utils(context).color;
    Size size = Utils(context).getScreenSize;
    return ListTile(
      subtitle: const Text('Paid: \$12.8'),
      onTap: () {
        GlobalMethods.navigateTo(
            ctx: context, routeName: ProductDetailsView.routeName);
      },
      leading: FancyShimmerImage(
        width: size.width * 0.2,
        imageUrl: 'https://i.ibb.co/F0s3FHQ/Apricots.png',
        boxFit: BoxFit.fill,
      ),
      title: CustomTextWidget(text: 'Title  x12', color: color, textSize: 18),
      trailing: CustomTextWidget(text: '03/08/2022', color: color, textSize: 18),
    );
  }
}
