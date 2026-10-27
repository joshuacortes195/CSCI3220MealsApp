import 'package:flutter/material.dart';

// blueprint for a meal category 
class Category {
  const Category({
    required this.id,
    required this.title,
    this.color = Colors.orange, // defaults to orange 
  });

  final String id; // unique id we use to match meals to this category
  final String title; // name shown on the category tile
  final Color color; // color used for the tile gradient
}
