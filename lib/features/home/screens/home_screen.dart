import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:paper_recycling_shopper/constants/global_variables.dart';
import 'package:paper_recycling_shopper/features/home/services/home_services.dart';
import 'package:paper_recycling_shopper/features/home/widgets/home_title.dart';
import 'package:paper_recycling_shopper/features/home/widgets/product_card.dart';
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
  late Future<List<Product>> futureProducts;
  @override
  void initState() {
    super.initState();
    futureProducts =
        homeServices.fetchProducts(context: context, page: 0, limit: 10);
    print(futureProducts);
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
            SizedBox(
              height: 150,
              child: GridView.count(
                crossAxisCount: 2,
                childAspectRatio: 0.4,
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                children: List.generate(6, (index) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 10, left: 10),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Container(
                        // width: 200,
                        // height: 100,
                        color: Colors.grey[300],
                        child: Center(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 5.0),
                                child: Text(
                                  "Category 1",
                                  style: TextStyle(fontSize: 20),
                                ),
                              ),
                              ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.network(
                                      'https://s3-api.4bytes.io/paper-recycling/1692261540650_compa.jpeg',
                                      width: 50)),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ),

            //Latest Products
            HomeTitle(title: 'Latest Products'),
            SizedBox(
              height: 250,
              child: FutureBuilder(
                future: futureProducts,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      itemCount: snapshot.data?.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return ProductCard(
                            name: snapshot.data?[index].name,
                            image:
                                snapshot.data?[index].images,
                            price: snapshot.data?[index].price);
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

            // Best Sellers
            HomeTitle(title: 'Best Sellers'),
            SizedBox(
              height: 250,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  ProductCard(
                      name: "Móc chìa khóa cute",
                      image:
                          'https://s3-api.4bytes.io/paper-recycling/1692240543102_bannacat.png',
                      price: 100),
                  ProductCard(
                      name: "Móc chìa khóa cute",
                      image:
                          'https://s3-api.4bytes.io/paper-recycling/1692240543102_bannacat.png',
                      price: 100),
                  ProductCard(
                      name: "Móc chìa khóa cute",
                      image:
                          'https://s3-api.4bytes.io/paper-recycling/1692240543102_bannacat.png',
                      price: 100),
                  ProductCard(
                      name: "Móc chìa khóa cute",
                      image:
                          'https://s3-api.4bytes.io/paper-recycling/1692240543102_bannacat.png',
                      price: 100),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
