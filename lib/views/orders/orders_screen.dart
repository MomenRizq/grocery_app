import 'package:flutter/material.dart';
import 'package:grocery_app/provider/orders_provider.dart';
import 'package:grocery_app/views/common_widgets/back_widget.dart';
import 'package:grocery_app/views/common_widgets/custom_text_widget.dart';
import 'package:grocery_app/views/common_widgets/empty_screen.dart';
import 'package:provider/provider.dart';
import '../../services/utils.dart';
import 'orders_widget.dart';

class OrdersScreen extends StatefulWidget {
  static const routeName = '/OrderScreen';

  const OrdersScreen({Key? key}) : super(key: key);

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  @override
  Widget build(BuildContext context) {
    final Color color = Utils(context).color;
    final orderProvider = Provider.of<OrdersProvider>(context);
    final ordersList = orderProvider.getOrders;

    // Size size = Utils(context).getScreenSize;
   return FutureBuilder(
      future: orderProvider.fetchOrders(),
      builder: (context,snapshot){
        return ordersList.isEmpty
            ? const EmptyScreen(
          title: 'You didnt place any order yet',
          subtitle: 'order something and make me happy :)',
          buttonText: 'Shop now',
          imagePath: 'assets/images/cart.png',
        )
            : Scaffold(
            appBar: AppBar(
              leading: const BackWidget(),
              elevation: 0,
              centerTitle: false,
              title: CustomTextWidget(
                text: 'Your orders (${ordersList.length})',
                color: color,
                textSize: 24.0,
                isTitle: true,
              ),
              backgroundColor:
              Theme.of(context).scaffoldBackgroundColor.withOpacity(0.9),
            ),
            body: ListView.separated(
              itemCount: ordersList.length,
              itemBuilder: (ctx, index) {
                return ChangeNotifierProvider.value(
                  value: ordersList[index],
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 2, vertical: 6),
                    child: OrderWidget(),
                  ),
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return Divider(
                  color: color,
                  thickness: 1,
                );
              },
            ));
      },
    );
  }
}
