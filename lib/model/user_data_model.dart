import 'package:cloud_firestore/cloud_firestore.dart';


class User {
  final String id;
  final String name;
  final String email;
  final String phoneNumber;
  final DateTime createdAt;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.createdAt,
  });


  factory User.fromDocument(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return User(
      id: doc.id,
      name: data['name'] ?? '',
      email: data['email'] ?? '',
      phoneNumber: data['phoneNumber'] ?? '',
      createdAt: (data['createdAt'] as Timestamp).toDate(),
    );
  }
}
