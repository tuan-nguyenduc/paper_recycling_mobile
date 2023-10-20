// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:paper_recycling_shopper/constants/error_handling.dart';
import 'package:paper_recycling_shopper/constants/global_variables.dart';
import 'package:paper_recycling_shopper/models/review.dart';
import 'package:paper_recycling_shopper/providers/user_provider.dart';
import 'package:provider/provider.dart';


class ReviewServices {
  Future<List<Review>> fetchReviews ({
    required BuildContext context,
    int? page,
    int? limit,
    int? productId,
    int? userId,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<Review> reviewList = [];
    try {
      String url = '$API_URL/reviews';
      if (page != null) {
        url += '?page=$page';
      }
      if (limit != null) {
        url += '&limit=$limit';
      }
      if (productId != null) {
        url += '&productId=$productId';
      }
      if (userId != null) {
        url += '&userId=$userId';
      }

      http.Response res = await http.get(Uri.parse(url), headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ${userProvider.user.token}',
      });
      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
            for (int i = 0;
                i < jsonDecode(res.body)['data']['contents'].length;
                i++) {
              reviewList.add(Review.fromJson(
                  jsonEncode(jsonDecode(res.body)['data']['contents'][i])));
              // print(
              //     Review.fromJson(
              //     jsonEncode(jsonDecode(res.body)['data']['contents'][i])).toJson());
            }
          });
          // print(reviewList);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
        ),
      );
    }
    return reviewList;
  }
}

