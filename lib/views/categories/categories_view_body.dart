import 'package:flutter/material.dart';
import 'package:grocery_app/consts/Item_const.dart';
import 'package:grocery_app/services/utils.dart';
import 'package:grocery_app/views/categories/custom_categories_item.dart';
import 'package:grocery_app/views/common_widgets/custom_text_widget.dart';

class CategoriesViewBody extends StatelessWidget {
  const CategoriesViewBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final utils = Utils(context);
    Color color = utils.color;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: CustomTextWidget(
          text: 'Categories',
          color: color,
          textSize: 24,
          isTitle: true,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.count(
          crossAxisCount: 2,
          childAspectRatio: 240 / 250,
          crossAxisSpacing: 15, // Vertical spacing
          mainAxisSpacing: 15, // Horizontal spacing
          children: List.generate(6, (index) {
            return CustomCategoriesItem(
              catText: catInfo[index]['catText'],
              imgPath: catInfo[index]['imgPath'],
              passedColor: gridColors[index],
            );
          }),
        ),
      ),
    );
  }
}
