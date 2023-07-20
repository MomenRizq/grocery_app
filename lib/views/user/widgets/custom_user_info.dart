import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:grocery_app/views/common_widgets/custom_text_widget.dart';

class CustomUserInfo extends StatelessWidget {
  const CustomUserInfo({Key? key, required this.name, required this.email, required this.color}) : super(key: key);
  final String name ;
  final String email;
  final Color color;


  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        RichText(
          text: TextSpan(
            text: 'Hi,  ',
            style: const TextStyle(
              color: Colors.cyan,
              fontSize: 27,
              fontWeight: FontWeight.bold,
            ),
            children: <TextSpan>[
              TextSpan(
                  text: name,
                  style: TextStyle(
                    color: color,
                    fontSize: 25,
                    fontWeight: FontWeight.w600,
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      print('My name is pressed');
                    }),
            ],
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        CustomTextWidget(
          text: email,
          color: color,
          textSize: 18,
          // isTitle: true,
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }


}
