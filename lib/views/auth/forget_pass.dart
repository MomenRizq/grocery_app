import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:grocery_app/consts/consts.dart';
import 'package:grocery_app/services/utils.dart';
import 'package:grocery_app/views/auth/widgets/auth_button.dart';
import 'package:grocery_app/views/auth/widgets/custom_text_field.dart';
import 'package:grocery_app/views/common_widgets/back_widget.dart';
import 'package:grocery_app/views/common_widgets/custom_text_widget.dart';

class ForgetPasswordScreen extends StatefulWidget {
  static const routeName = '/ForgetPasswordScreen';
  const ForgetPasswordScreen({Key? key}) : super(key: key);

  @override
  _ForgetPasswordScreenState createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  String? email ;

  // bool _isLoading = false;
  @override

  void _forgetPassFCT() async {}

  @override
  Widget build(BuildContext context) {
    Size size = Utils(context).getScreenSize;
    return Scaffold(
      // backgroundColor: Colors.blue,
      body: Stack(
        children: [
          Swiper(
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
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: size.height * 0.1,
                ),
                const BackWidget(),
                const SizedBox(
                  height: 20,
                ),
                CustomTextWidget(
                  text: 'Forget password',
                  color: Colors.white,
                  textSize: 30,
                ),
                const SizedBox(
                  height: 30,
                ),
                CustomTextWidget(
                  text: 'Welcome Back',
                  color: Colors.white,
                  textSize: 30,
                  isTitle: true,
                ),
                customFormTextField(
                  lableText: "Email",
                  hintText: "Enter your email",
                  emptyText:
                  "Email is empty ,write your email , please.",
                  onchanged: (data) {
                    email = data;
                  },),
                const SizedBox(
                  height: 15,
                ),
                AuthButton(
                  buttonText: 'Reset now',
                  fct: () {
                    _forgetPassFCT();
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
