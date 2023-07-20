import 'package:card_swiper/card_swiper.dart';

import 'package:flutter/material.dart';
import 'package:grocery_app/consts/consts.dart';
import 'package:grocery_app/views/auth/register_body.dart';
import '../../services/utils.dart';

class RegisterScreen extends StatelessWidget {
  static const routeName = '/RegisterScreen';
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Utils(context).getTheme;
    Color color = Utils(context).color;

    return Scaffold(
      body: Stack(
        children: <Widget>[
          Swiper(
            duration: 800,
            autoplayDelay: 6000,

            itemBuilder: (BuildContext context, int index) {
              return Image.asset(
                Consts.authImagesPaths[index],
                fit: BoxFit.cover,
              );
            },
            autoplay: true,
            itemCount: Consts.authImagesPaths.length,

            // control: const SwiperControl(),
          ),
          Container(
            color: Colors.black.withOpacity(0.7),
          ),
          const RegisterBody(),
        ],
      ),
    );
  }
}
