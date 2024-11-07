import 'package:cloud_firestore/cloud_firestore.dart';

class Product {
  final String name;
  final String imageUrl;
  final double price;
  final double rating;
  final int reviews;

  Product({
    required this.name,
    required this.imageUrl,
    required this.price,
    required this.rating,
    required this.reviews,
  });


  factory Product.fromDocument(DocumentSnapshot doc) {
    return Product(
      name: doc['name'],
      imageUrl: doc['imageUrl'],
      price: doc['price'].toDouble(),
      rating: doc['rating'].toDouble(),
      reviews: doc['reviews'],
    );
  }
}
