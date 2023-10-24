// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import 'package:paper_recycling_shopper/features/cart/screens/cart_screen.dart';
import 'package:paper_recycling_shopper/features/product/screens/product_detail.dart';
import 'package:paper_recycling_shopper/models/product.dart';
import 'package:paper_recycling_shopper/services/order_services.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final BuildContext context;
  ProductCard({
    Key? key,
    required this.product,
    required this.context,
  }) : super(key: key);

  final orderServices = OrderServices();
  late String orderData;
  void navigateToProductDetailScreen(Product product) {
    // Navigator.pushNamed(context, ProductDetail.routeName, arguments: product);
    PersistentNavBarNavigator.pushNewScreen(context, screen: ProductDetail(product: product), withNavBar: false);

  }

  void addProductToCart() async {
    orderData = await orderServices.createOrder(
        context: context, productId: product.id, quantity: 1)
        .whenComplete(() => PersistentNavBarNavigator.pushNewScreen(context, screen: const CartScreen()));

  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => navigateToProductDetailScreen(product),
      child: Padding(
        padding: const EdgeInsets.only(left: 20, top: 10, bottom: 10),
        child: Stack(
          children: [
            Container(
              width: 180,
              height: 250,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: const Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: Column(children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: SizedBox(
                      height: 120,
                      child: Image.network(product.images!.split(',')[0]),
                    ),
                  ),
                ),
                Text(
                  product.name!,
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
                const SizedBox(
                  height: 4,
                ),
                RatingBar.builder(
                  initialRating: 3,
                  minRating: 1,
                  direction: Axis.horizontal,
                  ignoreGestures: true,
                  itemCount: 5,
                  itemSize: 16,
                  itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                  itemBuilder: (context, _) => const Icon(
                    Icons.star,
                    color: Colors.deepOrange,
                  ),
                  onRatingUpdate: (rating) {
                    //print(rating);
                  },
                ),
                const SizedBox(
                  height: 4,
                ),
                Text(
                  '${product.price} PP',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.favorite_outline_sharp,
                          color: Colors.deepOrange,
                        ),
                      ),
                      IconButton(
                        onPressed: () => addProductToCart(),
                        icon: const Icon(
                          Icons.shopping_cart_rounded,
                          color: Colors.deepOrange,
                        ),
                      ),
                    ],
                  ),
                )
              ]),
            ),
          ],
        ),
      ),
    );
  }
}
