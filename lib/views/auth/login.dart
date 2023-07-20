import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:grocery_app/consts/consts.dart';
import 'package:grocery_app/services/global_methods.dart';
import 'package:grocery_app/views/auth/login_body.dart';
import 'package:grocery_app/views/auth/register.dart';
import 'package:grocery_app/views/auth/widgets/auth_button.dart';
import 'package:grocery_app/views/auth/widgets/google_button.dart';
import 'package:grocery_app/views/common_widgets/custom_text_widget.dart';


class LoginScreen extends StatelessWidget {
  static const routeName = '/LoginScreen';
  const LoginScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Swiper(
          duration: 800,
          autoplayDelay: 8000,
          itemBuilder: (BuildContext context, int index) {
            return Image.asset(
              Consts.authImagesPaths[index],
              fit: BoxFit.cover,
            );
          },
          autoplay: true,
          itemCount: Consts.authImagesPaths.length,
        ),
        Container(
          color: Colors.black.withOpacity(0.7),
        ),
        const LoginBody(),
      ]),
    );
  }
}
