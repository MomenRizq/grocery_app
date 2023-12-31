import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:grocery_app/consts/Item_const.dart';
import 'package:grocery_app/services/utils.dart';

class CustomSwiperWidget extends StatelessWidget {
  const CustomSwiperWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Utils utils = Utils(context);
    Size size = utils.getScreenSize;
    return SizedBox(
      height: size.height * 0.33,
      child: Swiper(
        itemBuilder: (BuildContext context, int index) {
          return Card(
            margin: new EdgeInsets.only(bottom: 30),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25.0),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(25),
              child: Image.asset(
                offerImages[index],
                fit: BoxFit.fill,
              ),
            ),
          );
        },
        autoplay: true,
        viewportFraction: 0.9,
        scale: 0.95,
        itemCount: offerImages.length,
        pagination: const SwiperPagination(
            alignment: Alignment.bottomCenter,
            builder: DotSwiperPaginationBuilder(
                color: Colors.grey, activeColor: Colors.red)),
        // control: const SwiperControl(color: Colors.black),
      ),
    );
  }
}
