import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:paper_recycling_shopper/constants/global_variables.dart';
import 'package:paper_recycling_shopper/features/home/services/home_services.dart';
import 'package:paper_recycling_shopper/features/home/widgets/category_card.dart';
import 'package:paper_recycling_shopper/features/home/widgets/home_title.dart';
import 'package:paper_recycling_shopper/features/home/widgets/product_card.dart';
import 'package:paper_recycling_shopper/features/product/screens/product_detail.dart';
import 'package:paper_recycling_shopper/models/category.dart';
import 'package:paper_recycling_shopper/models/product.dart';
import 'package:paper_recycling_shopper/providers/user_provider.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = '/home';
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final HomeServices homeServices = HomeServices();
  late Future<List<Product>> latestProducts;
  late Future<List<Product>> bestSellerProducts;
  late Future<List<Category>> categories;

  @override
  void initState() {
    super.initState();
    latestProducts = homeServices.fetchProducts(
      context: context,
      page: 0,
      limit: 10,
      sortBy: 'createdAt',
      sortDirection: 'ASC',
    );
    bestSellerProducts = homeServices.fetchProducts(
        context: context,
        page: 0,
        limit: 10,
        sortBy: 'quantity',
        sortDirection: 'ASC');

    categories = homeServices.fetchCategories(context: context);
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;

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
                    child: user.avatar == null
                        ? Image.network(
                            DEFAULT_AVATAR_IMG,
                            width: 30,
                          )
                        : Image.network(user.avatar!, width: 30),
                  ),
                  Padding(
                    padding: EdgeInsets.all(5.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          user.name,
                          style: TextStyle(fontSize: 13),
                        ),
                        Text(
                          user.email,
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
            child: Stack(children: [
              Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.network(
                    'https://static.vecteezy.com/system/resources/previews/014/743/745/non_2x/reduce-reuse-recycle-design-banner-background-go-green-banner-earth-day-recycling-day-free-vector.jpg',
                    width: 380,
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            const HomeTitle(
              title: 'Categories',
              icon: Icon(
                Icons.category_sharp,
                size: 28,
                color: Colors.deepOrange,
              ),
            ),
            SizedBox(
              height: 150,
              child: FutureBuilder(
                future: categories,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.4,
                      ),
                      scrollDirection: Axis.horizontal,
                      itemCount: snapshot.data?.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return CategoryCard(
                          image: snapshot.data?[index].image,
                          name: snapshot.data?[index].name,
                        );
                      },
                    );
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
            ),

            //Latest Products
            const HomeTitle(
              title: 'Latest Products',
              icon: Icon(
                Icons.flash_on,
                size: 30,
                color: Colors.deepOrange,
              ),
            ),
            SizedBox(
              height: 250,
              child: FutureBuilder(
                future: latestProducts,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      itemCount: snapshot.data?.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return ProductCard(
                            context: context,
                            product: snapshot.data![index],
                            );
                      },
                    );
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
            ),

            // Best Sellers
            const HomeTitle(
              title: 'Best Sellers',
              icon: Icon(
                Icons.sell,
                size: 28,
                color: Colors.deepOrange,
              ),
            ),
            SizedBox(
              height: 250,
              child: FutureBuilder(
                future: bestSellerProducts,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      itemCount: snapshot.data?.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return ProductCard(
                          context: context,
                          product: snapshot.data![index],
                        );
                      },
                    );
                  } else {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
