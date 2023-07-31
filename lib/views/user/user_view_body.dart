import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:grocery_app/consts/firebase_consts.dart';
import 'package:grocery_app/provider/cart_provider.dart';
import 'package:grocery_app/provider/dark_theme_provider.dart';
import 'package:grocery_app/provider/orders_provider.dart';
import 'package:grocery_app/provider/wishlist_provider.dart';
import 'package:grocery_app/services/global_methods.dart';
import 'package:grocery_app/views/auth/forget_pass.dart';
import 'package:grocery_app/views/auth/login.dart';
import 'package:grocery_app/views/loading_manager.dart';
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
  final User? user = KauthInstance.currentUser;
  String _email ="Email";
  String _name = "Name";
  String? address;
  bool _isLoading = false;

  @override
  void initState() {
    getUserData();
    super.initState();
  }

  Future<void> getUserData() async {
    setState(() {
      _isLoading = true;
    });
    if (user == null) {
      setState(() {
        _isLoading = false;
      });
      return;
    }
    try {
      String _uid = user!.uid;

      final DocumentSnapshot userDoc =
      await FirebaseFirestore.instance.collection('users').doc(_uid).get();
      if (userDoc == null) {
        return;
      } else {
        _email =userDoc.data().toString().contains('email') ? userDoc.get('email'):"";
        _name = userDoc.data().toString().contains('name') ? userDoc.get('name'):"";
        address =userDoc.data().toString().contains('shipping-address') ? userDoc.get('shipping-address'):"";
        _addressTextController.text =userDoc.data().toString().contains('shipping-address') ?  userDoc.get('shipping-address'):"";
      }
    } catch (error) {
      setState(() {
        _isLoading = false;
      });
      GlobalMethods.errorDialog(subtitle: '$error', context: context);
      print(_email);
      print(_name);
      print(_addressTextController.text);
      print(address);
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeState = Provider.of<DarkThemeProvider>(context);
    final Color color = themeState.getDarkTheme ? Colors.white : Colors.black87;
    final wishlistProvider = Provider.of<WishlistProvider>(context);
    final cartProvider = Provider.of<CartProvider>(context);
    final orderProvider = Provider.of<OrdersProvider>(context);
    return LoadingManager(
      isLoading: _isLoading,
      child: Center(
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
                CustomUserInfo(
                  name: _isLoading ?"User" : _name,
                  email: _isLoading ?"Email" :_email,
                  color: color,
                ),
                const Divider(
                  thickness: 2,
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomListTilesSubTitle(
                  title: 'Address',
                  subtitle: address,
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
                        ctx: context,
                        routeName: ViewedRecentlyScreen.routeName);
                  },
                  color: color,
                ),
                CustomListTiles(
                  title: 'Forget password',
                  icon: IconlyLight.unlock,
                  onPressed: () {
                    GlobalMethods.navigateTo(
                        ctx: context,
                        routeName: ForgetPasswordScreen.routeName);
                  },
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
                  title: user == null ? 'Login' : 'Logout',
                  icon: user == null ? IconlyLight.login : IconlyLight.logout,
                  onPressed: () {
                    if (user == null) {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const LoginScreen(),
                        ),
                      );
                      return;
                    }
                    GlobalMethods.warningDialog(
                        title: 'Sign out',
                        subtitle: 'Do you wanna sign out?',
                        fct: () async {
                          await KauthInstance.signOut();
                          wishlistProvider.clearLocalWishlist();
                          cartProvider.clearLocalCart();
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const LoginScreen(),
                            ),
                          );
                        },
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
                onPressed: () async {
                  String _uid = user!.uid;
                  try {
                    await FirebaseFirestore.instance
                        .collection('users')
                        .doc(_uid)
                        .update({
                      'shipping-address': _addressTextController.text,
                    });
                    Navigator.pop(context);
                    setState(() {
                      address = _addressTextController.text;
                    });
                  } catch (err) {
                    GlobalMethods.errorDialog(
                        subtitle: err.toString(), context: context);
                  }
                },
                child: const Text('Update'),
              ),
            ],
          );
        });
  }
}
