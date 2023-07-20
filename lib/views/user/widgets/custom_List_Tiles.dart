

import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';

import '../../common_widgets/custom_text_widget.dart';

class CustomListTiles extends StatelessWidget {
  const CustomListTiles({Key? key,required this.title, this.subtitle = "", required this.icon, required this.onPressed, required this.color}) : super(key: key);
  final String title;
  final String? subtitle ;
  final IconData icon;
  final Function onPressed;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: CustomTextWidget(
        text: title ,
        color: color,
        textSize:20,
        isTitle: true,
        // isTitle: true,
      ),
     /* subtitle: CustomTextWidget(
        text: subtitle.toString(),
        color: color,
        textSize: 18,
      ),*/
      leading: Icon(icon),
      trailing: const Icon(IconlyLight.arrowRight2),
      onTap: () {
        onPressed();
      },
    );
  }
}

class CustomListTilesSubTitle extends StatelessWidget {
  const CustomListTilesSubTitle ({Key? key,required this.title, this.subtitle = "", required this.icon, required this.onPressed, required this.color}) : super(key: key);
  final String title;
  final String? subtitle ;
  final IconData icon;
  final Function onPressed;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: CustomTextWidget(
        text: title,
        color: color,
        textSize: 20,
        isTitle: true,
      ),
      subtitle: CustomTextWidget(
        text: subtitle.toString(),
        color: color,
        textSize: 15,
      ),
      leading: Icon(icon),
      trailing: const Icon(IconlyLight.arrowRight2),
      onTap: () {
        onPressed();
      },
    );
  }
}
