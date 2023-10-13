import 'package:flutter/material.dart';
import 'package:paper_recycling_shopper/constants/global_variables.dart';
import 'package:paper_recycling_shopper/features/account/screens/account_screen.dart';
import 'package:paper_recycling_shopper/features/cart/screens/cart_screen.dart';
import 'package:paper_recycling_shopper/features/home/screens/home_screen.dart';
import 'package:paper_recycling_shopper/features/order/screens/order_screen.dart';

class BottomBar extends StatefulWidget {
  static const String routeName = '/actual-home';
  const BottomBar({super.key});

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int _page = 0;
  double bottomBarWidth = 42;
  double bottomBarBorderWidth = 5;

    List<Widget> pages = [
    const HomeScreen(),
    const CartScreen(),
    const OrderScreen(),
    const AccountScreen(),
    
  ];

  void updatePage(int page) {
    setState(() {
      _page = page;
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_page],
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: _page,
          selectedItemColor: GlobalVariables.primaryColor,
          unselectedItemColor: GlobalVariables.bgColor,
          backgroundColor: GlobalVariables.backgroundColor,
          iconSize: 28,
          onTap: updatePage,
          items: [
            BottomNavigationBarItem(
              icon: Container(
                width: bottomBarWidth,
                decoration: BoxDecoration(
                    border: Border(
                        top: BorderSide(
                            color: _page == 0
                                ? GlobalVariables.primaryColor
                                : GlobalVariables.bgColor,
                            width: bottomBarBorderWidth))),
                child: const Icon(Icons.home_outlined),
              ),
              label: '',
            ),

            //Cart
            BottomNavigationBarItem(
              icon: Container(
                width: bottomBarWidth,
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(
                      color: _page == 1
                          ? GlobalVariables.primaryColor
                          : GlobalVariables.backgroundColor,
                      width: bottomBarBorderWidth,
                    ),
                  ),
                ),
                child: const Icon(
                  Icons.shopping_cart_outlined,
                ),
              ),
              label: '',
            ),

            // ORDER
            BottomNavigationBarItem(
              icon: Container(
                width: bottomBarWidth,
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(
                      color: _page == 2
                          ? GlobalVariables.primaryColor
                          : GlobalVariables.backgroundColor,
                      width: bottomBarBorderWidth,
                    ),
                  ),
                ),
                child: const Icon(
                  Icons.description_outlined,
                ),
              ),
              label: '',
            ),

            // ACCOUNT
            BottomNavigationBarItem(
              icon: Container(
                width: bottomBarWidth,
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(
                      color: _page == 3
                          ? GlobalVariables.primaryColor
                          : GlobalVariables.backgroundColor,
                      width: bottomBarBorderWidth,
                    ),
                  ),
                ),
                child: const Icon(
                  Icons.person_outline_outlined,
                ),
              ),
              label: '',
            ),
          ]),
    );
  }
}
