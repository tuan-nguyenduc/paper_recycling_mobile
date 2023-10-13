import 'package:flutter/material.dart';
import 'package:paper_recycling_shopper/constants/global_variables.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = '/home';
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(250),
        child: AppBar(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(10),
            ),
          ),
          backgroundColor: GlobalVariables.bgColor,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.network(DEFAULT_AVATAR_IMG, width: 30),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(5.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Nguyen Duc Tuan",
                          style: TextStyle(fontSize: 13),
                        ),
                        Text(
                          "Phuong hoang van thu",
                          style: TextStyle(fontSize: 13, color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.search_outlined),
              onPressed: () {
                //to search page
              },
            ),
            IconButton(
              icon: const Icon(Icons.shopping_cart_outlined),
              onPressed: () {
                //to cart page
              },
            ),
          ],
          flexibleSpace: Padding(
            padding: const EdgeInsets.only(top: 100, bottom: 20),
            child: 
              Stack(children: [
                Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.network(
                      'https://static.vecteezy.com/system/resources/previews/014/743/745/non_2x/reduce-reuse-recycle-design-banner-background-go-green-banner-earth-day-recycling-day-free-vector.jpg',
                      width: 350,
                      fit: BoxFit.fill,
                      alignment: Alignment.center,
                    ),
                  ),
                ),
                Center(
                  child: Image.asset(
                    "assets/images/home_pattern.png",
                    height: 200,
                    alignment: Alignment.center,
                  ),
                ),
              ]),
           
          ),
        ),
      ),
      body: const Text("This is home page"),
    );
  }
}
