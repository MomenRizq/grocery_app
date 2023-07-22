import 'package:flutter/material.dart';
import 'package:grocery_app/consts/consts.dart';
import 'package:grocery_app/inner_screens/on_sale_screen.dart';
import 'package:grocery_app/inner_screens/our_product_screen.dart';
import 'package:grocery_app/models/products_model.dart';
import 'package:grocery_app/provider/products_provider.dart';
import 'package:grocery_app/services/global_methods.dart';
import 'package:grocery_app/services/utils.dart';
import 'package:grocery_app/views/home/widgets/custom_swiper_widget.dart';
import 'package:grocery_app/views/common_widgets/custom_text_widget.dart';
import 'package:grocery_app/views/home/widgets/on_sale_widget.dart';
import 'package:grocery_app/views/home/our_product_widget.dart';
import 'package:provider/provider.dart';

class HomeViewBody extends StatelessWidget {
  const HomeViewBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Utils utils = Utils(context);
    final themeState = utils.getTheme;
    Size size = utils.getScreenSize;
    final productProviders = Provider.of<ProductsProvider>(context);
    List<ProductModel> allProducts = productProviders.getProducts;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const CustomSwiperWidget(),
            const SizedBox(
              height: 6,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomTextWidget(
                    text: 'View all',
                    maxLines: 1,
                    color: Colors.blue,
                    textSize: 20,
                  ),
                  IconButton(
                      onPressed: () {
                        GlobalMethods.navigateTo(
                            ctx: context, routeName: OnSaleScreen.routeName);
                      },
                      icon: const Icon(Icons.arrow_forward))
                ],
              ),
            ),
            const SizedBox(
              height: 6,
            ),
            const OnSaleWidget(),
            const SizedBox(
              height: 6,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomTextWidget(
                    text: 'Our Products',
                    maxLines: 1,
                    color: Colors.blue,
                    textSize: 20,
                  ),
                  IconButton(
                      onPressed: () {
                        GlobalMethods.navigateTo(
                            ctx: context,
                            routeName: OurProductScreen.routeName);
                      },
                      icon: const Icon(Icons.arrow_forward))
                ],
              ),
            ),
            const SizedBox(
              height: 6,
            ),
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              padding: EdgeInsets.zero,
              // crossAxisSpacing: 10,
              childAspectRatio: size.width / (size.height * 0.61),
              children: List.generate(
                  allProducts.length < 4 ? 4 : allProducts.length, (index) {
                return ChangeNotifierProvider.value(
                  value: allProducts[index],
                    child: OurProductWidget());
              }),
            )
          ],
        ),
      ),
    );
  }
}
