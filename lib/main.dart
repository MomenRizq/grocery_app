import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:grocery_app/inner_screens/cat_screen.dart';
import 'package:grocery_app/inner_screens/on_sale_screen.dart';
import 'package:grocery_app/inner_screens/our_product_screen.dart';
import 'package:grocery_app/provider/cart_provider.dart';
import 'package:grocery_app/provider/dark_theme_provider.dart';
import 'package:grocery_app/provider/products_provider.dart';
import 'package:grocery_app/provider/viewed_prod_provider.dart';
import 'package:grocery_app/views/auth/forget_pass.dart';
import 'package:grocery_app/views/auth/login.dart';
import 'package:grocery_app/views/auth/register.dart';
import 'package:grocery_app/views/bottom_bar_view.dart';
import 'package:grocery_app/inner_screens/product_details/product_details_view.dart';
import 'package:grocery_app/views/home/home_view.dart';
import 'package:grocery_app/views/orders/orders_screen.dart';
import 'package:grocery_app/views/viewed_recently/viewed_recently.dart';
import 'package:grocery_app/views/wishlist/wishlist_screen.dart';
import 'package:provider/provider.dart';

import 'consts/theme_data.dart';
import 'provider/wishlist_provider.dart';

void main()async {

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  DarkThemeProvider themeChangeProvider = DarkThemeProvider();

  void getCurrentAppTheme() async {
    themeChangeProvider.setDarkTheme =
        await themeChangeProvider.darkThemePrefs.getTheme();
  }

  @override
  void initState() {
    getCurrentAppTheme();
    super.initState();
  }

  final Future<FirebaseApp> _firebaseInitialization = Firebase.initializeApp();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _firebaseInitialization,
      builder: (context,snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const MaterialApp(
            home: Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                )),
          );
        } else if (snapshot.hasError) {
          const MaterialApp(
            home: Scaffold(
                body: Center(
                  child: Text('An error occured'),
                )),
          );
        }
        return MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (context) {
              return themeChangeProvider;
            }),
            ChangeNotifierProvider(create: (context) => ProductsProvider()),
            ChangeNotifierProvider(create: (context) => CartProvider()),
            ChangeNotifierProvider(create: (context) => WishlistProvider()),
            ChangeNotifierProvider(create: (context) => ViewedProdProvider()),

          ],
          child:
              Consumer<DarkThemeProvider>(builder: (context, themeProvider, child) {
            return MaterialApp(
                debugShowCheckedModeBanner: false,
                title: 'Flutter Demo',
                theme: Styles.themeData(themeProvider.getDarkTheme, context),
                home: const LoginScreen(),
                routes: {
                  OnSaleScreen.routeName: (context) => const OnSaleScreen(),
                  OurProductScreen.routeName: (context) => const OurProductScreen(),
                  ProductDetailsView.routeName: (context) =>
                      const ProductDetailsView(),
                  WishlistScreen.routeName: (ctx) => const WishlistScreen(),
                  OrdersScreen.routeName: (ctx) => const OrdersScreen(),
                  ViewedRecentlyScreen.routeName: (ctx) =>
                      const ViewedRecentlyScreen(),
                  RegisterScreen.routeName: (ctx) => const RegisterScreen(),
                  LoginScreen.routeName: (ctx) => const LoginScreen(),
                  ForgetPasswordScreen.routeName: (ctx) =>
                      const ForgetPasswordScreen(),
                  CategoryScreen.routeName:(ctx)=> const CategoryScreen()
                });
          }),
        );
      }
    );
  }
}
