// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:paper_recycling_shopper/common/custom_appbar.dart';
import 'package:paper_recycling_shopper/features/home/services/home_services.dart';
import 'package:paper_recycling_shopper/features/home/widgets/product_card.dart';
import 'package:paper_recycling_shopper/models/product.dart';
import 'package:paper_recycling_shopper/models/user.dart';
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
  late Future<List<Product>> relatedProducts;

  @override
  void initState() {
    print(widget.product.categoryId);
    super.initState();
    relatedProducts = homeServices.fetchProducts(
        context: context,
        page: 0,
        limit: 10,
        categoryId: widget.product.categoryId);
    print(relatedProducts);
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
                  itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
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
                padding: const EdgeInsets.only(left: 10),
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
                padding: const EdgeInsets.only(left: 10),
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
                      print(productList.toString());
                      productList.removeWhere((product) =>
                          product.categoryId == widget.product.categoryId);

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
              const SizedBox(
                height: 10,
              ),
              const Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text("Reviews",
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 100,
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
                  child: Text("hello")
                ),
              ),
            ],
          ),
        ),
        persistentFooterButtons: [
          Align(
            alignment: Alignment.bottomCenter,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: GlobalVariables.primaryColor.withOpacity(1),
                  fixedSize: const Size(330, 60),
                ),
                child: const Text("Buy Now"),
              ),
            ),
          ),
        ]);
  }
}
