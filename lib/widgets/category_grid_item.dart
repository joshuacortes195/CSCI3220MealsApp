import 'package:flutter/material.dart'; 

import 'package:meals_app/models/category.dart'; 

// one tappable tile in the categories grid
class CategoryGridItem extends StatelessWidget {
  const CategoryGridItem({
    super.key,
    required this.category,
    required this.onSelectCategory,
  });

  final Category category;
  final void Function() onSelectCategory;

  @override
  Widget build(BuildContext context) {
    // makes the whole tile tappable with a ripple effect
    return InkWell(
      onTap: onSelectCategory, // opens this category's meals
      splashColor: Theme.of(context).primaryColor, // ripple color
      borderRadius: BorderRadius.circular(16), 
      child: Container(
        padding: const EdgeInsets.all(16), 
        // rounded tile with a color gradient
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16), 
            gradient: LinearGradient(
              colors: [
                category.color.withOpacity(0.55), 
                category.color.withOpacity(0.9), 
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight, 
            )),
        child: Text(
          category.title,
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: Theme.of(context).colorScheme.onBackground,
              ), // styling for the category name
        ),
      ),
    );
  }
}