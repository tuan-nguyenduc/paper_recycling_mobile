// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Category {
  int? id;
  String? name;
  String? description;
  int? status;
  String? image;
  String? createdAt;
  String? updatedAt;
  
  Category({
    this.id,
    this.name,
    this.description,
    this.status,
    this.image,
    this.createdAt,
    this.updatedAt,
  });


  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'description': description,
      'status': status,
      'image': image,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  factory Category.fromMap(Map<String, dynamic> map) {
    return Category(
      id: map['id'] != null ? map['id'] as int : null,
      name: map['name'] != null ? map['name'] as String : null,
      description: map['description'] != null ? map['description'] as String : null,
      status: map['status'] != null ? map['status'] as int : null,
      image: map['image'] != null ? map['image'] as String : null,
      createdAt: map['createdAt'] != null ? map['createdAt'] as String : null,
      updatedAt: map['updatedAt'] != null ? map['updatedAt'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Category.fromJson(String source) => Category.fromMap(json.decode(source) as Map<String, dynamic>);
}
