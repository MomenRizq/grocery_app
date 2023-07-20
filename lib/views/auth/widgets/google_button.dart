import 'package:flutter/material.dart';
import 'package:grocery_app/views/common_widgets/custom_text_widget.dart';

class GoogleButton extends StatelessWidget {
  const GoogleButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      child: Material(
        color: Colors.blue,
        child: InkWell(
          onTap: () {},
          child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
            Container(
              color: Colors.white,
              child: Image.asset(
                'assets/images/google.png',
                width: 40.0,
                height: 50,
              ),
            ),
            const SizedBox(
              width: 8,
            ),
            CustomTextWidget(
                text: 'Sign in with google', color: Colors.white, textSize: 18)
          ]),
        ),
      ),
    );
  }
}
