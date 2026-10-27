import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:meals_app/data/dummy_data.dart';

// Provides the available meals.
final mealsProvider = Provider((ref) {
  return dummyMeals;
});