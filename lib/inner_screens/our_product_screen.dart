import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:grocery_app/consts/consts.dart';
import 'package:grocery_app/models/products_model.dart';
import 'package:grocery_app/provider/products_provider.dart';
import 'package:grocery_app/views/common_widgets/back_widget.dart';
import 'package:grocery_app/views/common_widgets/custom_text_widget.dart';
import 'package:grocery_app/views/common_widgets/empty_products_widget.dart';
import 'package:grocery_app/views/home/our_product_widget.dart';
import 'package:provider/provider.dart';

import '../services/utils.dart';

class OurProductScreen extends StatefulWidget {
  static const routeName = "/OurProductScreenState";

  const OurProductScreen({Key? key}) : super(key: key);

  @override
  State<OurProductScreen> createState() => _OurProductScreenState();
}

class _OurProductScreenState extends State<OurProductScreen> {
  final TextEditingController? _searchTextController = TextEditingController();
  final FocusNode _searchTextFocusNode = FocusNode();
  List<ProductModel> listProdcutSearch = [];

  @override
  void dispose() {
    _searchTextController!.dispose();
    _searchTextFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Color color = Utils(context).color;
    Size size = Utils(context).getScreenSize;
    final productProviders = Provider.of<ProductsProvider>(context);
    List<ProductModel> allProducts = productProviders.getProducts;
    return Scaffold(
      appBar: AppBar(
        leading: BackWidget(),
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        centerTitle: true,
        title: CustomTextWidget(
          text: 'All Products',
          color: color,
          textSize: 20.0,
          isTitle: true,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: SizedBox(
              height: kBottomNavigationBarHeight,
              child: TextField(
                focusNode: _searchTextFocusNode,
                controller: _searchTextController,
                onChanged: (valuee) {
                  setState(() {
                    listProdcutSearch = productProviders.searchQuery(valuee);
                  });
                },
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide:
                        const BorderSide(color: Colors.greenAccent, width: 1),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide:
                        const BorderSide(color: Colors.greenAccent, width: 1),
                  ),
                  hintText: "What's in your mind",
                  prefixIcon: const Icon(Icons.search),
                  suffix: IconButton(
                    onPressed: () {
                      _searchTextController!.clear();
                      _searchTextFocusNode.unfocus();
                    },
                    icon: Icon(
                      Icons.close,
                      color: _searchTextFocusNode.hasFocus ? Colors.red : color,
                    ),
                  ),
                ),
              ),
            ),
          ),
          _searchTextController!.text.isNotEmpty && listProdcutSearch.isEmpty
              ? const EmptyProdWidget(
                  text: 'No products found, please try another keyword')
              : GridView.count(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: 2,
                  padding: EdgeInsets.zero,
                  // crossAxisSpacing: 10,
                  childAspectRatio: size.width / (size.height * 0.59),
                  children: List.generate(
                      _searchTextController!.text.isNotEmpty
                          ? listProdcutSearch.length
                          : allProducts.length, (index) {
                    return ChangeNotifierProvider.value(
                        value: _searchTextController!.text.isNotEmpty
                            ? listProdcutSearch[index]
                            : allProducts[index],
                        child: OurProductWidget());
                  }),
                ),
        ]),
      ),
    );
  }
}
