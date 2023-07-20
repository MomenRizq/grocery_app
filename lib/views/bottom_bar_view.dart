import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:grocery_app/views/cart/cart_view.dart';
import 'package:grocery_app/views/categories/categories_view.dart';
import 'package:grocery_app/views/common_widgets/custom_text_widget.dart';
import 'package:grocery_app/views/home/home_view.dart';
import 'package:grocery_app/views/user/user_view.dart';
import 'package:provider/provider.dart';
import 'package:badges/badges.dart' as badge;
import '../provider/dark_theme_provider.dart';

class BottomBarView extends StatefulWidget {
  const BottomBarView({Key? key}) : super(key: key);

  @override
  State<BottomBarView> createState() => _BottomBarViewState();
}

class _BottomBarViewState extends State<BottomBarView> {
  int _selectedIndex = 0;
  final List<Map<String, dynamic>> _pages = [
    {'page': const HomeView(), 'title': 'Home Screen'},
    {'page': const CategoriesView(), 'title': 'Categories Screen'},
    {'page': const CartView(), 'title': 'Cart Screen'},
    {'page': const UserView(), 'title': 'user Screen'},
  ];
  void _selectedPage(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeState = Provider.of<DarkThemeProvider>(context);
    bool _isDark = themeState.getDarkTheme;
    return Scaffold(
      /*appBar: AppBar(
        title: Text( _pages[_selectedIndex]['title']),
       ),*/
      body: _pages[_selectedIndex]['page'],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: _isDark ? Theme.of(context).cardColor : Colors.white,
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        currentIndex: _selectedIndex,
        unselectedItemColor: _isDark ? Colors.white10 : Colors.black12,
        selectedItemColor: _isDark ? Colors.lightBlue.shade200 : Colors.black87,
        onTap: _selectedPage,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon:
                Icon(_selectedIndex == 0 ? IconlyBold.home : IconlyLight.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(_selectedIndex == 1
                ? IconlyBold.category
                : IconlyLight.category),
            label: "Categories",
          ),
          BottomNavigationBarItem(
            icon: badge.Badge(
              badgeAnimation: const badge.BadgeAnimation.slide(),
              badgeStyle: badge.BadgeStyle(
                shape: badge.BadgeShape.circle,
                badgeColor: Colors.blue,
                borderRadius: BorderRadius.circular(8),
              ),
              position: badge.BadgePosition.topEnd(top: -7, end: -7),
              badgeContent: const FittedBox(
                  child: Text(
                    "2",
                    style: TextStyle(color: Colors.white , fontSize: 13),
                  )),
              child: Icon(
                  _selectedIndex == 2 ? IconlyBold.buy : IconlyLight.buy),
            ),
            label: "Cart",
          ),
          BottomNavigationBarItem(
            icon: Icon(
                _selectedIndex == 3 ? IconlyBold.user2 : IconlyLight.user2),
            label: "User",
          ),
        ],
      ),
    );
  }
}
