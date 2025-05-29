import 'package:flutter/material.dart';

class Review {
  final String id;
  final String userId;
  final String userName;
  final String comment;
  final double rating;
  final DateTime date;
  final String? reply;
  final DateTime? replyDate;

  Review({
    required this.id,
    required this.userId,
    required this.userName,
    required this.comment,
    required this.rating,
    required this.date,
    this.reply,
    this.replyDate,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'userName': userName,
      'comment': comment,
      'rating': rating,
      'date': date.toIso8601String(),
      'reply': reply,
      'replyDate': replyDate?.toIso8601String(),
    };
  }

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      id: json['id'] as String,
      userId: json['userId'] as String,
      userName: json['userName'] as String,
      comment: json['comment'] as String,
      rating: (json['rating'] as num).toDouble(),
      date: DateTime.parse(json['date'] as String),
      reply: json['reply'] as String?,
      replyDate: json['replyDate'] != null ? DateTime.parse(json['replyDate'] as String) : null,
    );
  }
}

class Destination {
  final String id;
  final String name;
  final String description;
  final String location;
  final String category;
  final double rating;
  final double price;
  final String imageUrl;
  final List<String> images;
  final double latitude;
  final double longitude;
  final List<String> categories;
  final List<String> facilities;
  final List<Review> reviews;
  final String website;
  final String phone;
  final String email;
  final Map<String, String> openingHours;

  Destination({
    required this.id,
    required this.name,
    required this.description,
    required this.location,
    required this.category,
    required this.rating,
    required this.price,
    required this.imageUrl,
    required this.images,
    required this.latitude,
    required this.longitude,
    this.categories = const [],
    this.facilities = const [],
    this.reviews = const [],
    this.website = '',
    this.phone = '',
    this.email = '',
    this.openingHours = const {},
  });

  Destination copyWith({
    String? id,
    String? name,
    String? description,
    String? location,
    String? category,
    double? rating,
    double? price,
    String? imageUrl,
    List<String>? images,
    double? latitude,
    double? longitude,
    List<String>? categories,
    List<String>? facilities,
    List<Review>? reviews,
    String? website,
    String? phone,
    String? email,
    Map<String, String>? openingHours,
  }) {
    return Destination(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      location: location ?? this.location,
      category: category ?? this.category,
      rating: rating ?? this.rating,
      price: price ?? this.price,
      imageUrl: imageUrl ?? this.imageUrl,
      images: images ?? this.images,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      categories: categories ?? this.categories,
      facilities: facilities ?? this.facilities,
      reviews: reviews ?? this.reviews,
      website: website ?? this.website,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      openingHours: openingHours ?? this.openingHours,
    );
  }

  factory Destination.fromJson(Map<String, dynamic> json) {
    return Destination(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      location: json['location'] as String,
      category: json['category'] as String,
      rating: (json['rating'] as num).toDouble(),
      price: (json['price'] as num).toDouble(),
      imageUrl: json['imageUrl'] as String,
      images: List<String>.from(json['images'] as List),
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      categories: List<String>.from(json['categories'] as List? ?? []),
      facilities: List<String>.from(json['facilities'] as List? ?? []),
      reviews: (json['reviews'] as List? ?? []).map((e) => Review.fromJson(e as Map<String, dynamic>)).toList(),
      website: json['website'] as String? ?? '',
      phone: json['phone'] as String? ?? '',
      email: json['email'] as String? ?? '',
      openingHours: Map<String, String>.from(json['openingHours'] as Map? ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'location': location,
      'category': category,
      'rating': rating,
      'price': price,
      'imageUrl': imageUrl,
      'images': images,
      'latitude': latitude,
      'longitude': longitude,
      'categories': categories,
      'facilities': facilities,
      'reviews': reviews.map((e) => e.toJson()).toList(),
      'website': website,
      'phone': phone,
      'email': email,
      'openingHours': openingHours,
    };
  }
} 