// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:paper_recycling_shopper/models/order_detail.dart';
import 'package:paper_recycling_shopper/models/user.dart';

class Order {
  int? id;
  int? status;
  int? amount;
  int? userId;
  String? createdAt;
  String? updatedAt;
  List<OrderDetail>? orderDetails;
  User? user;
  Order({
    this.id,
    this.status,
    this.amount,
    this.userId,
    this.createdAt,
    this.updatedAt,
    this.orderDetails,
    this.user,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'status': status,
      'amount': amount,
      'userId': userId,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'orderDetails': orderDetails!.map((x) => x.toMap()).toList(),
      'user': user?.toMap(),
    };
  }

  factory Order.fromMap(Map<String, dynamic> map) {
    return Order(
      id: map['id'] != null ? map['id'] as int : null,
      status: map['status'] != null ? map['status'] as int : null,
      amount: map['amount'] != null ? map['amount'] as int : null,
      userId: map['userId'] != null ? map['userId'] as int : null,
      createdAt: map['createdAt'] != null ? map['createdAt'] as String : null,
      updatedAt: map['updatedAt'] != null ? map['updatedAt'] as String : null,
      orderDetails: map['orderDetails'] != null ? List<OrderDetail>.from((map['orderDetails'] as List<dynamic>).map<OrderDetail?>((x) => OrderDetail.fromMap(x as Map<String,dynamic>),),) : null,
      user: map['user'] != null ? User.fromMap(map) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Order.fromJson(String source) => Order.fromMap(json.decode(source) as Map<String, dynamic>);
}
