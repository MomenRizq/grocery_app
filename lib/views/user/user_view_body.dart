import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:grocery_app/provider/dark_theme_provider.dart';
import 'package:grocery_app/services/global_methods.dart';
import 'package:grocery_app/views/orders/orders_screen.dart';
import 'package:grocery_app/views/user/widgets/custom_List_Tiles.dart';
import 'package:grocery_app/views/common_widgets/custom_text_widget.dart';
import 'package:grocery_app/views/user/widgets/custom_user_info.dart';
import 'package:grocery_app/views/viewed_recently/viewed_recently.dart';
import 'package:grocery_app/views/wishlist/wishlist_screen.dart';

import 'package:provider/provider.dart';

class UserViewBody extends StatefulWidget {
  const UserViewBody({Key? key}) : super(key: key);

  @override
  State<UserViewBody> createState() => _UserViewBodyState();
}

class _UserViewBodyState extends State<UserViewBody> {
  final TextEditingController _addressTextController =
  TextEditingController(text: "");
  @override
  Widget build(BuildContext context) {
    final themeState = Provider.of<DarkThemeProvider>(context);
    final Color color = themeState.getDarkTheme ? Colors.white : Colors.black87;
    return Center(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 15,
              ),
              CustomUserInfo(name:'Momen',email:'momenrizq20@gmail.com' , color: color,),
              const Divider(
                thickness: 2,
              ),
              const SizedBox(
                height: 20,
              ),
              CustomListTilesSubTitle(
                title: 'Address 2',
                subtitle: 'My subtitle',
                icon: IconlyLight.profile,
                onPressed: () async {
                  await _showAddressDialog();
                },
                color: color,
              ),
              CustomListTiles(
                title: 'Orders',
                icon: IconlyLight.bag,
                onPressed: () {
                  GlobalMethods.navigateTo(
                      ctx: context, routeName: OrdersScreen.routeName);
                },
                color: color,
              ),
              CustomListTiles(
                title: 'Wishlist',
                icon: IconlyLight.heart,
                onPressed: () {
                  GlobalMethods.navigateTo(
                      ctx: context, routeName: WishlistScreen.routeName);
                },
                color: color,
              ),
              CustomListTiles(
                title: 'Viewed',
                icon: IconlyLight.show,
                onPressed: () {
                  GlobalMethods.navigateTo(
                      ctx: context, routeName: ViewedRecentlyScreen.routeName);
                },
                color: color,
              ),
              CustomListTiles(
                title: 'Forget password',
                icon: IconlyLight.unlock,
                onPressed: () {},
                color: color,
              ),
              SwitchListTile(
                title: CustomTextWidget(
                  text: themeState.getDarkTheme ? 'Dark mode' : 'Light mode',
                  color: color,
                  textSize: 22,
                  isTitle: true,
                ),
                secondary: Icon(themeState.getDarkTheme
                    ? Icons.dark_mode_outlined
                    : Icons.light_mode_outlined),
                onChanged: (bool value) {
                  setState(() {
                    themeState.setDarkTheme = value;
                  });
                },
                value: themeState.getDarkTheme,
              ),
              CustomListTiles(
                title: 'Logout',
                icon: IconlyLight.logout,
                onPressed: () {
                  GlobalMethods.warningDialog(
                      title: 'Logout',
                      subtitle: 'Are you sure?',
                      fct: () {},
                      context: context);
                },
                color: color,
              ),
              CustomListTilesSubTitle(
                title: 'Title',
                subtitle: 'Subtitle',
                icon: Icons.settings,
                onPressed: () {},
                color: color,
              ),
            ],
          ),
        ),
      ),
    );
  }
  Future<void> _showAddressDialog() async {
    await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Update'),
            content: TextField(
              // onChanged: (value) {
              //   print('_addressTextController.text ${_addressTextController.text}');
              // },
              controller: _addressTextController,
              maxLines: 5,
              decoration: const InputDecoration(hintText: "Your address"),
            ),
            actions: [
              TextButton(
                onPressed: () {},
                child: const Text('Update'),
              ),
            ],
          );
        });
  }
}
