// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:paper_recycling_shopper/models/user.dart';

class Review {
  int? id;
  String? content;
  int? userId;
  int? productId;
  int? rating;
  String? createdAt;
  String? updated;
  User user;
  Review({
    this.id,
    this.content,
    this.userId,
    this.productId,
    this.rating,
    this.createdAt,
    this.updated,
    required this.user,
  });
  


  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'content': content,
      'userId': userId,
      'productId': productId,
      'rating': rating,
      'createdAt': createdAt,
      'updated': updated,
      'user': user.toMap(),
    };
  }

  factory Review.fromMap(Map<String, dynamic> map) {
    return Review(
      id: map['id'] != null ? map['id'] as int : null,
      content: map['content'] != null ? map['content'] as String : null,
      userId: map['userId'] != null ? map['userId'] as int : null,
      productId: map['productId'] != null ? map['productId'] as int : null,
      rating: map['rating'] != null ? map['rating'] as int : null,
      createdAt: map['createdAt'] != null ? map['createdAt'] as String : null,
      updated: map['updated'] != null ? map['updated'] as String : null,
      user: User.fromMap(map),
    );
  }

  String toJson() => json.encode(toMap());

  factory Review.fromJson(String source) => Review.fromMap(json.decode(source) as Map<String, dynamic>);
}
