import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class Product {
  int id;
  String? name;
  int? price;
  String? description;
  String? images;
  int? quantity;
  int? status;
  String? createdAt;
  String? updatedAt;
  int? categoryId;
  Product({
    required this.id,
    this.name,
    this.price,
    this.description,
    this.images,
    this.quantity,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.categoryId,
  });


  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'price': price,
      'description': description,
      'images': images,
      'quantity': quantity,
      'status': status,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'categoryId': categoryId,
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id'] as int,
      name: map['name'] != null ? map['name'] as String : null,
      price: map['price'] != null ? map['price'] as int : null,
      description: map['description'] != null ? map['description'] as String : null,
      images: map['images'] != null ? map['images'] as String : null,
      quantity: map['quantity'] != null ? map['quantity'] as int : null,
      status: map['status'] != null ? map['status'] as int : null,
      createdAt: map['createdAt'] != null ? map['createdAt'] as String : null,
      updatedAt: map['updatedAt'] != null ? map['updatedAt'] as String : null,
      categoryId: map['categoryId'] != null ? map['categoryId'] as int : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Product.fromJson(String source) => Product.fromMap(json.decode(source) as Map<String, dynamic>);
}
