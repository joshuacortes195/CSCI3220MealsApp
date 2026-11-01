import 'package:flutter_riverpod/legacy.dart';
import 'package:meals_app/data/dummy_data.dart';
import 'package:meals_app/data/favorites_db.dart' as favorites_db;
import 'package:meals_app/models/meal.dart';

// keeps track of which meals are favorites
class FavoriteMealsNotifier extends StateNotifier<List<Meal>> {
  FavoriteMealsNotifier() : super([]);

  // pulls the saved favorites out of sqlite when the app starts
  Future<void> loadFavorites() async {
    final ids = await favorites_db.loadFavoriteIds();
    final mealsById = {for (final meal in dummyMeals) meal.id: meal}; // quick lookup from id to meal
    state = [
      for (final id in ids)
        if (mealsById[id] != null) mealsById[id]!,
    ];
  }

  // adds or removes a meal from favorites, returns true if it got added
  bool toggleMealFavoriteStatus(Meal meal) {
    final mealIsFavorite = state.contains(meal);

    // already a favorite so take it out
    if (mealIsFavorite) {
      removeFavorite(meal);
      return false;
    } else {
      state = [...state, meal]; // adds the meal to the end of the list
      favorites_db.addFavorite(meal.id); // saves it so it's still there next time
      return true;
    }
  }

  // takes one meal out of favorites and out of the database
  void removeFavorite(Meal meal) {
    state = state.where((m) => m.id != meal.id).toList();
    favorites_db.removeFavorite(meal.id);
  }

  // wipes all favorites from the list and the database
  void clearFavorites() {
    state = [];
    favorites_db.clearFavorites();
  }
}

// lets any screen read or change the favorites list
final favoriteMealsProvider =
    StateNotifierProvider<FavoriteMealsNotifier, List<Meal>>((ref) {
  return FavoriteMealsNotifier()..loadFavorites(); // loads saved favorites right away
});
