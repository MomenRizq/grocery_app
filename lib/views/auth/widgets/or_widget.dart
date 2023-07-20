import 'package:flutter/material.dart';
import 'package:grocery_app/views/common_widgets/custom_text_widget.dart';

class OrWidget extends StatelessWidget {
  const OrWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(
          child: Divider(
            color: Colors.white,
            thickness: 2,
          ),
        ),
        const SizedBox(
          width: 5,
        ),
        CustomTextWidget(
          text: 'OR',
          color: Colors.white,
          textSize: 18,
        ),
        const SizedBox(
          width: 5,
        ),
        const Expanded(
          child: Divider(
            color: Colors.white,
            thickness: 2,
          ),
        ),
      ],
    );
  }
}
