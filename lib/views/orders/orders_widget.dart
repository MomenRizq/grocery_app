import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:grocery_app/inner_screens/product_details/product_details_view.dart';
import 'package:grocery_app/models/orders_model.dart';
import 'package:grocery_app/provider/products_provider.dart';
import 'package:grocery_app/services/global_methods.dart';
import 'package:grocery_app/views/common_widgets/custom_text_widget.dart';
import 'package:provider/provider.dart';
import '../../services/utils.dart';

class OrderWidget extends StatefulWidget {
  const OrderWidget({Key? key}) : super(key: key);

  @override
  State<OrderWidget> createState() => _OrderWidgetState();
}

class _OrderWidgetState extends State<OrderWidget> {
  late String orderDateToShow;

  @override
  void didChangeDependencies() {
    final ordersModel = Provider.of<OrderModel>(context);
    var orderDate = ordersModel.orderDate.toDate();
    orderDateToShow = '${orderDate.day}/${orderDate.month}/${orderDate.year}';
    super.didChangeDependencies();
  }
  @override
  Widget build(BuildContext context) {
    final ordersModel = Provider.of<OrderModel>(context);
    final Color color = Utils(context).color;
    Size size = Utils(context).getScreenSize;
    final productProvider = Provider.of<ProductsProvider>(context);
    final getCurrProduct = productProvider.findProdById(ordersModel.productId);

    return ListTile(
      subtitle: Text('Paid: \$${double.parse(ordersModel.price).toStringAsFixed(2)}'),
      onTap: () {
        // GlobalMethods.navigateTo(
        //     ctx: context, routeName: ProductDetailsView.routeName);
      },
      leading: FancyShimmerImage(
        width: size.width * 0.21,
        height: size.width *0.35,
        imageUrl:getCurrProduct.imageUrl,
        boxFit: BoxFit.cover,
      ),
      title: CustomTextWidget(text: '${getCurrProduct.title}  x${ordersModel.quantity}', color: color, textSize: 18),
      trailing: CustomTextWidget(text: orderDateToShow, color: color, textSize: 18),
    );
  }
}
