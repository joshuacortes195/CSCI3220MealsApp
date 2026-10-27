import 'package:flutter/material.dart'; 
import 'package:meals_app/data/dummy_data.dart';
import 'package:meals_app/models/meal.dart'; 
import 'package:meals_app/widgets/category_grid_item.dart';
import 'package:meals_app/screens/meals.dart'; 
import 'package:meals_app/models/category.dart'; 

// screen that shows the grid of food categories
class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({
    super.key,
    required this.availableMeals, // meals left after the filters are applied
  });

  final List<Meal> availableMeals;

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

// stateful because it runs a slide in animation
class _CategoriesScreenState extends State<CategoriesScreen>
    with SingleTickerProviderStateMixin { // lets the animation sync with the screen refresh
  late AnimationController _animationController; // controls the animation, set up in initState

  @override
  void initState() {
    super.initState();

    // sets up a 300ms animation that goes from 0 to 1
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
      lowerBound: 0,
      upperBound: 1,
    );

    _animationController.forward(); // starts the animation as soon as the screen loads
  }

  @override
  void dispose() {
    _animationController.dispose(); // cleans up the animation so it doesn't leak memory
    super.dispose();
  }

  // runs when a category tile is tapped
  void _selectCategory(BuildContext context, Category category) {
    // keeps only the meals that belong to the tapped category
    final filteredMeals = widget.availableMeals
        .where((meal) => meal.categories.contains(category.id))
        .toList();

    // opens the meals screen with those meals
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => MealsScreen(
          title: category.title,
          meals: filteredMeals,
        ),
      ),
    ); // Navigator.push(context, route)
  }

  @override
  Widget build(BuildContext context) {
    // rebuilds every time the animation value changes
    return AnimatedBuilder(
      animation: _animationController,
      // the grid is passed as child so it isn't rebuilt on every animation frame
      child: GridView(
        padding: const EdgeInsets.all(24), // space around the grid
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
        ),
        children: [
          // availableCategories.map((category) => CategoryGridItem(category: category)).toList()
          // makes one tile for every category in the dummy data
          for (final category in availableCategories)
            CategoryGridItem(
              category: category,
              onSelectCategory: () {
                _selectCategory(context, category); // open this category's meals
              },
            )
        ],
      ),
      // slides the grid up from slightly below its final spot
      builder: (context, child) => SlideTransition(
        position: Tween(
          begin: const Offset(0, 0.3), 
          end: const Offset(0, 0), 
        ).animate(
          CurvedAnimation(
            parent: _animationController,
            curve: Curves.easeInOut, // starts and ends slowly
          ),
        ),
        child: child,
      ),
    );
  }
}