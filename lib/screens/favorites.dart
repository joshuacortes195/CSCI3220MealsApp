import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:meals_app/models/meal.dart';
import 'package:meals_app/providers/favorites_provider.dart';
import 'package:meals_app/screens/meal_details.dart';
import 'package:meals_app/widgets/meal_item.dart';

// screen that lists all the meals the user starred
class FavoritesScreen extends ConsumerWidget {
  const FavoritesScreen({
    super.key,
    this.showAppBar = false, // true when opened from the drawer instead of the tab
  });

  final bool showAppBar;

  // opens the details screen for the tapped meal
  void _selectMeal(BuildContext context, Meal meal) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => MealDetailsScreen(meal: meal),
      ),
    );
  }

  // runs after a meal gets swiped away
  void _removeMeal(BuildContext context, WidgetRef ref, Meal meal) {
    final favorites = ref.read(favoriteMealsProvider.notifier);
    favorites.removeFavorite(meal);
    ScaffoldMessenger.of(context).clearSnackBars(); // removes any old message first
    // tells the user it's gone and lets them undo it
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${meal.title} removed from favorites.'),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            favorites.toggleMealFavoriteStatus(meal); // puts the meal back
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favoriteMeals = ref.watch(favoriteMealsProvider); // watches favorites so the list updates

    // message shown when nothing has been starred yet
    Widget content = Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.star_border,
            size: 64,
            color: Theme.of(context).colorScheme.primary,
          ), // styling for the empty star
          const SizedBox(height: 16),
          Text(
            'No favorites yet',
            style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                  color: Theme.of(context).colorScheme.onSurface,
                ), // styling for the heading
          ),
          const SizedBox(height: 16),
          Text(
            'Tap the star on a meal to save it here.',
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  color: Theme.of(context).colorScheme.onSurface,
                ), // styling for the hint text
          ),
        ],
      ),
    );

    // list of favorite meals, each one can be swiped away
    if (favoriteMeals.isNotEmpty) {
      content = ListView.builder(
        itemCount: favoriteMeals.length,
        itemBuilder: (ctx, index) {
          final meal = favoriteMeals[index];
          return Dismissible(
            key: ValueKey(meal.id), // lets flutter know which card was swiped
            onDismissed: (direction) {
              _removeMeal(context, ref, meal);
            },
            // red delete background that shows while swiping
            background: Container(
              color: Theme.of(context).colorScheme.error.withValues(alpha: 0.75),
              margin: const EdgeInsets.all(8),
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: const Icon(Icons.delete, color: Colors.white, size: 32),
            ),
            direction: DismissDirection.endToStart, // swipe right to left only
            child: MealItem(
              meal: meal,
              onSelectMeal: (meal) {
                _selectMeal(context, meal);
              },
            ),
          );
        },
      );
    }

    // inside the tab, the tabs screen already has an app bar
    if (!showAppBar) {
      return content;
    }

    // when opened from the drawer it needs its own app bar
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Favorites'),
        actions: const [ClearFavoritesButton()],
      ),
      body: content,
    );
  }
}

// trash button in the app bar that clears every favorite
class ClearFavoritesButton extends ConsumerWidget {
  const ClearFavoritesButton({super.key});

  // asks the user to confirm before wiping everything
  Future<void> _confirmClear(BuildContext context, WidgetRef ref) async {
    final textColor = Theme.of(context).colorScheme.onSurface; // light text so it shows up on the dark dialog
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(
          'Clear all favorites?',
          style: Theme.of(context).textTheme.titleLarge!.copyWith(color: textColor),
        ), // styling for the dialog title
        content: Text(
          'This removes every saved meal from your favorites.',
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: textColor),
        ), // styling for the dialog message
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(true),
            child: const Text('Clear'),
          ),
        ],
      ),
    );
    // only clears if they hit the clear button
    if (confirmed == true) {
      ref.read(favoriteMealsProvider.notifier).clearFavorites();
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final hasFavorites = ref.watch(favoriteMealsProvider).isNotEmpty;

    return IconButton(
      tooltip: 'Clear all favorites',
      icon: const Icon(Icons.delete_sweep),
      onPressed: hasFavorites ? () => _confirmClear(context, ref) : null, // greyed out when there's nothing to clear
    );
  }
}
