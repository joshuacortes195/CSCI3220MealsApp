import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:meals_app/providers/meals_provider.dart';

// the diet filters the user can switch on
enum Filter {
  glutenFree,
  lactoseFree,
  vegetarian,
  vegan,
}

// keeps track of which filters are on or off
class FiltersNotifier extends StateNotifier<Map<Filter, bool>> {
  FiltersNotifier()
      : super({
          // every filter starts off
          Filter.glutenFree: false,
          Filter.lactoseFree: false,
          Filter.vegetarian: false,
          Filter.vegan: false,
        });

  // swaps in a whole new set of filters at once
  void setFilters(Map<Filter, bool> chosenFilters) {
    state = chosenFilters;
  }

  // flips one filter on or off
  void setFilter(Filter filter, bool isActive) {
    // state[filter] = isActive; // not allowed! => mutating state
    // makes a fresh copy with the one filter changed so the screens rebuild
    state = {
      ...state,
      filter: isActive,
    };
  }
}

// lets any screen read or change the filters
final filtersProvider =
    StateNotifierProvider<FiltersNotifier, Map<Filter, bool>>(
  (ref) => FiltersNotifier(),
);

// only the meals that pass every filter that's switched on
final filteredMealsProvider = Provider((ref) {
  final meals = ref.watch(mealsProvider); // all the meals
  final activeFilters = ref.watch(filtersProvider); // which filters are on

  // drops any meal that breaks a filter that's switched on
  return meals.where((meal) {
    if (activeFilters[Filter.glutenFree]! && !meal.isGlutenFree) {
      return false;
    }
    if (activeFilters[Filter.lactoseFree]! && !meal.isLactoseFree) {
      return false;
    }
    if (activeFilters[Filter.vegetarian]! && !meal.isVegetarian) {
      return false;
    }
    if (activeFilters[Filter.vegan]! && !meal.isVegan) {
      return false;
    }
    return true; // passed every filter so it stays
  }).toList();
});