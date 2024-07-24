import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'rating.dart';

class Product extends Equatable {
  final int? id;
  final String? title;
  final double? price;
  final String? description;
  final String? category;
  final String? image;
  final Rating? rating;
  final Rating? count;
  final int quantity = 20;

  const Product({
    this.id,
    this.title,
    this.price,
    this.description,
    this.category,
    this.image,
    this.rating,
    this.count,
  });

  factory Product.fromMap(Map<String, dynamic> data) => Product(
        id: data['id'] as int?,
        title: data['title'] as String?,
        price: (data['price'] as num?)?.toDouble(),
        description: data['description'] as String?,
        category: data['category'] as String?,
        image: data['image'] as String?,
        rating:
            data['rating'] == null ? null : Rating.fromMap(data['rating'] as Map<String, dynamic>),
        count: data['count'] == null ? null : Rating.fromMap(data['count'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'title': title,
        'price': price,
        'description': description,
        'category': category,
        'image': image,
        'rating': rating?.toMap(),
        'count': count?.toMap(),
      };

  factory Product.fromJson(String data) {
    return Product.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  String toJson() => json.encode(toMap());

  Product copyWith({
    int? id,
    String? title,
    double? price,
    String? description,
    String? category,
    String? image,
    Rating? rating,
    Rating? count,
  }) {
    return Product(
      id: id ?? this.id,
      title: title ?? this.title,
      price: price ?? this.price,
      description: description ?? this.description,
      category: category ?? this.category,
      image: image ?? this.image,
      rating: rating ?? this.rating,
      count: count ?? this.count,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
    return [
      id,
      title,
      price,
      description,
      category,
      image,
      rating,
      count,
    ];
  }
}
