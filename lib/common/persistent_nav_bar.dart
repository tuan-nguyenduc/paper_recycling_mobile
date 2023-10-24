import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:paper_recycling_shopper/constants/global_variables.dart';
import 'package:paper_recycling_shopper/features/account/screens/account_screen.dart';
import 'package:paper_recycling_shopper/features/cart/screens/cart_screen.dart';
import 'package:paper_recycling_shopper/features/home/screens/home_screen.dart';
import 'package:paper_recycling_shopper/features/order/screens/order_screen.dart';
import 'package:paper_recycling_shopper/providers/cart_quantity.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:badges/badges.dart' as badges;
import 'package:provider/provider.dart';

class PersistentBottomBar extends StatefulWidget {
  static const String routeName = '/persistent-nav';

  const PersistentBottomBar({super.key});

  @override
  State<PersistentBottomBar> createState() => _PersistentBottomBarState();
}

class _PersistentBottomBarState extends State<PersistentBottomBar> {
  late PersistentTabController _controller;
  @override
  void initState() {
    super.initState();
    _controller = PersistentTabController();
  }

  List<Widget> _buildScreens() => [
        const HomeScreen(),
        const CartScreen(),
        const OrderScreen(),
        const AccountScreen(),
      ];

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: const Icon(CupertinoIcons.home),
        title: ("Home"),
        activeColorPrimary: GlobalVariables.primaryColor.withOpacity(1),
        inactiveColorPrimary: Colors.black,
      ),
      PersistentBottomNavBarItem(
        icon: badges.Badge(
            badgeAnimation: const badges.BadgeAnimation.rotation(
              animationDuration: Duration(seconds: 1),
              colorChangeAnimationDuration: Duration(seconds: 1),
              loopAnimation: false,
              curve: Curves.fastOutSlowIn,
              colorChangeAnimationCurve: Curves.easeInCubic,
            ),
            badgeContent: Text(
              context.watch<CartQuantity>().quantity.toString(),
              style: const TextStyle(color: Colors.white),
            ),
            child: const Icon(CupertinoIcons.cart)),
        title: ("Cart"),
        activeColorPrimary: GlobalVariables.primaryColor.withOpacity(1),
        inactiveColorPrimary: Colors.black,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(CupertinoIcons.doc_text),
        title: ("Order"),
        activeColorPrimary: GlobalVariables.primaryColor.withOpacity(1),
        inactiveColorPrimary: Colors.black,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(CupertinoIcons.person),
        title: ("Account"),
        activeColorPrimary: GlobalVariables.primaryColor.withOpacity(1),
        inactiveColorPrimary: Colors.black,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      controller: _controller,
      screens: _buildScreens(),
      items: _navBarsItems(),
      confineInSafeArea: true,

      backgroundColor: Colors.grey.shade100, // Default is Colors.white.
      handleAndroidBackButtonPress: true, // Default is true.
      resizeToAvoidBottomInset:
          true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
      stateManagement: false, // Default is true.
      hideNavigationBarWhenKeyboardShows:
          true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
      decoration: NavBarDecoration(
        borderRadius: BorderRadius.circular(10.0),
        colorBehindNavBar: Colors.white,
      ),
      popAllScreensOnTapOfSelectedTab: true,
      popActionScreens: PopActionScreensType.all,
      itemAnimationProperties: const ItemAnimationProperties(
        // Navigation Bar's items animation properties.
        duration: Duration(milliseconds: 200),
        curve: Curves.ease,
      ),
      screenTransitionAnimation: const ScreenTransitionAnimation(
        // Screen transition animation on change of selected tab.
        animateTabTransition: true,
        curve: Curves.ease,
        duration: Duration(milliseconds: 200),
      ),
      navBarStyle:
          NavBarStyle.style3, // Choose the nav bar style with this property.
    );
  }
}
