import 'package:flutter/material.dart';
import 'package:grocery_app/views/common_widgets/custom_text_widget.dart';

import 'package:provider/provider.dart';

import '../../provider/dark_theme_provider.dart';


class CustomCategoriesItem extends StatelessWidget {
  const CustomCategoriesItem({Key? key, required this.catText, required this.imgPath, required this.passedColor}) : super(key: key);

  final String catText, imgPath;
  final Color passedColor;

  @override
  Widget build(BuildContext context) {
    final themeState = Provider.of<DarkThemeProvider>(context);
    double _screenWidth = MediaQuery.of(context).size.width;
    final Color color = themeState.getDarkTheme ? Colors.white : Colors.black;
    return InkWell(
      onTap: () {
        print('Category pressed');
      },
      child: Container(
        height: _screenWidth * 0.6,
        decoration: BoxDecoration(
          color: Colors.red.withOpacity(0.1),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: passedColor.withOpacity(0.7),
            width: 2,
          ),
        ),
        child: Column(children: [
          // Container for the image
          Container(
            height: _screenWidth * 0.3,
            width: _screenWidth * 0.3,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(
                      imgPath,
                    ),
                    fit: BoxFit.fill),
              ),
          ),
          // Category name
          CustomTextWidget(
            text: catText,
            color: color,
            textSize: 20,
            isTitle: true,
          ),
        ]),
      ),
    );
  }
}
