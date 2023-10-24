// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:paper_recycling_shopper/common/custom_appbar.dart';
import 'package:paper_recycling_shopper/features/cart/screens/cart_screen.dart';
import 'package:paper_recycling_shopper/features/home/services/home_services.dart';
import 'package:paper_recycling_shopper/features/home/widgets/product_card.dart';
import 'package:paper_recycling_shopper/features/product/widget/review_card.dart';
import 'package:paper_recycling_shopper/models/product.dart';
import 'package:paper_recycling_shopper/models/review.dart';
import 'package:paper_recycling_shopper/services/order_services.dart';
import 'package:paper_recycling_shopper/services/review_services.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:provider/provider.dart';

import 'package:paper_recycling_shopper/constants/global_variables.dart';
import 'package:paper_recycling_shopper/providers/user_provider.dart';

class ProductDetail extends StatefulWidget {
  static const routeName = '/product-details';
  final Product product;
  const ProductDetail({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  State<ProductDetail> createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  final HomeServices homeServices = HomeServices();
  final OrderServices orderServices = OrderServices();
  final ReviewServices reviewServices = ReviewServices();
  late Future<List<Product>> relatedProducts;
  late Future<List<Review>> reviews;

  @override
  void initState() {
    //print(widget.product.id);
    super.initState();
    relatedProducts = homeServices.fetchProducts(
        context: context,
        page: 0,
        limit: 10,
        categoryId: widget.product.categoryId);

    reviews = reviewServices.fetchReviews(
      context: context,
      page: 0,
      limit: 10,
      productId: widget.product.id,
    );
  }

  void addProductToCart() async {
    await orderServices
        .createOrder(
            context: context, productId: widget.product.id, quantity: 1)
        .whenComplete(() => PersistentNavBarNavigator.pushNewScreen(context,
            screen: const CartScreen()));

    // Navigator.pushNamedAndRemoveUntil(
    //             context, CartScreen.routeName, (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;

    return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: CustomAppBar(user: user),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CarouselSlider(
                items: widget.product.images!.split(',').map(
                  (i) {
                    return Builder(
                      builder: (BuildContext context) => Image.network(
                        i,
                        fit: BoxFit.contain,
                        height: 200,
                      ),
                    );
                  },
                ).toList(),
                options: CarouselOptions(
                  viewportFraction: 1,
                  height: 410,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text(
                  widget.product.name!,
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 5),
                child: RatingBar.builder(
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
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text(
                  '${widget.product.price} PP',
                  style: TextStyle(
                      color: GlobalVariables.primaryColor.withOpacity(1),
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Padding(
                padding: EdgeInsets.only(left: 10),
                child: Text("Product Description",
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              ),
              const SizedBox(
                height: 5,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text(
                  widget.product.description!,
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Padding(
                padding: EdgeInsets.only(left: 10),
                child: Text("You might also like",
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              ),
              const SizedBox(
                height: 5,
              ),
              SizedBox(
                height: 250,
                child: FutureBuilder(
                  future: relatedProducts,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      //take the list of related products except this product.
                      var productList = [...snapshot.data!];
                      productList.removeWhere((product) =>
                          product.categoryId == widget.product.categoryId);

                      return ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
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
              const SizedBox(
                height: 10,
              ),
              const Padding(
                padding: EdgeInsets.only(left: 10),
                child: Text("Reviews",
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              ),
              SizedBox(
                child: FutureBuilder(
                  future: reviews,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      if (snapshot.data!.isEmpty) {
                        return const Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Center(
                              child:
                                  Text("No one reviewed this product before.")),
                        );
                      }
                      return ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: snapshot.data?.length,
                        itemBuilder: (context, index) {
                          return ReviewCard(
                            context: context,
                            review: snapshot.data![index],
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
            ],
          ),
        ),
        persistentFooterButtons: [
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: ElevatedButton(
                  onPressed: () => addProductToCart(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        GlobalVariables.primaryColor.withOpacity(1),
                    fixedSize: const Size(330, 60),
                  ),
                  child: const Text("Buy Now", style: TextStyle(fontSize: 16)),
                ),
              ),
            ),
          ),
        ]);
  }
}
