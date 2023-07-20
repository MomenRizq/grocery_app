import 'package:flutter/material.dart';
import 'package:grocery_app/inner_screens/on_sale_screen.dart';
import 'package:grocery_app/inner_screens/our_product_screen.dart';
import 'package:grocery_app/services/global_methods.dart';
import 'package:grocery_app/services/utils.dart';
import 'package:grocery_app/views/home/widgets/custom_swiper_widget.dart';
import 'package:grocery_app/views/common_widgets/custom_text_widget.dart';
import 'package:grocery_app/views/home/widgets/on_sale_widget.dart';
import 'package:grocery_app/views/home/our_product_item.dart';
class HomeViewBody extends StatelessWidget {
  const HomeViewBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Utils utils = Utils(context);
    final themeState = utils.getTheme;
    Size size = utils.getScreenSize;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            CustomSwiperWidget(),
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
                  IconButton(onPressed: (){
                    GlobalMethods.navigateTo(
                        ctx: context, routeName: OnSaleScreen.routeName);
                  }, icon:Icon(Icons.arrow_forward) )
                ],
              ),
            ),
            const SizedBox(
              height: 6,
            ),
            OnSaleWidget(),
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
                  IconButton(onPressed: (){
                    GlobalMethods.navigateTo(ctx: context, routeName: OurProductScreen.routeName);
                  }, icon:Icon(Icons.arrow_forward) )
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
              children: List.generate((4) ,(index) {
                return OurProductItem();
              }
              ),
            )
          ],
        ),
      ),
    );
  }
}
