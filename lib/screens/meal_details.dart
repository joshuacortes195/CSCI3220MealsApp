import 'package:flutter/material.dart'; 
import 'package:flutter_riverpod/flutter_riverpod.dart'; 

import 'package:meals_app/models/meal.dart'; 
import 'package:meals_app/providers/favorites_provider.dart'; 

// screen that shows everything about one meal
class MealDetailsScreen extends ConsumerWidget { 
  const MealDetailsScreen({
    super.key,
    required this.meal, // the meal to show
  });

  final Meal meal;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favoriteMeals = ref.watch(favoriteMealsProvider); // watches favorites so the star updates

    final isFavorite = favoriteMeals.contains(meal); 

    return Scaffold(
        appBar: AppBar(title: Text(meal.title), actions: [
          // star button in the app bar
          IconButton(
            onPressed: () {
              // adds or removes the meal, and returns true if it was added
              final wasAdded = ref
                  .read(favoriteMealsProvider.notifier)
                  .toggleMealFavoriteStatus(meal);
              ScaffoldMessenger.of(context).clearSnackBars(); // removes any old message first
              // small message at the bottom telling the user what happened
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                      wasAdded ? 'Meal added as a favorite.' : 'Meal removed.'),
                ),
              );
            },
            // animates the star when it switches between filled and empty
            icon: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              // makes the star rotate in
              transitionBuilder: (child, animation) {
                return RotationTransition(
                  turns: Tween<double>(begin: 0.8, end: 1).animate(animation),
                  child: child,
                );
              },
              child: Icon(
                isFavorite ? Icons.star : Icons.star_border, // filled star if favorite
                key: ValueKey(isFavorite), // key tells flutter the icon changed so it animates
              ),
            ),
          )
        ]),
        // scrollable so long recipes still fit
        body: SingleChildScrollView(
          child: Column(
            children: [
              // picture that animates from the list into this screen
              Hero(
                tag: meal.id, // same tag as the list item so flutter connects them
                child: Image.network(
                  meal.imageUrl,
                  height: 300,
                  width: double.infinity, // full width
                  fit: BoxFit.cover, // fills the space without stretching
                ),
              ),
              const SizedBox(height: 14),
              // ingredients section
              Text(
                'Ingredients',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.bold,
                    ), // styling for the section heading
              ),
              const SizedBox(height: 14),
              // one line of text for each ingredient
              for (final ingredient in meal.ingredients)
                Text(
                  ingredient,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: Theme.of(context).colorScheme.onBackground,
                      ), // styling for the ingredient text
                ),
              const SizedBox(height: 24),
              // steps section
              Text(
                'Steps',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.bold,
                    ), // styling for the section heading
              ),
              const SizedBox(height: 14),
              // one centered paragraph for each step
              for (final step in meal.steps)
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ), // space around each step
                  child: Text(
                    step,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: Theme.of(context).colorScheme.onBackground,
                        ), // styling for the step text
                  ),
                ),
            ],
          ),
        ));
  }
}