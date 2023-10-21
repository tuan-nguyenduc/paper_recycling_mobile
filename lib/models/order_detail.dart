// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:paper_recycling_shopper/models/product.dart';

class OrderDetail {
  int? id;
  int? orderId;
  int? productId;
  int? quantity;
  int? price;
  String? createdAt;
  String? updatedAt;
  Product? product;
  OrderDetail({
    this.id,
    this.orderId,
    this.productId,
    this.quantity,
    this.price,
    this.createdAt,
    this.updatedAt,
    this.product,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'orderId': orderId,
      'productId': productId,
      'quantity': quantity,
      'price': price,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'product': product?.toMap(),
    };
  }

  factory OrderDetail.fromMap(Map<String, dynamic> map) {
    return OrderDetail(
      id: map['id'] != null ? map['id'] as int : null,
      orderId: map['orderId'] != null ? map['orderId'] as int : null,
      productId: map['productId'] != null ? map['productId'] as int : null,
      quantity: map['quantity'] != null ? map['quantity'] as int : null,
      price: map['price'] != null ? map['price'] as int : null,
      createdAt: map['createdAt'] != null ? map['createdAt'] as String : null,
      updatedAt: map['updatedAt'] != null ? map['updatedAt'] as String : null,
      product: map['product'] != null ? Product.fromMap(map['product'] as Map<String,dynamic>) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory OrderDetail.fromJson(String source) => OrderDetail.fromMap(json.decode(source) as Map<String, dynamic>);
}
